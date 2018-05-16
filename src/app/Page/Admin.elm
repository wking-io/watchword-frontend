module Page.Admin exposing (Model, Msg, init, update, view)

import View.Asset as Asset
import Data.Admin as Admin
import Data.FieldType as FieldType exposing (FieldType)
import Data.Size as Size exposing (Size)
import Data.Step as Step exposing (Step, Choice)
import Data.Option as Option exposing (Option)
import Data.Games as Games exposing (Games, Game)
import Data.Words as Words exposing (Words, Word)
import Data.Selection as Selection exposing (Selection)
import Data.Memory as Memory
import Request.Games
import Request.Words
import Route
import Html exposing (Html, program, text, div, ul, li, img, p, button, h1, h2, h3, main_, a, input, strong, label)
import Html.Attributes as Attr exposing (class, classList, type_, name, value, for)
import Html.Events exposing (onClick, onFocus)
import Page.Errored exposing (PageLoadError, pageLoadError)
import SelectList exposing (SelectList)
import View.Svg.GameIcon as GameIcon
import Util.Infix exposing ((=>))


-- MODEL --


type alias Model =
    { games : Games
    , words : Words
    , state : State
    }


type State
    = Summary (SelectList Game)
    | Setup (SelectList Game) Selection


init : Admin.Slug -> Bool -> Result PageLoadError Model
init slug isSetup =
    let
        handleLoadError _ =
            pageLoadError "Homepage is currently unavailable."

        base =
            Result.map3 Model
                Request.Games.get
                Request.Words.get
    in
        case slug of
            Admin.Init ->
                base
                    (Result.map Summary Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError

            Admin.WithGame id ->
                base
                    (Result.map (getState id isSetup Selection.Empty) Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError

            Admin.WithSetup id ->
                base
                    (Result.map (getState id isSetup Selection.Empty) Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError

            Admin.WithOption id option ->
                base
                    (Result.map (getState id isSetup (Selection.OptionOnly option)) Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError

            Admin.WithSize id option size ->
                base
                    (Result.map (getState id isSetup (Selection.OptionAndSize option size)) Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError

            Admin.WithWords id option size maybeWords ->
                let
                    selection =
                        case maybeWords of
                            Just words ->
                                Selection.Full option size words

                            Nothing ->
                                Selection.OptionAndSize option size
                in
                    base
                        (Result.map (getState id isSetup selection) Request.Games.getNav)
                        |> Result.mapError (Debug.log "Error: ")
                        |> Result.mapError handleLoadError


getState : String -> Bool -> Selection -> SelectList Game -> State
getState id isSetup selection games =
    let
        updatedGames =
            SelectList.select (Games.equals id) games
    in
        if isSetup then
            Setup updatedGames selection
        else
            Summary updatedGames



-- VIEW --


view : Model -> Html Msg
view model =
    case model.state of
        Summary games ->
            div [ class "admin-container" ]
                [ viewGameMenu games
                , viewGameSummary (SelectList.selected games)
                ]

        Setup games selection ->
            div [ class "admin-container" ]
                [ viewGameMenu games
                , viewSetup model.words (SelectList.selected games) selection
                ]


viewGameMenu : SelectList Game -> Html Msg
viewGameMenu games =
    div [ class "game-menu" ]
        [ h3 [ class "game-menu__title" ] [ text "Select A Game" ]
        , (viewGames games)
        ]


viewGames : SelectList Game -> Html Msg
viewGames games =
    ul [ class "no-list" ]
        (SelectList.mapBy viewGame games
            |> SelectList.toList
        )


viewGame : SelectList.Position -> Game -> Html Msg
viewGame position { id, name } =
    let
        gameLink isActive =
            li
                [ classList
                    [ ( "menu-item", True )
                    , ( "menu-item--active", isActive )
                    ]
                ]
                [ a [ class "menu-item__btn", Route.href (Route.AdminSelected (Admin.WithGame id)) ]
                    [ div [ class "menu-item__btn__icon" ] [ Maybe.withDefault (GameIcon.default isActive) (GameIcon.icons id isActive) ]
                    , text name
                    ]
                ]
    in
        case position of
            SelectList.Selected ->
                gameLink True

            _ ->
                gameLink False


viewGameSummary : Game -> Html Msg
viewGameSummary { id, name, description, skills } =
    main_ [ class "w100" ]
        [ div
            [ class "admin-content" ]
            [ div [ class "summary__header" ] [ img [ class "summary__header__img", Asset.src (Asset.summary id) ] [] ]
            , h1 [ class "summary__title" ] [ text name ]
            , p [ class "summary__description" ] [ text description ]
            , h2 [ class "summary__subheading" ] [ text "Skills Practiced" ]
            , ul [ class "summary__skill-list" ] (List.map viewSkill skills)
            , a [ Route.href (Route.AdminSetup (Admin.WithGame id)), class "summary__btn" ] [ text "Setup Game" ]
            ]
        ]


viewSkill : String -> Html Msg
viewSkill skill =
    li [ class "summary__skill-list__item" ] [ text skill ]


viewSetup : Words -> Game -> Selection -> Html Msg
viewSetup words game selection =
    case selection of
        Selection.Empty ->
            viewStep (viewStepNav game selection) (viewFields game.option) "Step One: Select Option" "option"

        Selection.OptionOnly option ->
            viewStep (viewStepNav game selection) (viewFields game.size) "Step Two: Select Word Count" "size"

        Selection.OptionAndSize option size ->
            viewStep (viewStepNav game selection) (viewWords option size words) "Step Three: Select Words" "words"

        Selection.Full option size wordSelection ->
            viewStep (viewStepNav game selection) (viewWords option size words) "Step Three: Select Words" "words"


viewStep : Html Msg -> Html Msg -> String -> String -> Html Msg
viewStep stepNav fields title stepId =
    main_ [ class ("w100 setup setup--" ++ stepId) ]
        [ div [ class "admin-content" ]
            [ h2 [ class "setup__heading" ] [ text title ]
            , fields
            , stepNav
            ]
        ]


viewStepNav : Game -> Selection -> Html Msg
viewStepNav { id, option, size, wordSelection } selection =
    case selection of
        Selection.Empty ->
            case option.answer of
                Just answer ->
                    case (Option.fromString answer) of
                        Ok o ->
                            viewStepNavHelp id False True (Route.AdminSetup (Admin.WithOption id o))

                        Err _ ->
                            viewStepNavHelp id False True (Route.AdminSetup (Admin.WithSetup id))

                Nothing ->
                    viewStepNavHelp id True True (Route.AdminSetup (Admin.WithSetup id))

        Selection.OptionOnly theOption ->
            case size.answer of
                Just answer ->
                    case (Size.fromString answer) of
                        Ok s ->
                            viewStepNavHelp id False False (Route.AdminSetup (Admin.WithSize id theOption s))

                        Err _ ->
                            viewStepNavHelp id False False (Route.AdminSetup (Admin.WithOption id theOption))

                Nothing ->
                    viewStepNavHelp id True False (Route.AdminSetup (Admin.WithOption id theOption))

        Selection.OptionAndSize theOption theSize ->
            if (List.isEmpty wordSelection) then
                viewStepNavHelp id True False (Route.AdminSetup (Admin.WithSize id theOption theSize))
            else
                viewStepNavHelp id False False (Route.AdminSetup (Admin.WithWords id theOption theSize (Just wordSelection)))

        Selection.Full theOption theSize words ->
            viewStepNavHelp id True False (Route.MemoryGame (Memory.Slug theOption theSize (Just words)))


viewStepNavHelp : String -> Bool -> Bool -> Route.Route -> Html Msg
viewStepNavHelp id isDisabled isBeginning route =
    div [ class "setup__nav" ]
        [ viewPrevAction id isBeginning
        , a [ class "btn btn--primary", Route.href route, Attr.disabled isDisabled ] [ text "Next Step" ]
        ]


viewPrevAction : String -> Bool -> Html Msg
viewPrevAction id isBeginning =
    if isBeginning then
        a [ class "btn btn--ghost", Route.href (Route.AdminSelected (Admin.WithGame id)) ] [ text "Overview" ]
    else
        button [ class "btn btn--ghost", onClick PrevStep ] [ text "Prev Step" ]


viewNextAction : String -> Bool -> Bool -> Html Msg
viewNextAction id isComplete isDisabled =
    if isComplete then
        a [ class "btn btn--primary", Route.href (Route.AdminSelected (Admin.WithGame id)), Attr.disabled isDisabled ] [ text "Play Game" ]
    else
        a [ class "btn btn--primary", onClick NextStep, Attr.disabled isDisabled ] [ text "Next Step" ]


viewWords : Option -> Size -> Words -> Html Msg
viewWords option size words =
    div [] []


viewFields : Step -> Html Msg
viewFields { fieldType, choices, answer } =
    case fieldType of
        FieldType.RadioHorizontal ->
            div [ class "field-wrapper field-wrapper--horizontal" ] (List.map (viewRadio answer) choices)

        FieldType.RadioVertical ->
            div [ class "field-wrapper field-wrapper--vertical" ] (List.map (viewRadio answer) choices)

        FieldType.WordSelect ->
            div [ class "" ] []

        FieldType.NotFound ->
            div [ class "" ] []


viewRadio : Maybe String -> Choice -> Html Msg
viewRadio maybeSelection { value, label, description } =
    let
        isSelected =
            maybeSelection
                |> Maybe.map ((==) value)
                |> Maybe.withDefault False

        uid =
            "setup-step-field"
    in
        Html.label
            [ for uid
            , onClick (UpdateSelection value)
            , Attr.classList
                [ ( "field", True )
                , ( "field--selected", isSelected )
                ]
            ]
            [ div [ class "field__header" ] [ img [ class "field__header__img", Asset.src (Asset.summary value) ] [] ]
            , input [ type_ "radio", name uid, Attr.value value, Attr.checked isSelected, onFocus (UpdateSelection value), class "visually-hidden" ] []
            , div [ class "field__content" ]
                [ p [ class "field__title" ] [ strong [] [ text label ] ]
                , p [ class "field__description" ] [ text description ]
                ]
            ]



-- UPDATE --


type Msg
    = NextStep
    | PrevStep
    | UpdateSelection String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NextStep ->
            { model | state = (updateNext model.state) } => Cmd.none

        PrevStep ->
            { model | state = (updatePrev model.state) } => Cmd.none

        UpdateSelection id ->
            { model | state = (updateAnswer id model.state) } => Cmd.none


updateAnswer : String -> State -> State
updateAnswer id state =
    case state of
        Summary _ ->
            state

        Setup games selection ->
            case selection of
                Selection.Empty ->
                    Setup (SelectList.mapBy (addAnswerToOption id) games) selection

                Selection.OptionOnly _ ->
                    Setup (SelectList.mapBy (addAnswerToSize id) games) selection

                Selection.OptionAndSize _ _ ->
                    Setup (SelectList.mapBy (addAnswerToWords id) games) selection

                Selection.Full _ _ _ ->
                    state


addAnswerToOption : String -> SelectList.Position -> Game -> Game
addAnswerToOption answer position game =
    if position == SelectList.Selected then
        answer
            |> Step.asAnswerIn game.option
            |> Games.asOptionIn game
    else
        game


addAnswerToSize : String -> SelectList.Position -> Game -> Game
addAnswerToSize answer position game =
    if position == SelectList.Selected then
        answer
            |> Step.asAnswerIn game.size
            |> Games.asSizeIn game
    else
        game


addAnswerToWords : String -> SelectList.Position -> Game -> Game
addAnswerToWords answer position game =
    if position == SelectList.Selected then
        Games.asWordSelectionIn game answer
    else
        game


updateNext : State -> State
updateNext state =
    case state of
        Summary _ ->
            state

        Setup games selection ->
            case selection of
                Selection.Empty ->
                    Setup games (next (SelectList.selected games |> .option |> .answer) selection)

                Selection.OptionOnly _ ->
                    Setup games (next (SelectList.selected games |> .size |> .answer) selection)

                Selection.OptionAndSize _ _ ->
                    Setup games (complete (SelectList.selected games |> .wordSelection) selection)

                Selection.Full _ _ _ ->
                    Setup games selection


next : Maybe String -> Selection -> Selection
next maybeAnswer selection =
    case maybeAnswer of
        Just answer ->
            case selection of
                Selection.Empty ->
                    Selection.addOption (Option.fromString answer)

                Selection.OptionOnly option ->
                    Selection.addSize option (Size.fromString answer)

                _ ->
                    selection

        Nothing ->
            selection


updatePrev : State -> State
updatePrev state =
    case state of
        Summary _ ->
            state

        Setup games selection ->
            case selection of
                Selection.Empty ->
                    Summary games

                Selection.OptionOnly _ ->
                    Setup games Selection.Empty

                Selection.OptionAndSize option _ ->
                    Setup games (Selection.OptionOnly option)

                Selection.Full option size _ ->
                    Setup games (Selection.OptionAndSize option size)


complete : List String -> Selection -> Selection
complete words selection =
    case selection of
        Selection.OptionAndSize option size ->
            Selection.Full option size words

        _ ->
            selection

module Page.Admin exposing (Model, Msg, init, update, view)

import View.Asset as Asset
import Data.Admin as Admin
import Data.FieldType as FieldType exposing (FieldType)
import Data.Size as Size exposing (Size)
import Data.Step as Step exposing (Step, Choice)
import Data.Option as Option exposing (Option)
import Data.Games as Games exposing (Games, Game, Answer)
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
                [ a [ class "menu-item__btn", Route.href (Route.Admin (Admin.WithGame id)) ]
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
            , a [ Route.href (Route.AdminSetup (Admin.WithSetup id)), class "summary__btn" ] [ text "Setup Game" ]
            ]
        ]


viewSkill : String -> Html Msg
viewSkill skill =
    li [ class "summary__skill-list__item" ] [ text skill ]


viewSetup : Words -> Game -> Selection -> Html Msg
viewSetup words game selection =
    case selection of
        Selection.Empty ->
            viewStep (viewStepNav game selection) (viewFields game.option game.answer) "Step One: Select Option" "option"

        Selection.OptionOnly option ->
            viewStep (viewStepNav game selection) (viewFields game.size game.answer) "Step Two: Select Word Count" "size"

        Selection.OptionAndSize option size ->
            case game.answer of
                Games.Multiple xs ->
                    viewStep (viewStepNav game selection) (viewWords option size xs words) "Step Three: Select Words" "words"

                _ ->
                    viewStep (viewStepNav game selection) (viewWords option size [] words) "Step Three: Select Words" "words"

        Selection.Full option size wordSelection ->
            viewStep (viewStepNav game selection) (viewWords option size wordSelection words) "Step Three: Select Words" "words"


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
viewStepNav { id, option, size, answer } selection =
    case selection of
        Selection.Empty ->
            case answer of
                Games.Single theAnswer ->
                    case (Option.fromString theAnswer) of
                        Ok o ->
                            viewStepNavHelp id False True (Route.Admin (Admin.WithGame id)) (Route.AdminSetup (Admin.WithOption id o))

                        Err _ ->
                            viewStepNavHelp id False True (Route.Admin (Admin.WithGame id)) (Route.AdminSetup (Admin.WithSetup id))

                _ ->
                    viewStepNavHelp id True True (Route.Admin (Admin.WithGame id)) (Route.AdminSetup (Admin.WithSetup id))

        Selection.OptionOnly theOption ->
            case answer of
                Games.Single theAnswer ->
                    case (Size.fromString theAnswer) of
                        Ok s ->
                            viewStepNavHelp id False False (Route.Admin (Admin.WithSetup id)) (Route.AdminSetup (Admin.WithSize id theOption s))

                        Err _ ->
                            viewStepNavHelp id False False (Route.Admin (Admin.WithSetup id)) (Route.AdminSetup (Admin.WithOption id theOption))

                _ ->
                    viewStepNavHelp id True False (Route.Admin (Admin.WithSetup id)) (Route.AdminSetup (Admin.WithOption id theOption))

        Selection.OptionAndSize theOption theSize ->
            case answer of
                Games.Multiple theAnswer ->
                    viewStepNavHelp id False False (Route.Admin (Admin.WithOption id theOption)) (Route.AdminSetup (Admin.WithWords id theOption theSize (Just theAnswer)))

                _ ->
                    viewStepNavHelp id True False (Route.Admin (Admin.WithOption id theOption)) (Route.AdminSetup (Admin.WithSize id theOption theSize))

        Selection.Full theOption theSize words ->
            viewStepNavHelp id True False (Route.Admin (Admin.WithOption id theOption)) (Route.MemoryGame (Memory.Slug theOption theSize (Just words)))


viewStepNavHelp : String -> Bool -> Bool -> Route.Route -> Route.Route -> Html Msg
viewStepNavHelp id isDisabled isBeginning prevRoute nextRoute =
    div [ class "setup__nav" ]
        [ viewPrevAction prevRoute isBeginning
        , a [ class "btn btn--primary", Route.href nextRoute, Attr.disabled isDisabled ] [ text "Next Step" ]
        ]


viewPrevAction : Route.Route -> Bool -> Html Msg
viewPrevAction route isBeginning =
    if isBeginning then
        a [ class "btn btn--ghost", Route.href route ] [ text "Overview" ]
    else
        button [ class "btn btn--ghost", Route.href route ] [ text "Prev Step" ]


viewWords : Option -> Size -> List String -> Words -> Html Msg
viewWords option size selected words =
    case option of
        Option.Random ->
            viewWordGroups (Words.getGroups words) selected ((List.length selected) == (Size.toInt size))

        Option.Custom ->
            viewAllWords (Words.getGroupWords words) selected ((List.length selected) == (Size.toInt size))


viewWordGroups : List String -> List String -> Bool -> Html Msg
viewWordGroups groups selected isMax =
    div [ class "field-wrapper field-wrapper--random" ] (List.map (viewCheck selected isMax) groups)


viewAllWords : List ( String, List Word ) -> List String -> Bool -> Html Msg
viewAllWords words selected isMax =
    div [ class "field-wrapper field-wrapper--custom" ] (List.map (viewGroupOfWords selected isMax) words |> List.concat)


viewGroupOfWords : List String -> Bool -> ( String, List Word ) -> List (Html Msg)
viewGroupOfWords selected isMax ( group, words ) =
    let
        values =
            List.map .name words
    in
        [ p [ class "group-heading" ] [ strong [] [ text group ] ]
        , div [ class "word--wrapper" ] (List.map (viewCheck selected isMax) values)
        ]


viewFields : Step -> Answer -> Html Msg
viewFields { fieldType, choices } answer =
    case fieldType of
        FieldType.RadioHorizontal ->
            div [ class "field-wrapper field-wrapper--horizontal" ] (List.map (viewRadio answer) choices)

        FieldType.RadioVertical ->
            div [ class "field-wrapper field-wrapper--vertical" ] (List.map (viewRadio answer) choices)

        FieldType.NotFound ->
            div [ class "" ] []


viewRadio : Answer -> Choice -> Html Msg
viewRadio answer { value, label, description } =
    let
        isSelected =
            case answer of
                Games.Single _ ->
                    True

                _ ->
                    False

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


viewWord : Maybe String -> Choice -> Html Msg
viewWord maybeSelection { value, label, description } =
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


viewCheck : List String -> Bool -> String -> Html Msg
viewCheck selected isMax value =
    let
        isSelected =
            List.member value selected

        uid =
            "setup-step-field"

        ( handleEvent, isDisabled ) =
            if isMax && (not isSelected) then
                ( NoOp, True )
            else
                ( UpdateSelection value, False )
    in
        Html.label
            [ for uid
            , onClick handleEvent
            , Attr.classList
                [ ( "word", True )
                , ( "word--selected", isSelected )
                , ( "word--disabled", isDisabled )
                ]
            ]
            [ input [ type_ "checkbox", name uid, Attr.value value, Attr.checked isSelected, onFocus handleEvent, class "visually-hidden" ] []
            , p [ class "word__value" ] [ text value ]
            ]



-- UPDATE --


type Msg
    = UpdateSelection String
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateSelection id ->
            { model | state = (updateAnswer id model.state) } => Cmd.none

        NoOp ->
            model => Cmd.none


updateAnswer : String -> State -> State
updateAnswer id state =
    case state of
        Summary _ ->
            state

        Setup games selection ->
            case selection of
                Selection.Empty ->
                    Setup (SelectList.mapBy (updateHelper Games.setSingle id) games) selection

                Selection.OptionOnly _ ->
                    Setup (SelectList.mapBy (updateHelper Games.setSingle id) games) selection

                Selection.OptionAndSize _ _ ->
                    Setup (SelectList.mapBy (updateHelper Games.setMultiple id) games) selection

                Selection.Full _ _ _ ->
                    state


updateHelper : (String -> Game -> Game) -> String -> SelectList.Position -> Game -> Game
updateHelper f answer position game =
    if position == SelectList.Selected then
        f answer game
    else
        game

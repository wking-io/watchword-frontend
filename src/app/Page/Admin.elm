module Page.Admin exposing (Model, Msg, init, update, view)

import View.Asset as Asset
import Data.Admin as Admin
import Data.FieldType as FieldType exposing (FieldType)
import Data.Games as Games exposing (Games, Game)
import Data.Step as Step exposing (Step, Option)
import Data.Words as Words exposing (Words, Word)
import Data.Memory.Setup as MemorySetup
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
    | Setup (SelectList Game) (SelectList Step)


type GameSetup
    = Memory MemorySetup.Setup


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
                    |> Result.mapError handleLoadError

            Admin.WithGame id ->
                base
                    (Result.map (getState id isSetup) Request.Games.getNav)
                    |> Result.mapError (Debug.log "Error: ")
                    |> Result.mapError handleLoadError


getState : String -> Bool -> SelectList Game -> State
getState id isSetup games =
    let
        updatedGames =
            SelectList.select (Games.equals id) games
    in
        if isSetup then
            Setup updatedGames
                (SelectList.selected updatedGames
                    |> Games.toSteps
                )
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

        Setup games setup ->
            div [ class "admin-container" ]
                [ viewGameMenu games
                , viewSetup (SelectList.selected setup)
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


viewSetup : Step -> Html Msg
viewSetup ({ id, name, fieldType, options, selection } as step) =
    main_ [ class ("setup setup--" ++ id) ]
        [ div [ class "admin-content" ]
            [ h2 [ class "setup__heading" ] [ text name ]
            , viewFields step
            , div []
                [ button [ onClick NextStep ] [ text "Prev Step" ]
                , button [ onClick PrevStep ] [ text "Next Step" ]
                ]
            ]
        ]


viewFields : Step -> Html Msg
viewFields { id, name, fieldType, options, selection } =
    case fieldType of
        FieldType.RadioHorizontal ->
            div [] (List.map (viewRadio id (Maybe.withDefault "" selection)) options)

        FieldType.RadioVertical ->
            div [] (List.map (viewRadio id (Maybe.withDefault "" selection)) options)

        FieldType.WordSelect ->
            div [] []

        FieldType.NotFound ->
            div [] []


viewRadio : String -> String -> Option -> Html Msg
viewRadio id maybeString { value, label, description } =
    Html.label [ for id, onClick (UpdateSelection value) ]
        [ input [ type_ "radio", name id, Attr.value value, onFocus (UpdateSelection value) ] []
        , p [] [ strong [] [ text label ] ]
        , p [] [ text description ]
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
            model => Cmd.none

        PrevStep ->
            model => Cmd.none

        UpdateSelection id ->
            { model | state = (updateSelection id model.state) } => Cmd.none


updateSelection : String -> State -> State
updateSelection id state =
    case state of
        Summary _ ->
            state

        Setup games steps ->
            Setup games (SelectList.mapBy (addSelection id) steps)


addSelection : String -> SelectList.Position -> Step -> Step
addSelection answer position step =
    if position == SelectList.Selected then
        { step | selection = Just answer }
    else
        step

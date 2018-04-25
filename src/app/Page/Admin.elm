module Page.Admin exposing (Model, Msg, init, update, view)

import View.Asset as Asset
import Data.Games as Games exposing (Games, Game)
import Data.Step as Step exposing (Step)
import Data.Words as Words exposing (Words, Word)
import Data.Memory.Setup as MemorySetup
import Request.Games
import Request.Words
import Html exposing (Html, program, text, div, ul, li, img, p, button, h1, h2, h3, main_)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (onClick)
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


init : Result PageLoadError Model
init =
    let
        handleLoadError _ =
            pageLoadError "Homepage is currently unavailable."
    in
        Result.map3 Model
            Request.Games.get
            Request.Words.get
            (Request.Games.getNav |> Result.map Summary)
            |> Result.mapError handleLoadError



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
            div [ class "game-menu" ]
                [ h3 [ class "game-menu__title" ] [ text "Select A Game" ]
                , (viewGames games)
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
                [ button [ class "menu-item__btn", onClick (SelectGame id) ]
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
            , button [ class "summary__btn", onClick StartSetup ] [ text "Setup Game" ]
            ]
        ]


viewSkill : String -> Html Msg
viewSkill skill =
    li [ class "summary__skill-list__item" ] [ text skill ]



-- UPDATE --


type Msg
    = SelectGame String
    | StartSetup


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectGame id ->
            case model.state of
                Summary games ->
                    { model | state = Summary (SelectList.select (Games.equals id) games) } => Cmd.none

                Setup games _ ->
                    { model | state = Summary (SelectList.select (Games.equals id) games) } => Cmd.none

        StartSetup ->
            case model.state of
                Summary games ->
                    { model | state = Setup games (Games.toSteps (SelectList.selected games)) } => Cmd.none

                Setup _ _ ->
                    model => Cmd.none

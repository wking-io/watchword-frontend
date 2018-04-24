module Page.Admin exposing (Model, Msg, init, update, view)

import View.Asset as Asset
import Data.Games as Games exposing (Games, Game)
import Data.Words as Words exposing (Words, Word)
import Data.Memory.Setup as MemorySetup
import Request.Games
import Request.Words
import Html exposing (Html, program, text, div, ul, li, img, p, button, h1, h2, main_)
import Html.Attributes exposing (classList)
import Page.Errored exposing (PageLoadError, pageLoadError)
import SelectList exposing (SelectList)
import Util.Infix exposing ((=>))


-- MODEL --


type alias Model =
    { games : Games
    , words : Words
    , state : State
    }


type State
    = Summary (SelectList Game)
    | Setup (SelectList Game) GameSetup


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
            (Request.Games.getSelectList |> Result.map Summary)
            |> Result.mapError (Debug.log "Help: ")
            |> Result.mapError handleLoadError



-- VIEW --


view : Model -> Html Msg
view model =
    case model.state of
        Summary games ->
            div [] (viewGames games)

        Setup games setup ->
            div [] (viewGames games)


viewGames : SelectList Game -> List (Html Msg)
viewGames games =
    SelectList.mapBy viewGame games
        |> SelectList.toList


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
                [ button [] [ text name ]
                ]
    in
        case position of
            SelectList.Selected ->
                gameLink True

            _ ->
                gameLink False


viewGameSummary : Game -> Html Msg
viewGameSummary { id, name, description, skills } =
    main_ []
        [ img [ Asset.src (Asset.summary id) ] []
        , h1 [] [ text name ]
        , p [] [ text description ]
        , h2 [] [ text "Skill Practiced" ]
        , ul [] (List.map viewSkill skills)
        ]


viewSkill : String -> Html Msg
viewSkill skill =
    li [] [ text skill ]



-- UPDATE --


type Msg
    = SelectGame String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectGame id ->
            case model.state of
                Summary games ->
                    { model | state = Summary (SelectList.select (Games.equals id) games) } => Cmd.none

                Setup games _ ->
                    { model | state = Summary (SelectList.select (Games.equals id) games) } => Cmd.none
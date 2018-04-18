module Page.Home exposing (Model, Msg, init, update, view)

import Data.Game as Game exposing (Game)
import Request.Games as Games
import Html exposing (Html, program, text, div, ul, li, img, p, a)
import Page.Errored exposing (PageLoadError, pageLoadError)
import Route


-- MODEL --


type alias Model =
    { games : List Game }


init : Result PageLoadError Model
init =
    let
        handleLoadError _ =
            pageLoadError "Homepage is currently unavailable."
    in
        Result.map Model Games.get
            |> Result.mapError handleLoadError



-- VIEW --


view : Model -> Html Msg
view model =
    div []
        [ ul [] (List.map viewGame model.games) ]


viewGame : Game -> Html Msg
viewGame game =
    li []
        [ a [ Route.href (Route.fromGame (Game.toSlug game)) ] [ text (Game.toString game) ]
        ]



-- UPDATE --


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

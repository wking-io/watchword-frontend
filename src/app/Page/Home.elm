module Page.Home exposing (Model, Msg, init, update, view)

import Data.Game as Game exposing (Game)
import Request.Games as Games
import Html exposing (Html, program, text, div, ul, li, img, p, a)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Route


-- MODEL --


type alias Model =
    { games : List Game }


init : ( Model, Cmd Msg )
init =
    case Games.get of
        Ok games ->
            ( Model games, Cmd.none )

        Err err ->
            let
                _ =
                    Debug.log "Error:" err
            in
                ( Model [], Cmd.none )



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

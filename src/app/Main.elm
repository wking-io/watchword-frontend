module Main exposing (main)

import Data.Card exposing (Card)
import Request.Words exposing (getDeck)
import Html exposing (Html, program, text, div, p)
import Html.Attributes as Html exposing (class)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Json.Decode as Decode
import MatchList exposing (MatchList)


-- MODEL --


type alias Model =
    { deck : MatchList Card }


init : ( Model, Cmd Msg )
init =
    ( Model (MatchList.fromList []), getDeck ShuffleDeck )



-- VIEW --


view : Model -> Html Msg
view model =
    div []
        (model.deck
            |> MatchList.map (\the -> p [] [ text the.word ])
            |> MatchList.toList
        )



-- UPDATE --


type Msg
    = ShuffleDeck (List Card)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Model -> Model
updateHelp msg model =
    case msg of
        ShuffleDeck cards ->
            Model (MatchList.fromList cards)



-- SUBSCRIPTIONS
-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }

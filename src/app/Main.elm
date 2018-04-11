module Main exposing (main)

import Data.Card as Card exposing (Card)
import Request.Words exposing (getDeck, getDeckBy)
import Html exposing (Html, program, text, div, p)
import Html.Attributes as Html exposing (class)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import MatchList exposing (MatchList)
import Time
import Util


-- MODEL --


type alias Model =
    { deck : MatchList Card }


init : ( Model, Cmd Msg )
init =
    ( Model (MatchList.fromList []), getDeckBy "un" ShuffleDeck )



-- VIEW --


view : Model -> Html Msg
view model =
    div []
        (model.deck
            |> MatchList.map (\the -> ( the.order, p [ onClick (SelectCard the.id) ] [ text the.word ] ))
            |> MatchList.toList
            |> List.sortBy Tuple.first
            |> List.map Tuple.second
        )



-- UPDATE --


type Msg
    = ShuffleDeck (List Card)
    | SelectCard String
    | CheckMatch


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShuffleDeck cards ->
            ( Model (MatchList.fromList cards), Cmd.none )

        SelectCard id ->
            let
                matchlist =
                    MatchList.select (Card.equalsId id) model.deck
            in
                if MatchList.isComparable matchlist then
                    ( { model | deck = matchlist }, Util.delay (Time.second * 2) CheckMatch )
                else
                    ( { model | deck = matchlist }, Cmd.none )

        CheckMatch ->
            ( { model | deck = MatchList.compare Card.equals model.deck }, Cmd.none )



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

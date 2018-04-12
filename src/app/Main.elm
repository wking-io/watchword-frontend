module Main exposing (main)

import Data.Card as Card exposing (Card)
import Request.Words exposing (getDeck, getDeckBy)
import Html exposing (Html, program, text, div, li, img)
import Html.Attributes exposing (class, classList)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import MatchList exposing (MatchList, Position(..))
import Time
import Util exposing ((=>))
import View.Asset exposing (src, cardBack)


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
            |> MatchList.mapBy viewCard
            |> MatchList.toList
            |> List.sortBy Tuple.first
            |> List.map Tuple.second
        )


viewCard : Position -> Card -> ( Int, Html Msg )
viewCard position card =
    ( card.order
    , li
        [ class "card__container"
        , onClick (SelectCard card.id)
        ]
        [ div
            [ classList
                [ "card" => True
                , "card—flipping" => position == SelectSolo || position == SelectTwo
                , "card—flipped" => position == SelectOne || position == Matched
                ]
            ]
            [ img [ class "card__back", src cardBack ] []
            , div [ class "card__front" ] [ text card.word ]
            ]
        ]
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

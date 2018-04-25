module Data.Games exposing (Games, Game, decoder, equals, toNav, toSteps)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Data.Step as Step exposing (Step)
import SelectList exposing (SelectList)


type Games
    = Games (List Game)


type alias Game =
    { id : String
    , name : String
    , description : String
    , skills : List String
    , steps : List Step
    }


decoder : Decoder Games
decoder =
    decode Games
        |> required "data" (Decode.list decodeGame)


decodeGame : Decoder Game
decodeGame =
    decode Game
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "description" Decode.string
        |> required "skills" (Decode.list Decode.string)
        |> required "steps" (Decode.list Step.decoder)


toNav : Games -> SelectList Game
toNav (Games games) =
    let
        sortedGames =
            List.sortBy .id games
    in
        case sortedGames of
            first :: rest ->
                SelectList.fromLists [] first rest

            [] ->
                SelectList.singleton emptyGame


toSteps : Game -> SelectList Step
toSteps { steps } =
    let
        sortedSteps =
            List.sortBy .id steps
    in
        case sortedSteps of
            first :: rest ->
                SelectList.fromLists [] first rest

            [] ->
                SelectList.singleton Step.empty


emptyGame : Game
emptyGame =
    Game "error" "No Games Found" "" [] []


equals : String -> Game -> Bool
equals string { id } =
    string == id

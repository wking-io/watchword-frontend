module Data.Games exposing (Games, Game, Answer(..), decoder, equals, toNav, setSingle, setMultiple)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, hardcoded)
import Data.Step as Step exposing (Step)
import SelectList exposing (SelectList)


type Games
    = Games (List Game)


type alias Game =
    { id : String
    , name : String
    , description : String
    , skills : List String
    , option : Step
    , size : Step
    , answer : Answer
    }


type Answer
    = Empty
    | Single String
    | Multiple (List String)


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
        |> required "option" Step.decoder
        |> required "size" Step.decoder
        |> hardcoded Empty


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


emptyGame : Game
emptyGame =
    Game "error" "No Games Found" "" [] Step.empty Step.empty Empty


equals : String -> Game -> Bool
equals string { id } =
    string == id


setSingle : String -> Game -> Game
setSingle answer game =
    case game.answer of
        Multiple _ ->
            game

        _ ->
            { game | answer = Single answer }


setMultiple : String -> Game -> Game
setMultiple answer game =
    case game.answer of
        Multiple xs ->
            let
                newAnswer =
                    if (List.member answer xs) then
                        List.filter ((/=) answer) xs
                    else
                        answer :: xs
            in
                if List.isEmpty newAnswer then
                    { game | answer = Empty }
                else
                    { game | answer = Multiple newAnswer }

        Empty ->
            { game | answer = Multiple [ answer ] }

        Single _ ->
            game

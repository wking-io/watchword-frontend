module Data.Games exposing (Games, Game, decoder, equals, toNav, setOption, asOptionIn, setSize, asSizeIn, setWordSelection, asWordSelectionIn)

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
    , wordSelection : List String
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
        |> required "option" Step.decoder
        |> required "size" Step.decoder
        |> hardcoded []


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
    Game "error" "No Games Found" "" [] Step.empty Step.empty []


equals : String -> Game -> Bool
equals string { id } =
    string == id


setOption : Step -> Game -> Game
setOption newStep game =
    { game | option = newStep }


asOptionIn : Game -> Step -> Game
asOptionIn game newStep =
    { game | option = newStep }


setSize : Step -> Game -> Game
setSize newStep game =
    { game | size = newStep }


asSizeIn : Game -> Step -> Game
asSizeIn game newStep =
    { game | size = newStep }


setWordSelection : String -> Game -> Game
setWordSelection newWord game =
    { game | wordSelection = newWord :: game.wordSelection }


asWordSelectionIn : Game -> String -> Game
asWordSelectionIn game newWord =
    { game | wordSelection = newWord :: game.wordSelection }

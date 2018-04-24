module Data.Games exposing (Games, Game, decoder, equals, toSelectList)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import SelectList exposing (SelectList)


type Games
    = Games (List Game)


type alias Game =
    { id : String
    , name : String
    , description : String
    , skills : List String
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


toSelectList : Games -> SelectList Game
toSelectList (Games games) =
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
    Game "error" "No Games Found" "" []


equals : String -> Game -> Bool
equals string { id } =
    string == id

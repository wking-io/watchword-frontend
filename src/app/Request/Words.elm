module Request.Words exposing (get, getDeck)

import Data.Word as Word exposing (Word)
import Data.Card as Card exposing (Card)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import Random exposing (Generator)


get : List Word
get =
    case decodeString (field "words" (Decode.list Word.decoder)) Json.data of
        Ok words ->
            words

        Err err ->
            let
                _ =
                    Debug.log "Error:" err
            in
                []


duplicate : List a -> List a
duplicate list =
    list ++ list


shuffleDeck : List Word -> Generator (List Card)
shuffleDeck words =
    let
        count =
            List.length words
    in
        Random.int 0 100
            |> Random.list count
            |> Random.map (List.map2 Card.fromWord words)
            |> Random.map (List.sortBy .order)


getDeck : (List Card -> msg) -> Cmd msg
getDeck msg =
    get
        |> duplicate
        |> shuffleDeck
        |> Random.generate msg

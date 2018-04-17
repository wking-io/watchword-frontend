module Request.Words exposing (get, getBy, getDeck, getDeckBy)

import Data.Word as Word exposing (Word)
import Data.Card as Card exposing (Card)
import Data.Group as Group exposing (Group)
import Dict exposing (Dict)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import Random exposing (Generator)
import Random.List exposing (shuffle)


getBase : Result String (Dict String (List Word))
getBase =
    decodeString (Decode.dict (Decode.list Word.decoder)) Json.data


get : List Word
get =
    case getBase of
        Ok words ->
            words
                |> Dict.values
                |> List.concat

        Err err ->
            let
                _ =
                    Debug.log "Error:" err
            in
                []


getBy : String -> Maybe (List Word)
getBy group =
    case getBase of
        Ok words ->
            words
                |> Dict.get group

        Err err ->
            let
                _ =
                    Debug.log "Error: " err
            in
                Nothing


getGroup : List Group
getGroup =
    case getBase of
        Ok words ->
            words
                |> Group.fromDict

        Err err ->
            let
                _ =
                    Debug.log "Error:" err
            in
                []


getDeck : (List Card -> msg) -> Cmd msg
getDeck msg =
    get
        |> duplicate
        |> shuffleDeck
        |> Random.generate msg


getDeckBy : String -> (List Card -> msg) -> Cmd msg
getDeckBy group msg =
    getBy group
        |> Maybe.withDefault []
        |> duplicate
        |> shuffleDeck
        |> Random.generate msg



-- HELPERS --


duplicate : List a -> List a
duplicate list =
    list ++ list


shuffleDeck : List Word -> Generator (List Card)
shuffleDeck words =
    let
        count =
            List.length words
    in
        List.range 0 count
            |> shuffle
            |> Random.map (List.map2 Card.fromWord words)

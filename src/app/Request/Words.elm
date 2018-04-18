module Request.Words exposing (getBase, get, getBy, getDeck, getDeckBy)

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
    decodeString (Decode.dict (Decode.list Word.decoder)) Json.words


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


getBy : List String -> List Word
getBy groups =
    case getBase of
        Ok words ->
            groups
                |> List.map (\group -> Dict.get group words)
                |> List.map (Maybe.withDefault [])
                |> List.concat

        Err err ->
            let
                _ =
                    Debug.log "Error: " err
            in
                []


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


getDeck : Generator (List Card)
getDeck =
    get
        |> duplicate
        |> shuffleDeck


getDeckBy : List String -> Generator (List Card)
getDeckBy group =
    getBy group
        |> duplicate
        |> shuffleDeck



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

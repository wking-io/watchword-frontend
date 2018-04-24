module Request.Words exposing (get, getBy, getDeck, getDeckBy)

import Data.Words as Words exposing (Words, Word)
import Data.Card as Card exposing (Card)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import Random exposing (Generator)
import Random.List exposing (shuffle)


get : Result String Words
get =
    decodeString Words.decoder Json.words


getBy : (Words -> Words) -> Result String Words
getBy pred =
    get
        |> Result.map pred


getDeck : Result String (Generator (List Card))
getDeck =
    get
        |> Result.map Words.duplicate
        |> Result.map shuffleDeck


getDeckBy : (Words -> Words) -> Result String (Generator (List Card))
getDeckBy pred =
    getBy pred
        |> Result.map Words.duplicate
        |> Result.map shuffleDeck



-- HELPERS --


shuffleDeck : Words -> Generator (List Card)
shuffleDeck words =
    List.range 0 (Words.length words)
        |> shuffle
        |> Random.map (List.map2 Card.fromWord (Words.toList words))

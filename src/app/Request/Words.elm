module Request.Words exposing (Response, Word, get, getOld, getDeck, getDeckBy)

import Api.Query as Query
import Api.Object
import Api.Object.Word as Word
import Graphqelm.Http
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Request.Base exposing (makeRequest)
import Task exposing (Task)
import Data.Card as Card exposing (Card)
import Data.Words as Words exposing (Words)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import Random exposing (Generator)
import Random.List exposing (shuffle)


type alias Response =
    List (Maybe Word)


type alias Word =
    { word : String
    , group : String
    , beginning : String
    , ending : String
    , vowel : String
    }


get : Task (Graphqelm.Http.Error (List Word)) (List Word)
get =
    Query.selection identity
        |> SelectionSet.with (Query.words getWord)
        |> makeRequest


getWord : SelectionSet Word Api.Object.Word
getWord =
    Word.selection Word
        |> with Word.word
        |> with Word.group
        |> with Word.beginning
        |> with Word.ending
        |> with Word.vowel


getOld : Result String Words
getOld =
    decodeString Words.decoder Json.words


getBy : (Words -> Words) -> Result String Words
getBy pred =
    getOld
        |> Result.map pred


getDeck : Result String (Generator (List Card))
getDeck =
    getOld
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
    (shuffle << Words.toList) words
        |> Random.map (List.indexedMap Card.fromWord)

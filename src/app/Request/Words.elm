module Request.Words exposing (get, getAll)

import Data.Word as Word exposing (Word)
import Data.Words as Words exposing (Words)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Watchword.Query as Query exposing (WordsOptionalArguments)
import Watchword.Object
import Watchword.Object.Word as Word
import Util.Maybe


-- import Data.Card as Card exposing (Card)
-- import Json
-- import Json.Decode as Decode exposing (decodeString, field)
-- import Random exposing (Generator)
-- import Random.List exposing (shuffle)


get : (WordsOptionalArguments -> WordsOptionalArguments) -> Field Words RootQuery
get with =
    Query.words with getWord
        |> Field.map (Words.fromList << Util.Maybe.forceList)


getAll : Field Words RootQuery
getAll =
    get identity


getWord : SelectionSet Word Watchword.Object.Word
getWord =
    Word.selection Word
        |> with Word.id
        |> with Word.word
        |> with Word.group
        |> with Word.beginning
        |> with Word.ending
        |> with Word.vowel



-- getOld : Result String Words
-- getOld =
--     decodeString Words.decoder Json.words
-- getBy : (Words -> Words) -> Result String Words
-- getBy pred =
--     getOld
--         |> Result.map pred
-- getDeck : Result String (Generator (List Card))
-- getDeck =
--     getOld
--         |> Result.map Words.duplicate
--         |> Result.map shuffleDeck
-- getDeckBy : (Words -> Words) -> Result String (Generator (List Card))
-- getDeckBy pred =
--     getBy pred
--         |> Result.map Words.duplicate
--         |> Result.map shuffleDeck
-- -- HELPERS --
-- shuffleDeck : Words -> Generator (List Card)
-- shuffleDeck words =
--     (shuffle << Words.toList) words
--         |> Random.map (List.indexedMap Card.fromWord)

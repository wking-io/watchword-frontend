module Request.Words exposing (get, getAll)

import Data.Word as Word exposing (Word)
import Data.Words as Words exposing (Words)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Watchword.Query as Query exposing (WordsOptionalArguments)
import Watchword.Object
import Watchword.Object.Word as ApiWord


get : (WordsOptionalArguments -> WordsOptionalArguments) -> Field Words RootQuery
get with =
    Query.words with getWord
        |> Field.map Words.fromList


getAll : Field Words RootQuery
getAll =
    get identity


getWord : SelectionSet Word Watchword.Object.Word
getWord =
    ApiWord.selection Word
        |> with ApiWord.id
        |> with ApiWord.word
        |> with ApiWord.group
        |> with ApiWord.beginning
        |> with ApiWord.ending
        |> with ApiWord.vowel

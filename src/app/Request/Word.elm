module Request.Word exposing (selection, on)

import Data.Word exposing (Word)
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import WatchWord.Object
import WatchWord.Object.Word


selection : SelectionSet Word WatchWord.Object.Word
selection =
    WatchWord.Object.Word.selection Word
        |> with WatchWord.Object.Word.id
        |> with WatchWord.Object.Word.word
        |> with WatchWord.Object.Word.group
        |> with WatchWord.Object.Word.beginning
        |> with WatchWord.Object.Word.ending
        |> with WatchWord.Object.Word.vowel


on : (SelectionSet Word WatchWord.Object.Word -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

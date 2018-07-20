module Request.Pattern exposing (selection, on)

import Data.Pattern exposing (Pattern)
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Select.Game as Game
import WatchWord.Object
import WatchWord.Object.Pattern


selection : SelectionSet Pattern WatchWord.Object.Pattern
selection =
    WatchWord.Object.Pattern.selection Pattern
        |> with WatchWord.Object.Pattern.pattern
        |> with WatchWord.Object.Pattern.name
        |> with WatchWord.Object.Pattern.description
        |> with WatchWord.Object.Pattern.focusType
        |> with (WatchWord.Object.Pattern.demo identity Game.id)


on : (SelectionSet Pattern WatchWord.Object.Pattern -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

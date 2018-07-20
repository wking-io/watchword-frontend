module Request.Game exposing (selection, on)

import Data.Game exposing (Game)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Select.Pattern as Pattern
import Request.Session as Session
import Request.Word as Word
import WatchWord.Object
import WatchWord.Object.Game


selection : SelectionSet Game WatchWord.Object.Game
selection =
    WatchWord.Object.Game.selection Game
        |> with WatchWord.Object.Game.id
        |> with WatchWord.Object.Game.createdAt
        |> with WatchWord.Object.Game.updatedAt
        |> with WatchWord.Object.Game.name
        |> with WatchWord.Object.Game.focus
        |> with WatchWord.Object.Game.size
        |> with (WatchWord.Object.Game.pattern identity Pattern.pattern)
        |> with (WatchWord.Object.Game.sessions identity Session.selection |> Field.map (Maybe.withDefault []))
        |> with (WatchWord.Object.Game.words identity |> Word.on |> Field.nonNullOrFail)


on : (SelectionSet Game WatchWord.Object.Game -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

module Request.Session exposing (selection, on)

import Data.Session exposing (Session)
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet exposing (SelectionSet, with)
import Request.Select.Game as Game
import WatchWord.Object
import WatchWord.Object.Session


selection : SelectionSet Session WatchWord.Object.Session
selection =
    WatchWord.Object.Session.selection Session
        |> with WatchWord.Object.Session.id
        |> with WatchWord.Object.Session.name
        |> with WatchWord.Object.Session.createdAt
        |> with WatchWord.Object.Session.updatedAt
        |> with WatchWord.Object.Session.complete
        |> with WatchWord.Object.Session.completedAt
        |> with (WatchWord.Object.Session.game identity Game.id)


on : (SelectionSet Session WatchWord.Object.Session -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

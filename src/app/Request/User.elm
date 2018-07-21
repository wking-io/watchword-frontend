module Request.User exposing (selection, on)

import Data.User exposing (UserRaw)
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import WatchWord.Object
import WatchWord.Object.User


selection : SelectionSet UserRaw WatchWord.Object.User
selection =
    WatchWord.Object.User.selection UserRaw
        |> with WatchWord.Object.User.email
        |> with WatchWord.Object.User.name
        |> with WatchWord.Object.User.createdAt
        |> with WatchWord.Object.User.updatedAt
        |> with WatchWord.Object.User.role


on : (SelectionSet UserRaw WatchWord.Object.User -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

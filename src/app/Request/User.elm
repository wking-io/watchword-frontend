module Request.User exposing (selection, on)

import Data.User exposing (User)
import Data.AuthToken as AuthToken
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import WatchWord.Object
import WatchWord.Object.User


selection : SelectionSet User WatchWord.Object.User
selection =
    WatchWord.Object.User.selection User
        |> with WatchWord.Object.User.email
        |> with WatchWord.Object.User.name
        |> with AuthToken.field
        |> with WatchWord.Object.User.createdAt
        |> with WatchWord.Object.User.updatedAt
        |> with WatchWord.Object.User.role


on : (SelectionSet User WatchWord.Object.User -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

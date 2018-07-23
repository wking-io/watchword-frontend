module Request.UserSession exposing (selection, on)

import Data.UserSession as UserSession exposing (UserSession)
import Graphqelm.Field exposing (Field)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Request.User as User
import WatchWord.Object


selection : SelectionSet UserSession WatchWord.Object.User
selection =
    User.selection
        |> SelectionSet.map UserSession.create


on : (SelectionSet UserSession WatchWord.Object.User -> Field decodesTo a) -> Field decodesTo a
on obj =
    obj selection

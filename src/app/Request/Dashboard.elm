module Request.Dashboard exposing (get, delete)

import Data.Games as Games exposing (Games)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Game as Game
import Graphqelm.Operation exposing (RootMutation, RootQuery)
import WatchWord.Query as Query
import WatchWord.Scalar exposing (Id)


get : SelectionSet Games RootQuery
get =
    Query.selection identity
        |> with (Query.games identity Game.selection)


delete : Id -> SelectionSet (Maybe Id) RootMutation
delete =
    Game.delete


archive : Id -> SelectionSet (Maybe Id) RootMutation
archive =
    Game.archive


restore : Id -> SelectionSet (Maybe Id) RootMutation
restore =
    Game.restore

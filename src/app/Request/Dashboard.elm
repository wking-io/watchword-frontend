module Request.Dashboard exposing (get)

import Data.Games as Games exposing (Games)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Game as Game
import Graphqelm.Operation exposing (RootQuery)
import WatchWord.Query as Query


get : SelectionSet Games RootQuery
get =
    Query.selection identity
        |> with (Query.games identity Game.selection)

module Request.Landing exposing (get)

import Data.Patterns exposing (Patterns)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Pattern as Pattern
import WatchWord.Query as Query


get : SelectionSet Patterns RootQuery
get =
    Query.selection identity
        |> with (Query.patterns identity Pattern.selection)

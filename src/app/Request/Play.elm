module Request.Play exposing (get, start, complete)

import Data.Play as Play exposing (Play, selection)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import WatchWord.Query as Query
import WatchWord.Scalar exposing (Id)


get : Id -> SelectionSet Play RootQuery
get gameId =
    Query.selection identity
        |> with (getPlay gameId)


getPlay : Id -> Field Play RootQuery
getPlay gameId =
    Query.play { id = gameId } Play.selection
        |> Field.nonNullOrFail

start : String -> 
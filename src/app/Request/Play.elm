module Request.Play exposing (get)

import Data.Play as Play exposing (Play, selection)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import WatchWord.Query as Query


type alias Response =
    Maybe Play


get : Id -> SelectionSet Response RootQuery
get gameId =
    Query.selection identity
        |> with (getPlay gameId)


getPlay : Id -> Field Response RootQuery
getPlay gameId =
    Query.play { id = gameId } Play.selection

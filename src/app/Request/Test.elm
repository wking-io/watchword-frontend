module Request.Test exposing (get)

import Data.Words exposing (Words)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Request.Words as Words
import Watchword.Query as Query


type alias Response =
    Words


get : SelectionSet Response RootQuery
get =
    Query.selection identity
        |> with Words.getAll

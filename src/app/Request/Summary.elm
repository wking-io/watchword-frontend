module Request.Summary exposing (Response, get)

import Data.Pattern exposing (Pattern)
import Data.Patterns as Patterns exposing (Patterns)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Pattern as Pattern
import SelectList exposing (SelectList)
import WatchWord.Query as Query


type alias Response =
    SelectList Pattern


get : SelectionSet Response RootQuery
get =
    Query.selection identity
        |> with (Query.patterns identity Pattern.selection)
        |> SelectionSet.map Patterns.toSelectList

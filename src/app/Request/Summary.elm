module Request.Summary exposing (get)

import Data.Pattern exposing (Pattern)
import Data.Patterns exposing (Patterns)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import WatchWord.Query as Query
import WatchWord.Object
import WatchWord.Object.Game
import WatchWord.Object.Pattern
import WatchWord.Scalar exposing (Id)


get : SelectionSet Patterns RootQuery
get =
    Query.selection identity
        |> with getPatterns


getPatterns : Field Patterns RootQuery
getPatterns =
    WatchWord.Object.Pattern.selection Pattern
        |> with WatchWord.Object.Pattern.pattern
        |> with WatchWord.Object.Pattern.name
        |> with WatchWord.Object.Pattern.description
        |> with WatchWord.Object.Pattern.focusType
        |> with getDemo
        |> Query.patterns identity


getDemo : Field (Maybe Id) WatchWord.Object.Pattern
getDemo =
    fieldSelection WatchWord.Object.Game.id
        |> WatchWord.Object.Pattern.demo identity

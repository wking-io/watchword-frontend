module Request.Setup exposing (get)

import Data.Pattern exposing (Pattern)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Query as Query
import WatchWord.Object
import WatchWord.Object.Game
import WatchWord.Object.Pattern
import WatchWord.Scalar exposing (Id)


type alias Response =
    Maybe Pattern


get : PatternType -> SelectionSet Response RootQuery
get patternType =
    Query.selection identity
        |> with (getPattern patternType)


getPattern : PatternType -> Field Response RootQuery
getPattern patternType =
    WatchWord.Object.Pattern.selection Pattern
        |> with WatchWord.Object.Pattern.pattern
        |> with WatchWord.Object.Pattern.name
        |> with WatchWord.Object.Pattern.description
        |> with WatchWord.Object.Pattern.focusType
        |> with getDemo
        |> Query.pattern { pattern = patternType }


getDemo : Field (Maybe Id) WatchWord.Object.Pattern
getDemo =
    fieldSelection WatchWord.Object.Game.id
        |> WatchWord.Object.Pattern.demo identity

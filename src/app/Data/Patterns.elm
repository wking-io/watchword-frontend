module Data.Patterns exposing (Patterns, toSelectList)

import Data.Pattern as Pattern exposing (Pattern)
import SelectList exposing (SelectList)


type alias Patterns =
    List Pattern


toSelectList : Patterns -> SelectList Pattern
toSelectList patterns =
    case patterns of
        first :: rest ->
            SelectList.fromLists [] first rest

        [] ->
            SelectList.fromLists [] Pattern.empty []

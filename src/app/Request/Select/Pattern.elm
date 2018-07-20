module Request.Select.Pattern exposing (pattern)

import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Object
import WatchWord.Object.Pattern


pattern : SelectionSet PatternType WatchWord.Object.Pattern
pattern =
    fieldSelection WatchWord.Object.Pattern.pattern

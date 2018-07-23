module Data.Pattern exposing (Pattern, empty)

import WatchWord.Enum.PatternType exposing (PatternType(Connect))
import WatchWord.Enum.FocusType exposing (FocusType(None))
import WatchWord.Scalar exposing (Id, DateTime)


type alias Pattern =
    { pattern : PatternType
    , name : String
    , description : String
    , focusType : FocusType
    , demo : Maybe Id
    }


empty : Pattern
empty =
    { pattern = Connect
    , name = ""
    , description = ""
    , focusType = None
    , demo = Nothing
    }

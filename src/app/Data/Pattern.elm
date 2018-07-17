module Data.Pattern exposing (Pattern)

import WatchWord.Scalar exposing (Id, DateTime)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Enum.FocusType exposing (FocusType)


type alias Pattern =
    { pattern : PatternType
    , name : String
    , description : String
    , focusType : FocusType
    , demo : Maybe Id
    }

module Data.Pattern exposing (Pattern)

import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Enum.FocusType exposing (FocusType)
import WatchWord.Scalar exposing (Id, DateTime)


type alias Pattern =
    { pattern : PatternType
    , name : String
    , description : String
    , focusType : FocusType
    , demo : Maybe Id
    }

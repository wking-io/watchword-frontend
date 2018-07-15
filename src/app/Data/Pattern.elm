module Data.Pattern exposing (Pattern)

import Watchword.Scalar exposing (Id, DateTime)
import Watchword.Enum.PatternType exposing (PatternType)


type alias Pattern =
    { pattern : PatternType
    , name : String
    , description : String
    , demo : Id
    }

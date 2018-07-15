module Data.Game exposing (Game)

import Data.Session exposing (Session)
import Watchword.Scalar exposing (Id, DateTime)
import Watchword.Enum.Focus exposing (Focus)
import Watchword.Enum.PatternType exposing (PatternType)


type alias Game =
    { id : Id
    , createdAt : DateTime
    , updatedAt : DateTime
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , sessions : List Session
    , words : List String
    }

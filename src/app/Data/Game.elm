module Data.Game exposing (Game)

import Data.Sessions exposing (Sessions)
import Data.Words exposing (Words)
import WatchWord.Enum.Focus exposing (Focus)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Scalar exposing (Id, DateTime)


type alias Game =
    { id : Id
    , createdAt : DateTime
    , updatedAt : DateTime
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , sessions : Sessions
    , words : Words
    }

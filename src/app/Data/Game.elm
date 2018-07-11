module Data.Game exposing (Game)

import Watchword.Scalar exposing (Id, DateTime)
import Watchword.Enum.Focus exposing (Focus)


type alias Game =
    { id : Id
    , createdAt : DateTime
    , updatedAt : DateTime
    , name : String
    , focus : Focus
    , size : Int
    , pattern : Id
    , sessions : List Id
    , words : List Id
    }

module Data.Session exposing (Session)

import WatchWord.Scalar exposing (Id, DateTime)


type alias Session =
    { id : Id
    , name : String
    , createdAt : DateTime
    , updatedAt : DateTime
    , complete : Bool
    , completedAt : Maybe DateTime
    , game : Id
    }

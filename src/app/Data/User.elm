module Data.User exposing (User, UserRaw, decoder, encode)

import Data.AuthToken as AuthToken exposing (AuthToken)
import Data.DateTime as DateTime
import Data.UserRole as UserRole
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode exposing (Value)
import WatchWord.Enum.UserRole exposing (UserRole)
import WatchWord.Scalar exposing (DateTime)


type alias User =
    { email : String
    , token : AuthToken
    , createdAt : DateTime
    , updatedAt : DateTime
    , role : UserRole
    }


type alias UserRaw =
    { email : String
    , name : String
    , createdAt : DateTime
    , updatedAt : DateTime
    , role : UserRole
    }



-- SERIALIZATION --


decoder : Decoder User
decoder =
    decode User
        |> required "email" Decode.string
        |> required "token" AuthToken.decoder
        |> required "createdAt" DateTime.decoder
        |> required "updatedAt" DateTime.decoder
        |> required "role" UserRole.decoder


encode : User -> Value
encode user =
    Encode.object
        [ ( "email", Encode.string user.email )
        , ( "token", AuthToken.encode user.token )
        , ( "createdAt", DateTime.encode user.createdAt )
        , ( "updatedAt", DateTime.encode user.updatedAt )
        , ( "role", UserRole.encode user.role )
        ]

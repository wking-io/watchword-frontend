module Data.UserRole exposing (decoder, encode)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Watchword.Enum.UserRole as UserRole exposing (UserRole(..))


-- SERIALIZATION --


decoder : Decoder UserRole
decoder =
    UserRole.decoder


encode : UserRole -> Value
encode role =
    UserRole.toString role
        |> Encode.string

module Data.UserRole exposing (UserRole, decoder, encode)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Util.Decode


type UserRole
    = Admin
    | Teacher



-- SERIALIZATION --


decoder : Decoder UserRole
decoder =
    Decode.string
        |> Decode.andThen (Util.Decode.fromResult << fromString)


encode : UserRole -> Value
encode role =
    toString role
        |> Encode.string


toString : UserRole -> String
toString role =
    case role of
        Admin ->
            "Admin"

        Teacher ->
            "Teacher"


fromString : String -> Result String UserRole
fromString raw =
    case raw of
        "Admin" ->
            Ok Admin

        "Teacher" ->
            Ok Teacher

        _ ->
            Err <| "Could not convert " ++ raw ++ " to UserRole."

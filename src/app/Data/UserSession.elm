module Data.UserSession exposing (UserSession, decoder, empty, encode, create, token)

import Data.AuthToken exposing (AuthToken)
import Data.User as User exposing (User)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type UserSession
    = LoggedIn User
    | LoggedOut


create : User -> UserSession
create =
    LoggedIn


decoder : Value -> UserSession
decoder json =
    Decode.decodeValue User.decoder json
        |> Result.map LoggedIn
        |> Result.withDefault LoggedOut


encode : UserSession -> Value
encode session =
    case session of
        LoggedIn user ->
            User.encode user

        LoggedOut ->
            Encode.null


empty : UserSession
empty =
    LoggedOut


token : UserSession -> Maybe AuthToken
token session =
    case session of
        LoggedIn user ->
            Just user.token

        LoggedOut ->
            Nothing

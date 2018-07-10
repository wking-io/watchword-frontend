module Data.User exposing (User, decoder, encode)

import Data.AuthToken as AuthToken exposing (AuthToken)
import Data.UserRole as UserRole exposing (UserRole)
import Html exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode exposing (Value)


type alias User =
    { email : String
    , token : AuthToken
    , username : Username
    , createdAt : String
    , updatedAt : String
    , role : UserRole
    }



-- SERIALIZATION --


decoder : Decoder User
decoder =
    decode User
        |> required "email" Decode.string
        |> required "token" AuthToken.decoder
        |> required "username" usernameDecoder
        |> required "createdAt" Decode.string
        |> required "updatedAt" Decode.string
        |> required "role" UserRole.decoder


encode : User -> Value
encode user =
    Encode.object
        [ ( "email", Encode.string user.email )
        , ( "token", AuthToken.encode user.token )
        , ( "username", encodeUsername user.username )
        , ( "createdAt", Encode.string user.createdAt )
        , ( "updatedAt", Encode.string user.updatedAt )
        , ( "role", UserRole.encode user.role )
        ]



-- IDENTIFIERS --


type Username
    = Username String


usernameDecoder : Decoder Username
usernameDecoder =
    Decode.string
        |> Decode.map Username


encodeUsername : Username -> Value
encodeUsername (Username username) =
    Encode.string username


usernameToHtml : Username -> Html msg
usernameToHtml (Username username) =
    Html.text username

module Data.AuthToken exposing (AuthToken, field, decoder, encode, withAuthorization, testToken)

import Graphqelm.Http
import Graphqelm.Field as Field exposing (Field)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import WatchWord.Object
import WatchWord.Object.User


type AuthToken
    = AuthToken String


testToken : AuthToken
testToken =
    AuthToken "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjamhodXUyaHA1c2o1MGI2MjJtcmVjcWtjIiwiaWF0IjoxNTMxNjE2MTczfQ.GtU5rIsiMUgbp7hNqhkWOFRO1VUFFmV8Wp-820rBxjs"


field : Field AuthToken WatchWord.Object.User
field =
    WatchWord.Object.User.token |> Field.map AuthToken


decoder : Decoder AuthToken
decoder =
    Decode.string
        |> Decode.map AuthToken


encode : AuthToken -> Value
encode (AuthToken token) =
    Encode.string token


withAuthorization : Maybe AuthToken -> Graphqelm.Http.Request decodesTo -> Graphqelm.Http.Request decodesTo
withAuthorization maybeToken request =
    case maybeToken of
        Nothing ->
            request

        Just (AuthToken token) ->
            request
                |> Graphqelm.Http.withHeader "authorization" ("Bearer " ++ token)

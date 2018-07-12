module Data.AuthToken exposing (AuthToken, decoder, encode, withAuthorization, testToken)

import Graphqelm.Http as GraphqlHttp
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type AuthToken
    = AuthToken String


testToken : AuthToken
testToken =
    AuthToken "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjamhodXUyaHA1c2o1MGI2MjJtcmVjcWtjIiwiaWF0IjoxNTMwODg1NDc3fQ.6mSY0JT6sWimjavi6g8CGj_ktY-zahDQTW6oaCDMol8"


decoder : Decoder AuthToken
decoder =
    Decode.string
        |> Decode.map AuthToken


encode : AuthToken -> Value
encode (AuthToken token) =
    Encode.string token


withAuthorization : Maybe AuthToken -> GraphqlHttp.Request decodesTo -> GraphqlHttp.Request decodesTo
withAuthorization maybeToken request =
    case maybeToken of
        Nothing ->
            request

        Just (AuthToken token) ->
            request
                |> GraphqlHttp.withHeader "authorization" ("Bearer " ++ token)

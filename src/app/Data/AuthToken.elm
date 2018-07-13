module Data.AuthToken exposing (AuthToken, fieldDecoder, decoder, encode, withAuthorization, testToken)

import Graphqelm.Http
import Graphqelm.Field as Field exposing (Field)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Watchword.Object
import Watchword.Object.AuthPayload as AuthPayload


type AuthToken
    = AuthToken String


fieldDecoder : Field AuthToken Watchword.Object.AuthPayload
fieldDecoder =
    AuthPayload.token |> Field.map AuthToken


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

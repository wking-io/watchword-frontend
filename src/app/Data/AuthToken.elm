module Data.AuthToken exposing (AuthToken, decoder, encode, withAuthorization)

import Graphqelm.Http as GraphqlHttp
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type AuthToken
    = AuthToken String


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

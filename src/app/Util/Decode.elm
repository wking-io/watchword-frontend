module Util.Decode exposing (fromResult)

import Json.Decode as Decode exposing (Decoder)


fromResult : Result String a -> Decoder a
fromResult result =
    case result of
        Err err ->
            Decode.fail err

        Ok a ->
            Decode.succeed a

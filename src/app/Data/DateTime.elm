module Data.DateTime exposing (decoder, encode)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import WatchWord.Scalar exposing (DateTime(..))


decoder : Decoder DateTime
decoder =
    Decode.string
        |> Decode.map DateTime


encode : DateTime -> Value
encode (DateTime datetime) =
    Encode.string datetime

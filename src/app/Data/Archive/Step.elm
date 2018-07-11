module Data.Step exposing (Step, Choice, decoder, empty)

import Data.FieldType as FieldType exposing (FieldType)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, custom, required, resolve, hardcoded)


type alias Step =
    { fieldType : FieldType
    , choices : List Choice
    }


type alias Choice =
    { value : String
    , label : String
    , description : String
    }


decoder : Decoder Step
decoder =
    decode Step
        |> custom FieldType.decoder
        |> required "choices" (Decode.list decodeChoice)


decodeChoice : Decoder Choice
decodeChoice =
    decode Choice
        |> required "value" Decode.string
        |> required "label" Decode.string
        |> required "description" Decode.string


empty : Step
empty =
    Step FieldType.empty []

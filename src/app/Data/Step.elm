module Data.Step exposing (Step, Option, decoder, empty)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, resolve, hardcoded)


type alias Step =
    { id : String
    , name : String
    , options : List Option
    , selection : Maybe String
    }


type alias Option =
    { value : String
    , label : String
    , description : String
    }


decoder : Decoder Step
decoder =
    decode Step
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "options" (Decode.list decodeOption)
        |> hardcoded Nothing


decodeOption : Decoder Option
decodeOption =
    decode Option
        |> required "value" Decode.string
        |> required "label" Decode.string
        |> required "description" Decode.string


empty : Step
empty =
    Step "" "" [] Nothing

module Data.FieldType exposing (FieldType(..), decoder, empty)

import Json.Decode as Decode exposing (Decoder)


type FieldType
    = NotFound
    | RadioVertical
    | RadioHorizontal
    | WordSelect


decoder : Decoder FieldType
decoder =
    Decode.field "type" (Decode.map stringToFieldType Decode.string)


stringToFieldType : String -> FieldType
stringToFieldType fieldType =
    case fieldType of
        "radio-vertical" ->
            RadioVertical

        "radio-horizontal" ->
            RadioHorizontal

        "word-select" ->
            WordSelect

        _ ->
            NotFound


empty : FieldType
empty =
    NotFound

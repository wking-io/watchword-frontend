module Data.Word exposing (Word, decoder, toString)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)


type Word
    = Word String


decoder : Decoder Word
decoder =
    decode Word
        |> required "word" Decode.string


toString : Word -> String
toString (Word word) =
    word

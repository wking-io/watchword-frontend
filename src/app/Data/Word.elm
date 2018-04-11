module Data.Word exposing (Word, decoder, toString)

import Json.Decode as Decode exposing (Decoder)


type Word
    = Word String


decoder : Decoder Word
decoder =
    Decode.map Word Decode.string


toString : Word -> String
toString (Word word) =
    word

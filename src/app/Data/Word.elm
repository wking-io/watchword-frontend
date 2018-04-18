module Data.Word exposing (Word, decoder, fromString, toString)

import Json.Decode as Decode exposing (Decoder)


type Word
    = Word String


decoder : Decoder Word
decoder =
    Decode.map Word Decode.string


fromString : String -> Word
fromString word =
    Word word


toString : Word -> String
toString (Word word) =
    word

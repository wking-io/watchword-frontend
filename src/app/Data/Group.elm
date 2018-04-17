module Data.Group exposing (Group, decoder, fromDict, fromString, toString)

import Json.Decode as Decode exposing (Decoder)
import Dict exposing (Dict)


type Group
    = Group String


decoder : Decoder Group
decoder =
    Decode.map Group Decode.string


fromDict : Dict String a -> List Group
fromDict dict =
    dict
        |> Dict.keys
        |> List.map Group


fromString : String -> Group
fromString group =
    Group group


toString : Group -> String
toString (Group word) =
    word

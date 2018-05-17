module Data.Size exposing (Size, fromString, toString, toInt, parser)

import UrlParser


type Size
    = S
    | M
    | L
    | XL


parser : UrlParser.Parser (Size -> a) a
parser =
    UrlParser.custom "Size" fromString


toString : Size -> String
toString size =
    case size of
        S ->
            "s"

        M ->
            "m"

        L ->
            "l"

        XL ->
            "xl"


toInt : Size -> Int
toInt size =
    case size of
        S ->
            3

        M ->
            4

        L ->
            5

        XL ->
            6


fromString : String -> Result String Size
fromString str =
    case str of
        "s" ->
            Ok S

        "m" ->
            Ok M

        "l" ->
            Ok L

        "xl" ->
            Ok XL

        _ ->
            Err "Size conversion failed. Check value being parsed."

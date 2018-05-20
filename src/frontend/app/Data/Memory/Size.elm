module Data.Memory.Size exposing (Size(..), parser, equals, fromString, toString)

import UrlParser


type Size
    = Small
    | Medium
    | Large
    | ExtraLarge


parser : UrlParser.Parser (Size -> a) a
parser =
    UrlParser.custom "SIZE" fromString


fromString : String -> Result String Size
fromString segment =
    if segment == "small" then
        Ok Small
    else if segment == "medium" then
        Ok Medium
    else if segment == "large" then
        Ok Large
    else if segment == "extralarge" then
        Ok ExtraLarge
    else
        Err "Segement does not match any sizes"


toString : Size -> String
toString size =
    case size of
        Small ->
            "small"

        Medium ->
            "medium"

        Large ->
            "large"

        ExtraLarge ->
            "extralarge"


equals : Int -> Size -> Bool
equals int size =
    case size of
        Small ->
            int == 3

        Medium ->
            int == 4

        Large ->
            int == 5

        ExtraLarge ->
            int == 6

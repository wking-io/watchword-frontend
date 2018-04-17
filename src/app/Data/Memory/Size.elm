module Data.Memory.Size exposing (Size(..), parser, fromString, toString)

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

module Data.Memory.Option exposing (Option(..), parser, fromString, toString)

import UrlParser


type Option
    = Random
    | Pick


parser : UrlParser.Parser (Option -> a) a
parser =
    UrlParser.custom "OPTION" fromString


fromString : String -> Result String Option
fromString segment =
    if segment == "random" then
        Ok Random
    else if segment == "medium" then
        Ok Pick
    else
        Err "Segement does not match any options"


toString : Option -> String
toString size =
    case size of
        Random ->
            "random"

        Pick ->
            "pick"

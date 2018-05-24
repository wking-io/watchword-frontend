module Data.Option exposing (Option(..), fromString, toString, parser)

import UrlParser


type Option
    = Random
    | Custom


parser : UrlParser.Parser (Option -> a) a
parser =
    UrlParser.custom "Option" fromString


toString : Option -> String
toString option =
    case option of
        Random ->
            "random"

        Custom ->
            "custom"


fromString : String -> Result String Option
fromString str =
    case str of
        "random" ->
            Ok Random

        "custom" ->
            Ok Custom

        _ ->
            Err "Option conversion failed. Check value being parsed."

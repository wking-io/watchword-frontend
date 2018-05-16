module Data.Option exposing (Option(..), fromString)


type Option
    = Random
    | Custom


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

module Data.Size exposing (Size, fromString)


type Size
    = S
    | M
    | L
    | XL


fromString : String -> Result String Size
fromString str =
    case str of
        "small" ->
            Ok S

        "medium" ->
            Ok M

        "large" ->
            Ok L

        "xtralarge" ->
            Ok XL

        _ ->
            Err "Size conversion failed. Check value being parsed."

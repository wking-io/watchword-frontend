module Data.Size exposing (Size, fromString)


type Size
    = S
    | M
    | L
    | XL


toString : Size -> String
toString option =
    case option of
        S ->
            "s"

        M ->
            "m"

        L ->
            "l"

        XL ->
            "xl"


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

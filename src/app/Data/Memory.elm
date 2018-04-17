module Data.Memory exposing (Slug(..), toString)

import Data.Memory.Option as Option exposing (Option)
import Data.Memory.Size as Size exposing (Size)


type Slug
    = Slug Option Size (Maybe (List String))


toString : Slug -> String
toString (Slug option size maybeSelection) =
    case maybeSelection of
        Just selection ->
            (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?selection=full"

        Nothing ->
            (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?selection=empty"

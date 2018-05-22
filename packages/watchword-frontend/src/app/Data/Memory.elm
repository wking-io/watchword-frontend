module Data.Memory exposing (Slug(..), toString)

import Data.Option as Option exposing (Option)
import Data.Size as Size exposing (Size)


type Slug
    = Slug Option Size (Maybe (List String))


toString : Slug -> String
toString (Slug option size maybeSelection) =
    case maybeSelection of
        Just selection ->
            (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?selection=" ++ (String.join "," selection)

        Nothing ->
            (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?selection=empty"

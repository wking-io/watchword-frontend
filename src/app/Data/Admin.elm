module Data.Admin exposing (Slug(..), slugToString)

import Data.Option as Option exposing (Option)
import Data.Size as Size exposing (Size)


type Slug
    = Init
    | WithGame String
    | WithSetup String
    | WithOption String Option
    | WithSize String Option Size
    | WithWords String Option Size (Maybe (List String))


slugToString : Slug -> String
slugToString slug =
    case slug of
        Init ->
            ""

        WithGame id ->
            id

        WithSetup id ->
            id ++ "/setup/"

        WithOption id option ->
            id ++ "/setup/" ++ (Option.toString option) ++ "/"

        WithSize id option size ->
            id ++ "/setup/" ++ (Option.toString option) ++ "/" ++ (Size.toString size) ++ "/"

        WithWords id option size maybeWords ->
            case maybeWords of
                Just words ->
                    id ++ "/setup/" ++ (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?selection=" ++ (String.join "," words)

                Nothing ->
                    id ++ "/setup/" ++ (Option.toString option) ++ "/" ++ (Size.toString size) ++ "/"

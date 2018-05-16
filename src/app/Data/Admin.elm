module Data.Admin exposing (Slug(..), parser, slugToString)

import UrlParser
import Data.Option as Option exposing (Option)
import Data.Size as Size exposing (Size)


type Slug
    = Init
    | WithGame String
    | WithSetup String
    | WithOption String Option
    | WithSize String Option Size
    | WithWords String Option Size (List String)


parser : UrlParser.Parser (Slug -> a) a
parser =
    UrlParser.custom "SLUG" (Ok << WithGame)


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

        WithWords id option size words ->
            id ++ "/setup/" ++ (Option.toString option) ++ "/" ++ (Size.toString size) ++ "?words=" ++ (String.join "," words)

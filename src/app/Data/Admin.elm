module Data.Admin exposing (Slug(..), parser, slugToString)

import UrlParser


type Slug
    = Init
    | WithGame String


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

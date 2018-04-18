module Data.Game exposing (Game, decoder, toString, toSlug)

import Json.Decode as Decode exposing (Decoder, field)


type Game
    = Game String String


decoder : Decoder Game
decoder =
    Decode.map2 Game
        (field "id" Decode.string)
        (field "name" Decode.string)


toString : Game -> String
toString (Game _ name) =
    name


toSlug : Game -> String
toSlug (Game id _) =
    id

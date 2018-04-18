module Request.Games exposing (get)

import Data.Game as Game exposing (Game)
import Json
import Json.Decode as Decode exposing (decodeString, field)


get : Result String (List Game)
get =
    decodeString (field "games" (Decode.list Game.decoder)) Json.games

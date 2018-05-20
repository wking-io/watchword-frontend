module Request.Games exposing (get, getNav)

import Data.Games as Games exposing (Games, Game)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import SelectList exposing (SelectList, fromLists)


get : Result String Games
get =
    decodeString Games.decoder Json.games


getNav : Result String (SelectList Game)
getNav =
    get
        |> Result.map Games.toNav

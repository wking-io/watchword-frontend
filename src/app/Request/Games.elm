module Request.Games exposing (get, getSelectList)

import Data.Games as Games exposing (Games, Game)
import Json
import Json.Decode as Decode exposing (decodeString, field)
import SelectList exposing (SelectList, fromLists)


get : Result String Games
get =
    decodeString Games.decoder Json.games


getSelectList : Result String (SelectList Game)
getSelectList =
    get
        |> Result.map Games.toSelectList

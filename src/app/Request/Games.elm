-- module Request.Games exposing (get)

-- import Data.AuthToken as AuthToken exposing (AuthToken)
-- import Data.Games as Games exposing (Games, Game)
-- import Data.Word as Word exposing (Word)
-- import Data.Words as Words exposing (Words)
-- import Graphqelm.Http
-- import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
-- import Request.Base exposing (makeRequest)
-- import Task exposing (Task)
-- import Watchword.Query as Query
-- import Watchword.Object
-- import Watchword.Object.Word as Word


-- get : Result String Games
-- get =
--     decodeString Games.decoder Json.games



-- getNav : Result String (SelectList Game)
-- getNav =
--     get
--         |> Result.map Games.toNav

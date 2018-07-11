module Request.Games exposing (get)

import Data.Game as Game exposing (Game)
import Data.Games as Games exposing (Games)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Watchword.Query as Query exposing (GamesOptionalArguments)
import Watchword.Object
import Watchword.Object.Game as ApiGame


get : (GamesOptionalArguments -> GamesOptionalArguments) -> Field Games RootQuery
get with =
    Query.words with getGame
        |> Field.map Games.fromList


getAll : Field Games RootQuery
getAll =
    get identity


getGame : SelectionSet Game Watchword.Object.Game
getGame =
    ApiGame.selection Game
        |> with ApiGame.id
        |> with ApiGame.createdAt
        |> with ApiGame.updatedAt
        |> with ApiGame.name
        |> with ApiGame.focus
        |> with ApiGame.size
        |> with ApiGame.pattern
        |> with ApiGame.sessions
        |> with ApiGame.words

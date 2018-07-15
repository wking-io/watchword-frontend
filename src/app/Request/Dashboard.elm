module Request.Dashboard exposing (get)

import Data.Game as Game exposing (Game)
import Data.Games as Games exposing (Games)
import Data.Session as Session exposing (Session)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Watchword.Enum.PatternType exposing (PatternType)
import Watchword.Query as Query exposing (GamesOptionalArguments)
import Watchword.Object
import Watchword.Object.Game
import Watchword.Object.Pattern
import Watchword.Object.Session
import Watchword.Object.Word
import Watchword.Scalar exposing (Id, DateTime)


get : SelectionSet Games RootQuery
get =
    Query.selection Games.fromList
        |> with getGames


getGames : Field (List Game) RootQuery
getGames =
    Watchword.Object.Game.selection Game
        |> with Watchword.Object.Game.id
        |> with Watchword.Object.Game.createdAt
        |> with Watchword.Object.Game.updatedAt
        |> with Watchword.Object.Game.name
        |> with Watchword.Object.Game.focus
        |> with Watchword.Object.Game.size
        |> with getPattern
        |> with getSessions
        |> with getWords
        |> Query.games identity


getGameId : Field Id Watchword.Object.Session
getGameId =
    fieldSelection Watchword.Object.Game.id
        |> Watchword.Object.Session.game identity


getPattern : Field PatternType Watchword.Object.Game
getPattern =
    fieldSelection Watchword.Object.Pattern.pattern
        |> Watchword.Object.Game.pattern identity


getSessions : Field (List Session) Watchword.Object.Game
getSessions =
    Watchword.Object.Session.selection Session
        |> with Watchword.Object.Session.id
        |> with Watchword.Object.Session.name
        |> with Watchword.Object.Session.createdAt
        |> with Watchword.Object.Session.updatedAt
        |> with Watchword.Object.Session.complete
        |> with Watchword.Object.Session.completedAt
        |> with getGameId
        |> Watchword.Object.Game.sessions identity
        |> Field.map (Maybe.withDefault [])


getWords : Field (List String) Watchword.Object.Game
getWords =
    fieldSelection Watchword.Object.Word.word
        |> Watchword.Object.Game.words identity
        |> Field.map (Maybe.withDefault [])

module Request.Detail exposing (get)

import Data.Game as Game exposing (Game)
import Data.Session as Session exposing (Session)
import Data.Word as Word exposing (Word)
import Data.Words as Words exposing (Words)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Query as Query
import WatchWord.Object
import WatchWord.Object.Game
import WatchWord.Object.Pattern
import WatchWord.Object.Session
import WatchWord.Object.Word
import WatchWord.Scalar exposing (Id)


type alias Response =
    Maybe Game


get : Id -> SelectionSet Response RootQuery
get gameId =
    Query.selection identity
        |> with (getGame gameId)


getGame : Id -> Field Response RootQuery
getGame gameId =
    WatchWord.Object.Game.selection Game
        |> with WatchWord.Object.Game.id
        |> with WatchWord.Object.Game.createdAt
        |> with WatchWord.Object.Game.updatedAt
        |> with WatchWord.Object.Game.name
        |> with WatchWord.Object.Game.focus
        |> with WatchWord.Object.Game.size
        |> with getPattern
        |> with getSessions
        |> with getWords
        |> Query.game { id = gameId }


getPattern : Field PatternType WatchWord.Object.Game
getPattern =
    fieldSelection WatchWord.Object.Pattern.pattern
        |> WatchWord.Object.Game.pattern identity


getSessions : Field (List Session) WatchWord.Object.Game
getSessions =
    WatchWord.Object.Session.selection Session
        |> with WatchWord.Object.Session.id
        |> with WatchWord.Object.Session.name
        |> with WatchWord.Object.Session.createdAt
        |> with WatchWord.Object.Session.updatedAt
        |> with WatchWord.Object.Session.complete
        |> with WatchWord.Object.Session.completedAt
        |> with getGameId
        |> WatchWord.Object.Game.sessions identity
        |> Field.map (Maybe.withDefault [])


getGameId : Field Id WatchWord.Object.Session
getGameId =
    fieldSelection WatchWord.Object.Game.id
        |> WatchWord.Object.Session.game identity


getWords : Field Words WatchWord.Object.Game
getWords =
    WatchWord.Object.Word.selection Word
        |> with WatchWord.Object.Word.id
        |> with WatchWord.Object.Word.word
        |> with WatchWord.Object.Word.group
        |> with WatchWord.Object.Word.beginning
        |> with WatchWord.Object.Word.ending
        |> with WatchWord.Object.Word.vowel
        |> WatchWord.Object.Game.words identity
        |> Field.map (Maybe.withDefault [])

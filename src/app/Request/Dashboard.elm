module Request.Dashboard exposing (Response, get)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Watchword.Enum.Focus exposing (Focus)
import Watchword.Enum.PatternType exposing (PatternType)
import Watchword.Query as Query exposing (GamesOptionalArguments)
import Watchword.Object
import Watchword.Object.Game as Game
import Watchword.Object.Pattern as Pattern
import Watchword.Object.Session as Session
import Watchword.Object.Word as Word
import Watchword.Scalar exposing (Id, DateTime)


type alias Response =
    List RequestGame


type alias RequestGame =
    { id : Id
    , createdAt : DateTime
    , updatedAt : DateTime
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , sessions : List RequestSession
    , words : List String
    }


type alias RequestSession =
    { id : Id
    , name : String
    , createdAt : DateTime
    , updatedAt : DateTime
    , complete : Bool
    , completedAt : Maybe DateTime
    , game : Id
    }


get : SelectionSet Response RootQuery
get =
    Query.selection identity
        |> with getGames


getGames : Field (List RequestGame) RootQuery
getGames =
    Game.selection RequestGame
        |> with Game.id
        |> with Game.createdAt
        |> with Game.updatedAt
        |> with Game.name
        |> with Game.focus
        |> with Game.size
        |> with getPattern
        |> with getSessions
        |> with getWords
        |> Query.games identity


getGameId : Field Id Watchword.Object.Session
getGameId =
    fieldSelection Game.id
        |> Session.game identity


getPattern : Field PatternType Watchword.Object.Game
getPattern =
    fieldSelection Pattern.pattern
        |> Game.pattern identity


getSessions : Field (List RequestSession) Watchword.Object.Game
getSessions =
    Session.selection RequestSession
        |> with Session.id
        |> with Session.name
        |> with Session.createdAt
        |> with Session.updatedAt
        |> with Session.complete
        |> with Session.completedAt
        |> with getGameId
        |> Game.sessions identity
        |> Field.map (Maybe.withDefault [])


getWords : Field (List String) Watchword.Object.Game
getWords =
    fieldSelection Word.word
        |> Game.words identity
        |> Field.map (Maybe.withDefault [])

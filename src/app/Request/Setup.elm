module Request.Setup exposing (get)

import Data.Game exposing (Game)
import Data.Pattern exposing (Pattern)
import Graphqelm.Operation exposing (RootQuery, RootMutation)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.Game as Game
import Request.Pattern as Pattern
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.InputObject exposing (buildGameInput, GameInputRequiredFields, buildSignupInput, SignupInputRequiredFields, buildRecoverInput, RecoverInputRequiredFields, buildResetInput, ResetInputRequiredFields)
import WatchWord.Query as Query
import WatchWord.Mutation as Mutation


type alias Response =
    Maybe Pattern


get : PatternType -> SelectionSet Response RootQuery
get patternType =
    Query.selection identity
        |> with (Query.pattern { pattern = patternType } Pattern.selection)


create : GameInputRequiredFields -> SelectionSet Game RootMutation
create input =
    Mutation.selection identity
        |> with (Game.on (Mutation.createGame { input = buildGameInput input }))

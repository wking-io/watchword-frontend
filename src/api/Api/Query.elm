-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Query exposing (..)

import Api.Enum.GameOrderByInput
import Api.Enum.PatternOrderByInput
import Api.Enum.PatternType
import Api.Enum.SessionOrderByInput
import Api.Enum.UserOrderByInput
import Api.Enum.WordOrderByInput
import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode exposing (Decoder)


{-| Select fields to build up a top-level query. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootQuery
selection constructor =
    Object.selection constructor


type alias GamesOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.GameWhereInput, orderBy : OptionalArgument Api.Enum.GameOrderByInput.GameOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -
  - orderBy -
  - skip -
  - after -
  - before -
  - first -
  - last -

-}
games : (GamesOptionalArguments -> GamesOptionalArguments) -> SelectionSet decodesTo Api.Object.Game -> Field (List (Maybe decodesTo)) RootQuery
games fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeGameWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.GameOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "games" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias GameRequiredArguments =
    { id : Api.Scalar.Id }


{-|

  - id -

-}
game : GameRequiredArguments -> SelectionSet decodesTo Api.Object.Game -> Field (Maybe decodesTo) RootQuery
game requiredArgs object =
    Object.selectionField "game" [ Argument.required "id" requiredArgs.id (\(Api.Scalar.Id raw) -> Encode.string raw) ] object (identity >> Decode.nullable)


{-| -}
me : SelectionSet decodesTo Api.Object.User -> Field (Maybe decodesTo) RootQuery
me object =
    Object.selectionField "me" [] object (identity >> Decode.nullable)


type alias PatternsOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.PatternWhereInput, orderBy : OptionalArgument Api.Enum.PatternOrderByInput.PatternOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -
  - orderBy -
  - skip -
  - after -
  - before -
  - first -
  - last -

-}
patterns : (PatternsOptionalArguments -> PatternsOptionalArguments) -> SelectionSet decodesTo Api.Object.Pattern -> Field (List (Maybe decodesTo)) RootQuery
patterns fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodePatternWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.PatternOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "patterns" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias PatternRequiredArguments =
    { pattern : Api.Enum.PatternType.PatternType }


{-|

  - pattern -

-}
pattern : PatternRequiredArguments -> SelectionSet decodesTo Api.Object.Pattern -> Field (Maybe decodesTo) RootQuery
pattern requiredArgs object =
    Object.selectionField "pattern" [ Argument.required "pattern" requiredArgs.pattern (Encode.enum Api.Enum.PatternType.toString) ] object (identity >> Decode.nullable)


type alias SessionsOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.SessionWhereInput, orderBy : OptionalArgument Api.Enum.SessionOrderByInput.SessionOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -
  - orderBy -
  - skip -
  - after -
  - before -
  - first -
  - last -

-}
sessions : (SessionsOptionalArguments -> SessionsOptionalArguments) -> SelectionSet decodesTo Api.Object.Session -> Field (List (Maybe decodesTo)) RootQuery
sessions fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeSessionWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.SessionOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "sessions" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias SessionRequiredArguments =
    { id : Api.Scalar.Id }


{-|

  - id -

-}
session : SessionRequiredArguments -> SelectionSet decodesTo Api.Object.Session -> Field (Maybe decodesTo) RootQuery
session requiredArgs object =
    Object.selectionField "session" [ Argument.required "id" requiredArgs.id (\(Api.Scalar.Id raw) -> Encode.string raw) ] object (identity >> Decode.nullable)


type alias UsersOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.UserWhereInput, orderBy : OptionalArgument Api.Enum.UserOrderByInput.UserOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -
  - orderBy -
  - skip -
  - after -
  - before -
  - first -
  - last -

-}
users : (UsersOptionalArguments -> UsersOptionalArguments) -> SelectionSet decodesTo Api.Object.User -> Field (List (Maybe decodesTo)) RootQuery
users fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeUserWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.UserOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "users" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias UserRequiredArguments =
    { id : Api.Scalar.Id }


{-|

  - id -

-}
user : UserRequiredArguments -> SelectionSet decodesTo Api.Object.User -> Field (Maybe decodesTo) RootQuery
user requiredArgs object =
    Object.selectionField "user" [ Argument.required "id" requiredArgs.id (\(Api.Scalar.Id raw) -> Encode.string raw) ] object (identity >> Decode.nullable)


type alias WordsOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.WordWhereInput, orderBy : OptionalArgument Api.Enum.WordOrderByInput.WordOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -
  - orderBy -
  - skip -
  - after -
  - before -
  - first -
  - last -

-}
words : (WordsOptionalArguments -> WordsOptionalArguments) -> SelectionSet decodesTo Api.Object.Word -> Field (List (Maybe decodesTo)) RootQuery
words fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeWordWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.WordOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "words" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias WordRequiredArguments =
    { id : Api.Scalar.Id }


{-|

  - id -

-}
word : WordRequiredArguments -> SelectionSet decodesTo Api.Object.Word -> Field (Maybe decodesTo) RootQuery
word requiredArgs object =
    Object.selectionField "word" [ Argument.required "id" requiredArgs.id (\(Api.Scalar.Id raw) -> Encode.string raw) ] object (identity >> Decode.nullable)

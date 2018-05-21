-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Query exposing (..)

import Api.Enum.ExerciseOrderByInput
import Api.Enum.GameOrderByInput
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


type alias UsersOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.UserWhereInput, orderBy : OptionalArgument Api.Enum.UserOrderByInput.UserOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

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


type alias GamesOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.GameWhereInput, orderBy : OptionalArgument Api.Enum.GameOrderByInput.GameOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

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


type alias ExercisesOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.ExerciseWhereInput, orderBy : OptionalArgument Api.Enum.ExerciseOrderByInput.ExerciseOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

-}
exercises : (ExercisesOptionalArguments -> ExercisesOptionalArguments) -> SelectionSet decodesTo Api.Object.Exercise -> Field (List (Maybe decodesTo)) RootQuery
exercises fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeExerciseWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.ExerciseOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "exercises" optionalArgs object (identity >> Decode.nullable >> Decode.list)


type alias WordsOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.WordWhereInput, orderBy : OptionalArgument Api.Enum.WordOrderByInput.WordOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

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


type alias UserRequiredArguments =
    { where_ : Api.InputObject.UserWhereUniqueInput }


user : UserRequiredArguments -> SelectionSet decodesTo Api.Object.User -> Field (Maybe decodesTo) RootQuery
user requiredArgs object =
    Object.selectionField "user" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeUserWhereUniqueInput ] object (identity >> Decode.nullable)


type alias GameRequiredArguments =
    { where_ : Api.InputObject.GameWhereUniqueInput }


game : GameRequiredArguments -> SelectionSet decodesTo Api.Object.Game -> Field (Maybe decodesTo) RootQuery
game requiredArgs object =
    Object.selectionField "game" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeGameWhereUniqueInput ] object (identity >> Decode.nullable)


type alias ExerciseRequiredArguments =
    { where_ : Api.InputObject.ExerciseWhereUniqueInput }


exercise : ExerciseRequiredArguments -> SelectionSet decodesTo Api.Object.Exercise -> Field (Maybe decodesTo) RootQuery
exercise requiredArgs object =
    Object.selectionField "exercise" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeExerciseWhereUniqueInput ] object (identity >> Decode.nullable)


type alias WordRequiredArguments =
    { where_ : Api.InputObject.WordWhereUniqueInput }


word : WordRequiredArguments -> SelectionSet decodesTo Api.Object.Word -> Field (Maybe decodesTo) RootQuery
word requiredArgs object =
    Object.selectionField "word" [ Argument.required "where" requiredArgs.where_ Api.InputObject.encodeWordWhereUniqueInput ] object (identity >> Decode.nullable)


type alias UsersConnectionOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.UserWhereInput, orderBy : OptionalArgument Api.Enum.UserOrderByInput.UserOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

-}
usersConnection : (UsersConnectionOptionalArguments -> UsersConnectionOptionalArguments) -> SelectionSet decodesTo Api.Object.UserConnection -> Field decodesTo RootQuery
usersConnection fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeUserWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.UserOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "usersConnection" optionalArgs object identity


type alias GamesConnectionOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.GameWhereInput, orderBy : OptionalArgument Api.Enum.GameOrderByInput.GameOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

-}
gamesConnection : (GamesConnectionOptionalArguments -> GamesConnectionOptionalArguments) -> SelectionSet decodesTo Api.Object.GameConnection -> Field decodesTo RootQuery
gamesConnection fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeGameWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.GameOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "gamesConnection" optionalArgs object identity


type alias ExercisesConnectionOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.ExerciseWhereInput, orderBy : OptionalArgument Api.Enum.ExerciseOrderByInput.ExerciseOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

-}
exercisesConnection : (ExercisesConnectionOptionalArguments -> ExercisesConnectionOptionalArguments) -> SelectionSet decodesTo Api.Object.ExerciseConnection -> Field decodesTo RootQuery
exercisesConnection fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeExerciseWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.ExerciseOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "exercisesConnection" optionalArgs object identity


type alias WordsConnectionOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.WordWhereInput, orderBy : OptionalArgument Api.Enum.WordOrderByInput.WordOrderByInput, skip : OptionalArgument Int, after : OptionalArgument String, before : OptionalArgument String, first : OptionalArgument Int, last : OptionalArgument Int }


{-|

  - where_ -

-}
wordsConnection : (WordsConnectionOptionalArguments -> WordsConnectionOptionalArguments) -> SelectionSet decodesTo Api.Object.WordConnection -> Field decodesTo RootQuery
wordsConnection fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent, orderBy = Absent, skip = Absent, after = Absent, before = Absent, first = Absent, last = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeWordWhereInput, Argument.optional "orderBy" filledInOptionals.orderBy (Encode.enum Api.Enum.WordOrderByInput.toString), Argument.optional "skip" filledInOptionals.skip Encode.int, Argument.optional "after" filledInOptionals.after Encode.string, Argument.optional "before" filledInOptionals.before Encode.string, Argument.optional "first" filledInOptionals.first Encode.int, Argument.optional "last" filledInOptionals.last Encode.int ]
                |> List.filterMap identity
    in
    Object.selectionField "wordsConnection" optionalArgs object identity


type alias NodeRequiredArguments =
    { id : Api.Scalar.Id }


{-| Fetches an object given its ID

  - id - The ID of an object

-}
node : NodeRequiredArguments -> SelectionSet decodesTo Api.Interface.Node -> Field (Maybe decodesTo) RootQuery
node requiredArgs object =
    Object.selectionField "node" [ Argument.required "id" requiredArgs.id (\(Api.Scalar.Id raw) -> Encode.string raw) ] object (identity >> Decode.nullable)

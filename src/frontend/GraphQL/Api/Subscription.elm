-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Subscription exposing (..)

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


{-| Select fields to build up a top-level mutation. The request can be sent with
functions from `Graphqelm.Http`.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) RootSubscription
selection constructor =
    Object.selection constructor


type alias UserOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.UserSubscriptionWhereInput }


{-|

  - where_ -

-}
user : (UserOptionalArguments -> UserOptionalArguments) -> SelectionSet decodesTo Api.Object.UserSubscriptionPayload -> Field (Maybe decodesTo) RootSubscription
user fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeUserSubscriptionWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "user" optionalArgs object (identity >> Decode.nullable)


type alias GameOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.GameSubscriptionWhereInput }


{-|

  - where_ -

-}
game : (GameOptionalArguments -> GameOptionalArguments) -> SelectionSet decodesTo Api.Object.GameSubscriptionPayload -> Field (Maybe decodesTo) RootSubscription
game fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeGameSubscriptionWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "game" optionalArgs object (identity >> Decode.nullable)


type alias ExerciseOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.ExerciseSubscriptionWhereInput }


{-|

  - where_ -

-}
exercise : (ExerciseOptionalArguments -> ExerciseOptionalArguments) -> SelectionSet decodesTo Api.Object.ExerciseSubscriptionPayload -> Field (Maybe decodesTo) RootSubscription
exercise fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeExerciseSubscriptionWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "exercise" optionalArgs object (identity >> Decode.nullable)


type alias WordOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.WordSubscriptionWhereInput }


{-|

  - where_ -

-}
word : (WordOptionalArguments -> WordOptionalArguments) -> SelectionSet decodesTo Api.Object.WordSubscriptionPayload -> Field (Maybe decodesTo) RootSubscription
word fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeWordSubscriptionWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "word" optionalArgs object (identity >> Decode.nullable)

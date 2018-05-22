-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Object.Exercise exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.Exercise
selection constructor =
    Object.selection constructor


{-| -}
id : Field Api.Scalar.Id Api.Object.Exercise
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Api.Scalar.Id)


type alias GameOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.GameWhereInput }


{-|

  - where_ -

-}
game : (GameOptionalArguments -> GameOptionalArguments) -> SelectionSet decodesTo Api.Object.Game -> Field decodesTo Api.Object.Exercise
game fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeGameWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "game" optionalArgs object identity


{-| -}
views : Field Int Api.Object.Exercise
views =
    Object.fieldDecoder "views" [] Decode.int


{-| -}
completed : Field Int Api.Object.Exercise
completed =
    Object.fieldDecoder "completed" [] Decode.int


type alias OwnerOptionalArguments =
    { where_ : OptionalArgument Api.InputObject.UserWhereInput }


{-|

  - where_ -

-}
owner : (OwnerOptionalArguments -> OwnerOptionalArguments) -> SelectionSet decodesTo Api.Object.User -> Field decodesTo Api.Object.Exercise
owner fillInOptionals object =
    let
        filledInOptionals =
            fillInOptionals { where_ = Absent }

        optionalArgs =
            [ Argument.optional "where" filledInOptionals.where_ Api.InputObject.encodeUserWhereInput ]
                |> List.filterMap identity
    in
    Object.selectionField "owner" optionalArgs object identity
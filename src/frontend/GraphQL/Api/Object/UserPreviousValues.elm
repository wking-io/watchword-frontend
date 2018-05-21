-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Object.UserPreviousValues exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Api.Object.UserPreviousValues
selection constructor =
    Object.selection constructor


id : Field Api.Scalar.Id Api.Object.UserPreviousValues
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Api.Scalar.Id)


name : Field String Api.Object.UserPreviousValues
name =
    Object.fieldDecoder "name" [] Decode.string


email : Field String Api.Object.UserPreviousValues
email =
    Object.fieldDecoder "email" [] Decode.string


password : Field String Api.Object.UserPreviousValues
password =
    Object.fieldDecoder "password" [] Decode.string

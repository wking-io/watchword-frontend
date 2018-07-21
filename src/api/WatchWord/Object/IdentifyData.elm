-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module WatchWord.Object.IdentifyData exposing (..)

import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode
import WatchWord.Enum.Focus
import WatchWord.Enum.PatternType
import WatchWord.InputObject
import WatchWord.Interface
import WatchWord.Object
import WatchWord.Scalar
import WatchWord.Union


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) WatchWord.Object.IdentifyData
selection constructor =
    Object.selection constructor


{-| -}
id : Field WatchWord.Scalar.Id WatchWord.Object.IdentifyData
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map WatchWord.Scalar.Id)


{-| -}
name : Field String WatchWord.Object.IdentifyData
name =
    Object.fieldDecoder "name" [] Decode.string


{-| -}
focus : Field WatchWord.Enum.Focus.Focus WatchWord.Object.IdentifyData
focus =
    Object.fieldDecoder "focus" [] WatchWord.Enum.Focus.decoder


{-| -}
size : Field Int WatchWord.Object.IdentifyData
size =
    Object.fieldDecoder "size" [] Decode.int


{-| -}
pattern : Field WatchWord.Enum.PatternType.PatternType WatchWord.Object.IdentifyData
pattern =
    Object.fieldDecoder "pattern" [] WatchWord.Enum.PatternType.decoder


{-| -}
words : SelectionSet decodesTo WatchWord.Object.Word -> Field (List decodesTo) WatchWord.Object.IdentifyData
words object =
    Object.selectionField "words" [] object (identity >> Decode.list)


{-| -}
options : Field (List String) WatchWord.Object.IdentifyData
options =
    Object.fieldDecoder "options" [] (Decode.string |> Decode.list)
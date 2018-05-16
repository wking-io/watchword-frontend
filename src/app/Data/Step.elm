module Data.Step exposing (Step, Choice, decoder, empty, answered, setAnswer, asAnswerIn)

import Data.FieldType as FieldType exposing (FieldType)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, custom, required, resolve, hardcoded)


type alias Step =
    { fieldType : FieldType
    , choices : List Choice
    , answer : Maybe String
    }


type alias Choice =
    { value : String
    , label : String
    , description : String
    }


decoder : Decoder Step
decoder =
    decode Step
        |> custom FieldType.decoder
        |> required "choices" (Decode.list decodeChoice)
        |> hardcoded Nothing


decodeChoice : Decoder Choice
decodeChoice =
    decode Choice
        |> required "value" Decode.string
        |> required "label" Decode.string
        |> required "description" Decode.string


answered : Step -> Bool
answered { answer } =
    answer
        |> Maybe.map (\n -> True)
        |> Maybe.withDefault False


setAnswer : String -> Step -> Step
setAnswer str step =
    { step | answer = Just str }


asAnswerIn : Step -> String -> Step
asAnswerIn step str =
    { step | answer = Just str }


empty : Step
empty =
    Step FieldType.empty [] Nothing

module Data.Memory.Setup exposing (Setup)

import Data.Memory.Option as Option exposing (Option)
import Data.Memory.Size as Size exposing (Size)


type alias Selectable a =
    { a | id : String, name : String }


type Setup a
    = StepOne
    | StepTwo Option
    | StepThree Option Size
    | StepFour Option Size (List (Selectable a))


getOption : Setup a -> Maybe Option
getOption step =
    case step of
        StepOne ->
            Nothing

        StepTwo option ->
            Just option

        StepThree option _ ->
            Just option

        StepFour option _ _ ->
            Just option


getSize : Setup a -> Maybe Size
getSize step =
    case step of
        StepOne ->
            Nothing

        StepTwo _ ->
            Nothing

        StepThree _ size ->
            Just size

        StepFour _ size _ ->
            Just size


getSelection : Setup a -> Maybe (List (Selectable a))
getSelection step =
    case step of
        StepThree option _ ->
            Just []

        StepFour _ _ selection ->
            Just selection

        _ ->
            Nothing

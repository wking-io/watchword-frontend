-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module WatchWord.Enum.PatternOrderByInput exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-|

  - Id_ASC -
  - Id_DESC -
  - CreatedAt_ASC -
  - CreatedAt_DESC -
  - UpdatedAt_ASC -
  - UpdatedAt_DESC -
  - Name_ASC -
  - Name_DESC -
  - Description_ASC -
  - Description_DESC -
  - Pattern_ASC -
  - Pattern_DESC -
  - FocusType_ASC -
  - FocusType_DESC -

-}
type PatternOrderByInput
    = Id_ASC
    | Id_DESC
    | CreatedAt_ASC
    | CreatedAt_DESC
    | UpdatedAt_ASC
    | UpdatedAt_DESC
    | Name_ASC
    | Name_DESC
    | Description_ASC
    | Description_DESC
    | Pattern_ASC
    | Pattern_DESC
    | FocusType_ASC
    | FocusType_DESC


decoder : Decoder PatternOrderByInput
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "id_ASC" ->
                        Decode.succeed Id_ASC

                    "id_DESC" ->
                        Decode.succeed Id_DESC

                    "createdAt_ASC" ->
                        Decode.succeed CreatedAt_ASC

                    "createdAt_DESC" ->
                        Decode.succeed CreatedAt_DESC

                    "updatedAt_ASC" ->
                        Decode.succeed UpdatedAt_ASC

                    "updatedAt_DESC" ->
                        Decode.succeed UpdatedAt_DESC

                    "name_ASC" ->
                        Decode.succeed Name_ASC

                    "name_DESC" ->
                        Decode.succeed Name_DESC

                    "description_ASC" ->
                        Decode.succeed Description_ASC

                    "description_DESC" ->
                        Decode.succeed Description_DESC

                    "pattern_ASC" ->
                        Decode.succeed Pattern_ASC

                    "pattern_DESC" ->
                        Decode.succeed Pattern_DESC

                    "focusType_ASC" ->
                        Decode.succeed FocusType_ASC

                    "focusType_DESC" ->
                        Decode.succeed FocusType_DESC

                    _ ->
                        Decode.fail ("Invalid PatternOrderByInput type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : PatternOrderByInput -> String
toString enum =
    case enum of
        Id_ASC ->
            "id_ASC"

        Id_DESC ->
            "id_DESC"

        CreatedAt_ASC ->
            "createdAt_ASC"

        CreatedAt_DESC ->
            "createdAt_DESC"

        UpdatedAt_ASC ->
            "updatedAt_ASC"

        UpdatedAt_DESC ->
            "updatedAt_DESC"

        Name_ASC ->
            "name_ASC"

        Name_DESC ->
            "name_DESC"

        Description_ASC ->
            "description_ASC"

        Description_DESC ->
            "description_DESC"

        Pattern_ASC ->
            "pattern_ASC"

        Pattern_DESC ->
            "pattern_DESC"

        FocusType_ASC ->
            "focusType_ASC"

        FocusType_DESC ->
            "focusType_DESC"

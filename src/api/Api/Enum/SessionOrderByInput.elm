-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Api.Enum.SessionOrderByInput exposing (..)

import Json.Decode as Decode exposing (Decoder)


{-|

  - Id_ASC -
  - Id_DESC -
  - Name_ASC -
  - Name_DESC -
  - CreatedAt_ASC -
  - CreatedAt_DESC -
  - UpdatedAt_ASC -
  - UpdatedAt_DESC -
  - Complete_ASC -
  - Complete_DESC -
  - CompletedAt_ASC -
  - CompletedAt_DESC -

-}
type SessionOrderByInput
    = Id_ASC
    | Id_DESC
    | Name_ASC
    | Name_DESC
    | CreatedAt_ASC
    | CreatedAt_DESC
    | UpdatedAt_ASC
    | UpdatedAt_DESC
    | Complete_ASC
    | Complete_DESC
    | CompletedAt_ASC
    | CompletedAt_DESC


decoder : Decoder SessionOrderByInput
decoder =
    Decode.string
        |> Decode.andThen
            (\string ->
                case string of
                    "id_ASC" ->
                        Decode.succeed Id_ASC

                    "id_DESC" ->
                        Decode.succeed Id_DESC

                    "name_ASC" ->
                        Decode.succeed Name_ASC

                    "name_DESC" ->
                        Decode.succeed Name_DESC

                    "createdAt_ASC" ->
                        Decode.succeed CreatedAt_ASC

                    "createdAt_DESC" ->
                        Decode.succeed CreatedAt_DESC

                    "updatedAt_ASC" ->
                        Decode.succeed UpdatedAt_ASC

                    "updatedAt_DESC" ->
                        Decode.succeed UpdatedAt_DESC

                    "complete_ASC" ->
                        Decode.succeed Complete_ASC

                    "complete_DESC" ->
                        Decode.succeed Complete_DESC

                    "completedAt_ASC" ->
                        Decode.succeed CompletedAt_ASC

                    "completedAt_DESC" ->
                        Decode.succeed CompletedAt_DESC

                    _ ->
                        Decode.fail ("Invalid SessionOrderByInput type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : SessionOrderByInput -> String
toString enum =
    case enum of
        Id_ASC ->
            "id_ASC"

        Id_DESC ->
            "id_DESC"

        Name_ASC ->
            "name_ASC"

        Name_DESC ->
            "name_DESC"

        CreatedAt_ASC ->
            "createdAt_ASC"

        CreatedAt_DESC ->
            "createdAt_DESC"

        UpdatedAt_ASC ->
            "updatedAt_ASC"

        UpdatedAt_DESC ->
            "updatedAt_DESC"

        Complete_ASC ->
            "complete_ASC"

        Complete_DESC ->
            "complete_DESC"

        CompletedAt_ASC ->
            "completedAt_ASC"

        CompletedAt_DESC ->
            "completedAt_DESC"

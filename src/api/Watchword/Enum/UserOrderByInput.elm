-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module WatchWord.Enum.UserOrderByInput exposing (..)

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
  - Email_ASC -
  - Email_DESC -
  - Password_ASC -
  - Password_DESC -
  - ResetToken_ASC -
  - ResetToken_DESC -
  - ResetExpires_ASC -
  - ResetExpires_DESC -
  - Role_ASC -
  - Role_DESC -

-}
type UserOrderByInput
    = Id_ASC
    | Id_DESC
    | CreatedAt_ASC
    | CreatedAt_DESC
    | UpdatedAt_ASC
    | UpdatedAt_DESC
    | Name_ASC
    | Name_DESC
    | Email_ASC
    | Email_DESC
    | Password_ASC
    | Password_DESC
    | ResetToken_ASC
    | ResetToken_DESC
    | ResetExpires_ASC
    | ResetExpires_DESC
    | Role_ASC
    | Role_DESC


decoder : Decoder UserOrderByInput
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

                    "email_ASC" ->
                        Decode.succeed Email_ASC

                    "email_DESC" ->
                        Decode.succeed Email_DESC

                    "password_ASC" ->
                        Decode.succeed Password_ASC

                    "password_DESC" ->
                        Decode.succeed Password_DESC

                    "resetToken_ASC" ->
                        Decode.succeed ResetToken_ASC

                    "resetToken_DESC" ->
                        Decode.succeed ResetToken_DESC

                    "resetExpires_ASC" ->
                        Decode.succeed ResetExpires_ASC

                    "resetExpires_DESC" ->
                        Decode.succeed ResetExpires_DESC

                    "role_ASC" ->
                        Decode.succeed Role_ASC

                    "role_DESC" ->
                        Decode.succeed Role_DESC

                    _ ->
                        Decode.fail ("Invalid UserOrderByInput type, " ++ string ++ " try re-running the graphqelm CLI ")
            )


{-| Convert from the union type representating the Enum to a string that the GraphQL server will recognize.
-}
toString : UserOrderByInput -> String
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

        Email_ASC ->
            "email_ASC"

        Email_DESC ->
            "email_DESC"

        Password_ASC ->
            "password_ASC"

        Password_DESC ->
            "password_DESC"

        ResetToken_ASC ->
            "resetToken_ASC"

        ResetToken_DESC ->
            "resetToken_DESC"

        ResetExpires_ASC ->
            "resetExpires_ASC"

        ResetExpires_DESC ->
            "resetExpires_DESC"

        Role_ASC ->
            "role_ASC"

        Role_DESC ->
            "role_DESC"

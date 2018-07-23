module Request.Auth exposing (login, signup, recover, reset)

import Data.UserSession exposing (UserSession)
import Graphqelm.Operation exposing (RootMutation)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.UserSession as UserSession
import WatchWord.Mutation as Mutation
import WatchWord.InputObject exposing (buildLoginInput, LoginInputRequiredFields, buildSignupInput, SignupInputRequiredFields, buildRecoverInput, RecoverInputRequiredFields, buildResetInput, ResetInputRequiredFields)


login : LoginInputRequiredFields -> SelectionSet UserSession RootMutation
login input =
    Mutation.selection identity
        |> with (UserSession.on (Mutation.login { input = buildLoginInput input }))


signup : SignupInputRequiredFields -> SelectionSet UserSession RootMutation
signup input =
    Mutation.selection identity
        |> with (UserSession.on (Mutation.signup { input = buildSignupInput input }))


recover : RecoverInputRequiredFields -> SelectionSet UserSession RootMutation
recover input =
    Mutation.selection identity
        |> with (UserSession.on (Mutation.recover { input = buildRecoverInput input }))


reset : String -> ResetInputRequiredFields -> SelectionSet UserSession RootMutation
reset token input =
    Mutation.selection identity
        |> with (UserSession.on (Mutation.reset { resetToken = token, input = buildResetInput input }))

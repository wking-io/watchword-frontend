module Request.Auth exposing (login, signup, recover, reset)

import Data.UserSession as UserSession exposing (UserSession)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootMutation)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Request.User as User
import WatchWord.Mutation as Mutation
import WatchWord.InputObject exposing (buildLoginInput, LoginInputRequiredFields, buildSignupInput, SignupInputRequiredFields, buildRecoverInput, RecoverInputRequiredFields, buildResetInput, ResetInputRequiredFields)
import WatchWord.Object


base : (SelectionSet UserSession WatchWord.Object.User -> Field UserSession RootMutation) -> Field UserSession RootMutation
base toField =
    User.selection
        |> SelectionSet.map UserSession.create
        |> toField


login : LoginInputRequiredFields -> SelectionSet UserSession RootMutation
login input =
    Mutation.selection identity
        |> with (getLogin input)


getLogin : LoginInputRequiredFields -> Field UserSession RootMutation
getLogin input =
    base <| Mutation.login { input = buildLoginInput input }


signup : SignupInputRequiredFields -> SelectionSet UserSession RootMutation
signup input =
    Mutation.selection identity
        |> with (getSignup input)


getSignup : SignupInputRequiredFields -> Field UserSession RootMutation
getSignup input =
    base <| Mutation.signup { input = buildSignupInput input }


recover : RecoverInputRequiredFields -> SelectionSet UserSession RootMutation
recover input =
    Mutation.selection identity
        |> with (getRecover input)


getRecover : RecoverInputRequiredFields -> Field UserSession RootMutation
getRecover input =
    base <| Mutation.recover { input = buildRecoverInput input }


reset : String -> ResetInputRequiredFields -> SelectionSet UserSession RootMutation
reset token input =
    Mutation.selection identity
        |> with (getReset token input)


getReset : String -> ResetInputRequiredFields -> Field UserSession RootMutation
getReset token input =
    base <| Mutation.reset { resetToken = token, input = buildResetInput input }

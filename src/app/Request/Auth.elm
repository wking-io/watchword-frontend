module Request.Auth exposing (login, signup, recover, reset)

import Data.AuthToken as AuthToken exposing (AuthToken)
import Data.UserSession as UserSession exposing (UserSession)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootMutation)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import Watchword.Enum.UserRole exposing (UserRole)
import Watchword.Mutation as Mutation
import Watchword.InputObject exposing (buildLoginInput, LoginInputRequiredFields, buildSignupInput, SignupInputRequiredFields, buildRecoverInput, RecoverInputRequiredFields, buildResetInput, ResetInputRequiredFields)
import Watchword.Object
import Watchword.Object.AuthPayload as AuthPayload
import Watchword.Object.User as User
import Watchword.Scalar exposing (DateTime)


type alias Response =
    { token : AuthToken
    , user : RequestUser
    }


type alias RequestUser =
    { email : String
    , name : String
    , createdAt : DateTime
    , updatedAt : DateTime
    , role : UserRole
    }


base : (SelectionSet UserSession Watchword.Object.AuthPayload -> Field UserSession RootMutation) -> Field UserSession RootMutation
base toField =
    AuthPayload.selection Response
        |> with AuthToken.fieldDecoder
        |> with getUser
        |> SelectionSet.map buildSession
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


getUser : Field RequestUser Watchword.Object.AuthPayload
getUser =
    User.selection RequestUser
        |> with User.email
        |> with User.name
        |> with User.createdAt
        |> with User.updatedAt
        |> with User.role
        |> AuthPayload.user


buildSession : Response -> UserSession
buildSession { token, user } =
    { user =
        Just
            { email = user.email
            , token = token
            , createdAt = user.createdAt
            , updatedAt = user.updatedAt
            , role = user.role
            }
    }

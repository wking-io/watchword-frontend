module Data.UserSession exposing (UserSession)

import Data.User exposing (User)


type alias UserSession =
    { user : Maybe User }

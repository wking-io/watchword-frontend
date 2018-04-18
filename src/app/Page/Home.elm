module Page.Home exposing (Model, Msg, init, update, view)

import Data.Game as Game exposing (Game)


-- MODEL --


type alias Model =
    { games : List Game }

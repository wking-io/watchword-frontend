module Data.Play exposing (Play, init)

import Data.PlayData exposing (PlayData)
import WatchWord.Scalar exposing (Id)


type Play
    = Init PlayData
    | Setup String PlayData
    | Playing Id PlayData
    | Complete Id PlayData


init : PlayData -> Play
init =
    Init

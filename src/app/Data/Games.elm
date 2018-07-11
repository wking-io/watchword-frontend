module Data.Games exposing (Games, fromList, toList)

import Data.Game as Game exposing (Game)


type Games
    = Games (List Game)


fromList : List Game -> Games
fromList =
    Games


toList : Games -> List Game
toList (Games games) =
    games

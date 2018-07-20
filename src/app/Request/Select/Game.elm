module Request.Select.Game exposing (id)

import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, fieldSelection)
import WatchWord.Object
import WatchWord.Object.Game
import WatchWord.Scalar exposing (Id)


id : SelectionSet Id WatchWord.Object.Game
id =
    fieldSelection WatchWord.Object.Game.id

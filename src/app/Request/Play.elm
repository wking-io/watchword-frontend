module Request.Play exposing (get)

import Data.Play as Play exposing (Play)
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Request.PlayData as PlayData
import WatchWord.Query as Query
import WatchWord.Scalar exposing (Id)
import WatchWord.Union
import WatchWord.Union.PlayData


get : Id -> SelectionSet Play RootQuery
get gameId =
    Query.selection identity
        |> with (getPlay gameId)


getPlay : Id -> Field Play RootQuery
getPlay gameId =
    Query.play { id = gameId } selection
        |> Field.nonNullOrFail


selection : SelectionSet (Maybe Play) WatchWord.Union.PlayData
selection =
    WatchWord.Union.PlayData.selection (Maybe.map Play.init)
        [ WatchWord.Union.PlayData.onConnectData PlayData.connectSelection
        , WatchWord.Union.PlayData.onFilterData PlayData.filterSelection
        , WatchWord.Union.PlayData.onIdentifyData PlayData.identifySelection
        , WatchWord.Union.PlayData.onMemorizeData PlayData.memorizeSelection
        , WatchWord.Union.PlayData.onOrderData PlayData.orderSelection
        ]

module Request.PlayData
    exposing
        ( connectSelection
        , filterSelection
        , identifySelection
        , memorizeSelection
        , orderSelection
        )

import Data.PlayData as PlayData exposing (PlayData, ConnectRaw, FilterRaw, IdentifyRaw, MemorizeRaw, OrderRaw)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)
import Request.Word as Word
import WatchWord.Object
import WatchWord.Object.ConnectData
import WatchWord.Object.FilterData
import WatchWord.Object.IdentifyData
import WatchWord.Object.MemorizeData
import WatchWord.Object.OrderData
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with)


connectSelection : SelectionSet PlayData WatchWord.Object.ConnectData
connectSelection =
    WatchWord.Object.ConnectData.selection ConnectRaw
        |> with WatchWord.Object.ConnectData.id
        |> with WatchWord.Object.ConnectData.name
        |> with WatchWord.Object.ConnectData.focus
        |> with WatchWord.Object.ConnectData.size
        |> with WatchWord.Object.ConnectData.pattern
        |> with (Word.on WatchWord.Object.ConnectData.words)
        |> with (Word.on WatchWord.Object.ConnectData.left)
        |> with (Word.on WatchWord.Object.ConnectData.right)
        |> SelectionSet.map PlayData.connectFromRaw


filterSelection : SelectionSet PlayData WatchWord.Object.FilterData
filterSelection =
    WatchWord.Object.FilterData.selection FilterRaw
        |> with WatchWord.Object.FilterData.id
        |> with WatchWord.Object.FilterData.name
        |> with WatchWord.Object.FilterData.focus
        |> with WatchWord.Object.FilterData.size
        |> with WatchWord.Object.FilterData.pattern
        |> with (Word.on WatchWord.Object.FilterData.words)
        |> with (Word.on WatchWord.Object.FilterData.answer)
        |> with (Word.on WatchWord.Object.FilterData.rest)
        |> SelectionSet.map PlayData.filterFromRaw


identifySelection : SelectionSet PlayData WatchWord.Object.IdentifyData
identifySelection =
    WatchWord.Object.IdentifyData.selection IdentifyRaw
        |> with WatchWord.Object.IdentifyData.id
        |> with WatchWord.Object.IdentifyData.name
        |> with WatchWord.Object.IdentifyData.focus
        |> with WatchWord.Object.IdentifyData.size
        |> with WatchWord.Object.IdentifyData.pattern
        |> with (Word.on WatchWord.Object.IdentifyData.words)
        |> with WatchWord.Object.IdentifyData.options
        |> SelectionSet.map PlayData.identifyFromRaw


memorizeSelection : SelectionSet PlayData WatchWord.Object.MemorizeData
memorizeSelection =
    WatchWord.Object.MemorizeData.selection MemorizeRaw
        |> with WatchWord.Object.MemorizeData.id
        |> with WatchWord.Object.MemorizeData.name
        |> with WatchWord.Object.MemorizeData.focus
        |> with WatchWord.Object.MemorizeData.size
        |> with WatchWord.Object.MemorizeData.pattern
        |> with (Word.on WatchWord.Object.MemorizeData.words)
        |> with (Word.on WatchWord.Object.MemorizeData.memorizeData)
        |> SelectionSet.map PlayData.memorizeFromRaw


orderSelection : SelectionSet PlayData WatchWord.Object.OrderData
orderSelection =
    WatchWord.Object.OrderData.selection OrderRaw
        |> with WatchWord.Object.OrderData.id
        |> with WatchWord.Object.OrderData.name
        |> with WatchWord.Object.OrderData.focus
        |> with WatchWord.Object.OrderData.size
        |> with WatchWord.Object.OrderData.pattern
        |> with (Word.on WatchWord.Object.OrderData.words)
        |> with (Word.on WatchWord.Object.OrderData.orderData)
        |> SelectionSet.map PlayData.orderFromRaw

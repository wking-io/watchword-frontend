module Data.Play exposing (Play, PlayData, ConnectFields, FilterFields, IdentifyFields, MemorizeFields, OrderFields, playSelection)

import Data.Id as Id
import Data.SelectTwo as SelectTwo exposing (SelectTwo)
import Data.Word as Word exposing (Word, WordWithOptions)
import Data.Words exposing (Words)
import SelectList exposing (SelectList)
import WatchWord.Enum.Focus exposing (Focus)
import WatchWord.Enum.PatternType exposing (PatternType)
import Graphqelm.Field as Field exposing (Field)
import WatchWord.Object
import WatchWord.Object.ConnectData
import WatchWord.Object.FilterData
import WatchWord.Object.IdentifyData
import WatchWord.Object.MemorizeData
import WatchWord.Object.OrderData
import WatchWord.Object.Word
import WatchWord.Scalar exposing (Id, DateTime)
import Graphqelm.SelectionSet as SelectionSet exposing (SelectionSet, with, hardcoded)
import WatchWord.Union
import WatchWord.Union.PlayData


type Play
    = Init PlayData
    | Play PlayData
    | Complete PlayData


type PlayData
    = ConnectData ConnectFields
    | FilterData FilterFields
    | IdentifyData IdentifyFields
    | MemorizeData MemorizeFields
    | OrderData OrderFields


type alias ConnectRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , left : Words
    , right : Words
    }


type alias ConnectFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , sessionName : String
    , sessionId : Id
    , data : ( List Word, List Word )
    , answer : SelectTwo Word
    }


type alias FilterRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , answer : Word
    , rest : List Word
    }


type alias FilterFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , sessionName : String
    , sessionId : Id
    , data : ( Word, List Word )
    , answer : Maybe Word
    }


type alias IdentifyRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , options : List String
    }


type alias IdentifyFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , sessionName : String
    , sessionId : Id
    , data : SelectList WordWithOptions
    , answer : String
    }


type alias MemorizeRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , memorizeData : List Word
    }


type alias MemorizeFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , sessionName : String
    , sessionId : Id
    , data : List Word
    , answer : SelectTwo Word
    }


type alias OrderRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , orderData : List Word
    }


type alias OrderFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , sessionName : String
    , sessionId : Id
    , data : SelectList Word
    , answer : ( List String, List String )
    }


playSelection : SelectionSet Play WatchWord.Union.PlayData
playSelection =
    WatchWord.Union.PlayData.selection Init
        [ WatchWord.Union.PlayData.onConnectData connectDataSelection
        , WatchWord.Union.PlayData.onFilterData filterDataSelection
        , WatchWord.Union.PlayData.onIdentifyData identifyDataSelection
        , WatchWord.Union.PlayData.onMemorizeData memorizeDataSelection
        , WatchWord.Union.PlayData.onOrderData orderDataSelection
        ]


connectDataSelection : SelectionSet PlayData WatchWord.Object.ConnectData
connectDataSelection =
    WatchWord.Object.ConnectData.selection ConnectRaw
        |> with WatchWord.Object.ConnectData.id
        |> with WatchWord.Object.ConnectData.name
        |> with WatchWord.Object.ConnectData.focus
        |> with WatchWord.Object.ConnectData.size
        |> with WatchWord.Object.ConnectData.pattern
        |> with (wordOn WatchWord.Object.ConnectData.words)
        |> with (wordOn WatchWord.Object.ConnectData.left)
        |> with (wordOn WatchWord.Object.ConnectData.right)
        |> SelectionSet.map connectRawToData


connectRawToData : ConnectRaw -> PlayData
connectRawToData raw =
    ConnectData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , sessionName = ""
        , sessionId = Id.empty
        , data = ( raw.left, raw.right )
        , answer = SelectTwo.empty
        }


filterDataSelection : SelectionSet PlayData WatchWord.Object.FilterData
filterDataSelection =
    WatchWord.Object.FilterData.selection FilterRaw
        |> with WatchWord.Object.FilterData.id
        |> with WatchWord.Object.FilterData.name
        |> with WatchWord.Object.FilterData.focus
        |> with WatchWord.Object.FilterData.size
        |> with WatchWord.Object.FilterData.pattern
        |> with (wordOn WatchWord.Object.FilterData.words)
        |> with (wordOn WatchWord.Object.FilterData.answer)
        |> with (wordOn WatchWord.Object.FilterData.rest)
        |> SelectionSet.map filterRawToData


filterRawToData : FilterRaw -> PlayData
filterRawToData raw =
    FilterData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , sessionName = ""
        , sessionId = Id.empty
        , data = ( raw.answer, raw.rest )
        , answer = Nothing
        }


identifyDataSelection : SelectionSet PlayData WatchWord.Object.IdentifyData
identifyDataSelection =
    WatchWord.Object.IdentifyData.selection IdentifyRaw
        |> with WatchWord.Object.IdentifyData.id
        |> with WatchWord.Object.IdentifyData.name
        |> with WatchWord.Object.IdentifyData.focus
        |> with WatchWord.Object.IdentifyData.size
        |> with WatchWord.Object.IdentifyData.pattern
        |> with (wordOn WatchWord.Object.IdentifyData.words)
        |> with WatchWord.Object.IdentifyData.options
        |> SelectionSet.map identifyRawToData


identifyRawToData : IdentifyRaw -> PlayData
identifyRawToData raw =
    let
        (selected :: rest) =
            List.map2 Word.addOptions raw.words raw.options
    in
        IdentifyData
            { id = raw.id
            , name = raw.name
            , focus = raw.focus
            , size = raw.size
            , pattern = raw.pattern
            , words = raw.words
            , sessionName = ""
            , sessionId = Id.empty
            , data = SelectList.fromLists [] selected rest
            , answer = ""
            }


memorizeDataSelection : SelectionSet PlayData WatchWord.Object.MemorizeData
memorizeDataSelection =
    WatchWord.Object.MemorizeData.selection MemorizeRaw
        |> with WatchWord.Object.MemorizeData.id
        |> with WatchWord.Object.MemorizeData.name
        |> with WatchWord.Object.MemorizeData.focus
        |> with WatchWord.Object.MemorizeData.size
        |> with WatchWord.Object.MemorizeData.pattern
        |> with (wordOn WatchWord.Object.MemorizeData.words)
        |> with (wordOn WatchWord.Object.MemorizeData.memorizeData)
        |> SelectionSet.map memorizeRawToData


memorizeRawToData : MemorizeRaw -> PlayData
memorizeRawToData raw =
    MemorizeData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , sessionName = ""
        , sessionId = Id.empty
        , data = raw.memorizeData
        , answer = SelectTwo.empty
        }


orderDataSelection : SelectionSet PlayData WatchWord.Object.OrderData
orderDataSelection =
    WatchWord.Object.OrderData.selection OrderRaw
        |> with WatchWord.Object.OrderData.id
        |> with WatchWord.Object.OrderData.name
        |> with WatchWord.Object.OrderData.focus
        |> with WatchWord.Object.OrderData.size
        |> with WatchWord.Object.OrderData.pattern
        |> with (wordOn WatchWord.Object.OrderData.words)
        |> with (wordOn WatchWord.Object.OrderData.orderData)
        |> SelectionSet.map orderRawToData


orderRawToData : OrderRaw -> PlayData
orderRawToData raw =
    let
        (selected :: rest) =
            raw.orderData
    in
        OrderData
            { id = raw.id
            , name = raw.name
            , focus = raw.focus
            , size = raw.size
            , pattern = raw.pattern
            , words = raw.words
            , sessionName = ""
            , sessionId = Id.empty
            , data = SelectList.fromLists [] selected rest
            , answer = ( [], [] )
            }


wordOn : (SelectionSet Word WatchWord.Object.Word -> Field decodesTo a) -> Field decodesTo a
wordOn obj =
    obj wordSelection


wordSelection : SelectionSet Word WatchWord.Object.Word
wordSelection =
    WatchWord.Object.Word.selection Word
        |> with WatchWord.Object.Word.id
        |> with WatchWord.Object.Word.word
        |> with WatchWord.Object.Word.group
        |> with WatchWord.Object.Word.beginning
        |> with WatchWord.Object.Word.ending
        |> with WatchWord.Object.Word.vowel

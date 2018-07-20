module Data.PlayData
    exposing
        ( PlayData
        , ConnectFields
        , ConnectRaw
        , FilterFields
        , FilterRaw
        , IdentifyFields
        , IdentifyRaw
        , MemorizeFields
        , MemorizeRaw
        , OrderFields
        , OrderRaw
        , connectFromRaw
        , filterFromRaw
        , identifyFromRaw
        , memorizeFromRaw
        , orderFromRaw
        )

import Data.SelectTwo as SelectTwo exposing (SelectTwo)
import Data.Word as Word exposing (Word, WordWithOptions)
import Data.Words exposing (Words)
import SelectList exposing (SelectList)
import WatchWord.Enum.Focus exposing (Focus)
import WatchWord.Enum.PatternType exposing (PatternType)
import WatchWord.Scalar exposing (Id, DateTime)


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
    , data : ( Words, Words )
    , answer : SelectTwo Word
    }


connectFromRaw : ConnectRaw -> PlayData
connectFromRaw raw =
    ConnectData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , data = ( raw.left, raw.right )
        , answer = SelectTwo.empty
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
    , data : ( Word, Words )
    , answer : Maybe Word
    }


filterFromRaw : FilterRaw -> PlayData
filterFromRaw raw =
    FilterData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , data = ( raw.answer, raw.rest )
        , answer = Nothing
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
    , data : SelectList WordWithOptions
    , answer : String
    }


identifyFromRaw : IdentifyRaw -> PlayData
identifyFromRaw raw =
    let
        theData =
            case List.map2 Word.addOptions raw.words raw.options of
                selected :: rest ->
                    SelectList.fromLists [] selected rest

                [] ->
                    SelectList.fromLists [] Word.emptyWithOptions []
    in
        IdentifyData
            { id = raw.id
            , name = raw.name
            , focus = raw.focus
            , size = raw.size
            , pattern = raw.pattern
            , words = raw.words
            , data = theData
            , answer = ""
            }


type alias MemorizeRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , memorizeData : Words
    }


type alias MemorizeFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , data : Words
    , answer : SelectTwo Word
    }


memorizeFromRaw : MemorizeRaw -> PlayData
memorizeFromRaw raw =
    MemorizeData
        { id = raw.id
        , name = raw.name
        , focus = raw.focus
        , size = raw.size
        , pattern = raw.pattern
        , words = raw.words
        , data = raw.memorizeData
        , answer = SelectTwo.empty
        }


type alias OrderRaw =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , orderData : Words
    }


type alias OrderFields =
    { id : Id
    , name : String
    , focus : Focus
    , size : Int
    , pattern : PatternType
    , words : Words
    , data : SelectList Word
    , answer : ( List String, List String )
    }


orderFromRaw : OrderRaw -> PlayData
orderFromRaw raw =
    let
        theData =
            case raw.orderData of
                selected :: rest ->
                    SelectList.fromLists [] selected rest

                [] ->
                    SelectList.fromLists [] Word.empty []
    in
        OrderData
            { id = raw.id
            , name = raw.name
            , focus = raw.focus
            , size = raw.size
            , pattern = raw.pattern
            , words = raw.words
            , data = theData
            , answer = ( [], [] )
            }

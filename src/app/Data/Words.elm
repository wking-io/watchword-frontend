module Data.Words exposing (Words, fromList, toList)

-- import Json.Decode as Decode exposing (Decoder)
-- import Json.Decode.Pipeline exposing (decode, required)
-- import List.Extra

import Data.Word as Word exposing (Word)


type Words
    = Words (List Word)


fromList : List Word -> Words
fromList =
    Words


toList : Words -> List Word
toList (Words words) =
    words



-- SERIALIZATION --
-- decoder : Decoder Words
-- decoder =
--     decode Words
--         |> required "data" (Decode.list decodeWord)
-- decodeWord : Decoder Word
-- decodeWord =
--     decode Word
--         |> required "id" (Decode.string |> Decode.map Id)
--         |> required "word" Decode.string
--         |> required "group" Decode.string
--         |> required "beginning" Decode.string
--         |> required "ending" Decode.string
--         |> required "vowel" Decode.string
-- FILTERS --
-- filterBy : (Word -> String) -> (String -> Bool) -> Words -> Words
-- filterBy getter pred (Words words) =
--     List.filter (pred << getter) words |> Words
-- filterByWord : (String -> Bool) -> Words -> Words
-- filterByWord =
--     filterBy (.word)
-- filterByGroup : (String -> Bool) -> Words -> Words
-- filterByGroup =
--     filterBy (.group)
-- filterByBeginning : (String -> Bool) -> Words -> Words
-- filterByBeginning =
--     filterBy (.beginning)
-- filterByEnding : (String -> Bool) -> Words -> Words
-- filterByEnding =
--     filterBy (.ending)
-- filterByVowel : (String -> Bool) -> Words -> Words
-- filterByVowel =
--     filterBy (.vowel)
-- groupByGroup : Words -> List (List Word)
-- groupByGroup (Words words) =
--     List.Extra.groupWhile (\x y -> x.group == y.group) words
-- duplicate : Words -> Words
-- duplicate (Words words) =
--     Words (words ++ words)
-- length : Words -> Int
-- length (Words words) =
--     List.length words
-- toList : Words -> List Word
-- toList (Words words) =
--     words
-- empty : Words
-- empty =
--     Words []
-- map : (Word -> a) -> Words -> List a
-- map f (Words words) =
--     List.map f words
-- getGroups : Words -> List String
-- getGroups (Words words) =
--     List.map .group words
--         |> List.Extra.unique
-- getGroupWords : Words -> List ( String, List Word )
-- getGroupWords (Words words) =
--     let
--         groups =
--             List.map .group words
--                 |> List.Extra.unique
--                 |> List.sort
--         wordGroups =
--             List.sortBy .group words
--                 |> List.Extra.groupWhile (\x y -> x.group == y.group)
--     in
--         List.Extra.zip groups wordGroups

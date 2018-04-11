module Data.Card exposing (Card, fromWord)

import Data.Word as Word exposing (Word)


type alias Card =
    { word : String
    , order : Int
    , id : String
    }


fromWord : Word -> Int -> Card
fromWord word int =
    Card (Word.toString word) int ((Word.toString word) ++ "-" ++ (toString int))

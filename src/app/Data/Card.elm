module Data.Card exposing (Card, fromWord, equals, equalsId)

import Data.Word as Word exposing (Word)


type alias Card =
    { word : String
    , order : Int
    , id : String
    }


fromWord : Word -> Int -> Card
fromWord word int =
    Card (Word.toString word) int ((Word.toString word) ++ "-" ++ (toString int))


equals : Card -> Card -> Bool
equals a b =
    a.word == b.word


equalsId : String -> Card -> Bool
equalsId id card =
    card.id == id

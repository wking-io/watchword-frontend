module Data.Card exposing (Card, fromWord, equals, equalsId)

import Data.Words as Words exposing (Words, Word)


type alias Card =
    { word : String
    , order : Int
    , id : String
    }


fromWord : Int -> Word -> Card
fromWord int { word } =
    Card word int (word ++ "-" ++ (toString int))


equals : Card -> Card -> Bool
equals a b =
    a.word == b.word


equalsId : String -> Card -> Bool
equalsId id card =
    card.id == id

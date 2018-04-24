module Data.Card exposing (Card, fromWord, equals, equalsId)

import Data.Words as Words exposing (Words, Word)


type alias Card =
    { word : String
    , order : Int
    , id : String
    }


fromWord : Word -> Int -> Card
fromWord { name } int =
    Card name int (name ++ "-" ++ (toString int))


equals : Card -> Card -> Bool
equals a b =
    a.word == b.word


equalsId : String -> Card -> Bool
equalsId id card =
    card.id == id

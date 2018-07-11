module Data.Words exposing (Words, fromList, toList)

import Data.Word as Word exposing (Word)


type Words
    = Words (List Word)


fromList : List Word -> Words
fromList =
    Words


toList : Words -> List Word
toList (Words words) =
    words

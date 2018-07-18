module Data.Word exposing (Word, WordWithOptions, idToHtml, addOptions, empty, emptyWithOptions)

import Data.Id as Id
import Html exposing (Html)
import WatchWord.Enum.Focus exposing (Focus(..))
import WatchWord.Scalar exposing (Id(..))


type alias Word =
    { id : Id
    , word : String
    , group : String
    , beginning : String
    , ending : String
    , vowel : String
    }


type alias WordWithOptions =
    { word : Word
    , options : List String
    }


idToHtml : Word -> Html msg
idToHtml { id } =
    case id of
        Id id ->
            Html.text id


addOptions : Word -> String -> WordWithOptions
addOptions w optionsString =
    { word = w
    , options = String.split "/" optionsString
    }


empty : Word
empty =
    { id = Id.empty
    , word = ""
    , group = ""
    , beginning = ""
    , ending = ""
    , vowel = ""
    }


emptyWithOptions : WordWithOptions
emptyWithOptions =
    { word = empty
    , options = []
    }

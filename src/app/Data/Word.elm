module Data.Word exposing (Word, idToHtml)

import Html exposing (Html)
import Watchword.Scalar exposing (Id(..))


type Words
    = Words (List Word)


type alias Word =
    { id : Id
    , word : String
    , group : String
    , beginning : String
    , ending : String
    , vowel : String
    }


idToHtml : Word -> Html msg
idToHtml { id } =
    case id of
        Id id ->
            Html.text id

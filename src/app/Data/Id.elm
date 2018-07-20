module Data.Id exposing (empty)

import Html exposing (Html)
import WatchWord.Scalar exposing (Id(..))


empty : Id
empty =
    Id ""


toHtml : Id -> Html msg
toHtml (Id id) =
    Html.text id

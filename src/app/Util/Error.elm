module Util.Error exposing (error)

import Html exposing (Html, main_, text)


error : a -> Html msg
error a =
    main_ [] [ text <| toString a ]

module Util exposing ((=>), error, delay)

import Html exposing (Html, main_, text)
import Process
import Time exposing (Time)
import Task


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


{-| infixl 0 means the (=>) operator has the same precedence as (<|) and (|>),
meaning you can use it at the end of a pipeline and have the precedence work out.
-}
infixl 0 =>


error : a -> Html msg
error a =
    main_ [] [ text <| toString a ]


delay : Time -> msg -> Cmd msg
delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)

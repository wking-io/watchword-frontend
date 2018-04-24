module Util.Delay exposing (delay)

import Process
import Time exposing (Time)
import Task


delay : Time -> msg -> Cmd msg
delay time msg =
    Process.sleep time
        |> Task.perform (\_ -> msg)

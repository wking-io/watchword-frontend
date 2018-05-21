module Util.RemoveNothing exposing (removeNothing)


removeNothing : List (Maybe a) -> List a
removeNothing =
    List.foldr foldrValues []


foldrValues : Maybe a -> List a -> List a
foldrValues item list =
    case item of
        Nothing ->
            list

        Just v ->
            v :: list

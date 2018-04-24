module Util.IsIn exposing (isIn)


isIn : List String -> String -> Bool
isIn =
    flip List.member

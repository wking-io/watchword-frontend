module Data.SelectTwo exposing (SelectTwo, empty)


type SelectTwo a
    = Empty
    | SelectOne a
    | SelectTwo a a


empty : SelectTwo a
empty =
    Empty

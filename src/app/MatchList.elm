module MatchList
    exposing
        ( MatchList(Empty, One, Two)
        , unmatched
        , matched
        , selected
        , map
        , Position
        , mapBy
        , select
        , isComparable
        , compare
        , append
        , prepend
        , fromList
        , toList
        )

{-| A `MatchList` is a data type that can track the comparison of values in a list.

@docs MatchList, fromLists


## Reading

@docs toList, before, selected, after


## Transforming

@docs map, mapBy, Position, select, compare, append, prepend

-}


{-| A nonempty list which always has exactly one element selected.

Create one using [`fromList`](#fromList).

-}
type MatchList a
    = Empty (List a) (List a)
    | One (List a) a (List a)
    | Two (List a) ( a, a ) (List a)


unmatched : MatchList a -> List a
unmatched matchlist =
    case matchlist of
        Empty unmatched _ ->
            unmatched

        One unmatched selected _ ->
            selected :: unmatched

        Two unmatched ( a, b ) _ ->
            b :: a :: unmatched


matched : MatchList a -> List a
matched matchlist =
    case matchlist of
        Empty _ matched ->
            matched

        One _ _ matched ->
            matched

        Two _ _ matched ->
            matched


selected : MatchList a -> List a
selected matchlist =
    case matchlist of
        Empty _ _ ->
            []

        One _ selected _ ->
            [ selected ]

        Two _ ( a, b ) _ ->
            [ a, b ]


map : (a -> b) -> MatchList a -> MatchList b
map transform matchlist =
    case matchlist of
        Empty unmatched matched ->
            Empty
                (List.map transform unmatched)
                (List.map transform matched)

        One unmatched selected matched ->
            One
                (List.map transform unmatched)
                (transform selected)
                (List.map transform matched)

        Two unmatched selected matched ->
            Two
                (List.map transform unmatched)
                (selected
                    |> Tuple.mapFirst transform
                    |> Tuple.mapSecond transform
                )
                (List.map transform matched)


type Position
    = Unmatched
    | Selected
    | Matched


mapBy : (Position -> a -> b) -> MatchList a -> MatchList b
mapBy transform matchlist =
    case matchlist of
        Empty unmatched matched ->
            Empty
                (List.map (transform Unmatched) unmatched)
                (List.map (transform Matched) matched)

        One unmatched selected matched ->
            One
                (List.map (transform Unmatched) unmatched)
                (transform Selected selected)
                (List.map (transform Matched) matched)

        Two unmatched selected matched ->
            Two
                (List.map (transform Unmatched) unmatched)
                (selected
                    |> Tuple.mapFirst (transform Selected)
                    |> Tuple.mapSecond (transform Selected)
                )
                (List.map (transform Matched) matched)


select : (a -> Bool) -> MatchList a -> MatchList a
select isSelectable matchlist =
    case matchlist of
        Empty unmatched matched ->
            case selectHelp isSelectable unmatched of
                Nothing ->
                    matchlist

                Just selection ->
                    let
                        leftovers =
                            List.filter (\a -> a /= selection) unmatched
                    in
                        One leftovers selection matched

        One unmatched a matched ->
            case selectHelp isSelectable (a :: unmatched) of
                Nothing ->
                    matchlist

                Just selection ->
                    let
                        isCurrent =
                            a == selection

                        leftovers =
                            List.filter (\a -> a /= selection) unmatched
                    in
                        if isCurrent then
                            Empty (a :: unmatched) matched
                        else
                            Two leftovers ( a, selection ) matched

        Two _ _ _ ->
            matchlist


selectHelp : (a -> Bool) -> List a -> Maybe a
selectHelp isSelectable list =
    list
        |> List.filter isSelectable
        |> List.head


isComparable : MatchList a -> Bool
isComparable matchlist =
    case matchlist of
        Two _ _ _ ->
            True

        _ ->
            False


compare : (a -> a -> Bool) -> MatchList a -> MatchList a
compare isComparable matchlist =
    case matchlist of
        Two unmatched ( a, b ) matched ->
            if isComparable a b then
                Empty unmatched (a :: b :: matched)
            else
                Empty (a :: b :: unmatched) matched

        _ ->
            matchlist


{-| Returns a `MatchList`.

    import MatchList

    MatchList.fromList [ 1, 2, 3, 4, 5 ]
        |> MatchList.prepend

    == [ 1, 2, 3, 4, 5 ]

-}
append : a -> MatchList a -> MatchList a
append a matchlist =
    case matchlist of
        Empty unmatched matched ->
            Empty (List.append unmatched [ a ]) matched

        One unmatched selected matched ->
            One (List.append unmatched [ a ]) selected matched

        Two unmatched selected matched ->
            Two (List.append unmatched [ a ]) selected matched


{-| Returns a `MatchList`.

    import MatchList

    MatchList.fromList [ 1, 2, 3, 4, 5 ]
        |> MatchList.unmatched

    == [ 1, 2, 3, 4, 5 ]

-}
prepend : a -> MatchList a -> MatchList a
prepend a matchlist =
    case matchlist of
        Empty unmatched matched ->
            Empty (a :: unmatched) matched

        One unmatched selected matched ->
            One (a :: unmatched) selected matched

        Two unmatched selected matched ->
            Two (a :: unmatched) selected matched


{-| Returns a `MatchList`.

    import MatchList

    MatchList.fromList [ 1, 2, 3, 4, 5 ]
        |> MatchList.unmatched

    == [ 1, 2, 3, 4, 5 ]

-}
fromList : List a -> MatchList a
fromList list =
    Empty list []


{-| Return a `List` containing the elements in a `MatchList`.

    import MatchList

    SelectList.fromList [ 1, 2, 3, 4, 5 ]
        |> SelectList.toList

    == [ 1, 2, 3, 4, 5 ]

-}
toList : MatchList a -> List a
toList matchlist =
    case matchlist of
        Empty unmatched matched ->
            unmatched ++ matched

        One unmatched a matched ->
            unmatched ++ a :: matched

        Two unmatched ( a, b ) matched ->
            unmatched ++ a :: b :: matched

module Data.Selection exposing (Selection(..), empty, addOption, addSize)

import Data.Option as Option exposing (Option)
import Data.Size as Size exposing (Size)


type Selection
    = Empty
    | OptionOnly Option
    | OptionAndSize Option Size
    | Full Option Size (List String)


empty : Selection
empty =
    Empty


addOption : Result String Option -> Selection
addOption res =
    case res of
        Ok option ->
            OptionOnly option

        Err error ->
            let
                _ =
                    Debug.log "Error: " error
            in
                Empty


addSize : Option -> Result String Size -> Selection
addSize option res =
    case res of
        Ok size ->
            OptionAndSize option size

        Err error ->
            let
                _ =
                    Debug.log "Error: " error
            in
                OptionOnly option

module Route exposing (Route(..), fromLocation, href, modifyUrl)

import Data.Admin as Admin
import Data.Memory.Option as Option exposing (Option)
import Data.Memory.Size as Size exposing (Size)
import Data.Memory as Memory
import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), (<?>), Parser, QueryParser, oneOf, parseHash, s, string, customParam)


-- ROUTING --


type Route
    = Root Admin.Slug
    | Admin Admin.Slug
    | AdminSelected Admin.Slug
    | AdminSetup Admin.Slug
    | MemoryGame Memory.Slug


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Admin.Init (s "") |> Url.map Root
        , Url.map Admin.Init (s "dashboard") |> Url.map Admin
        , Url.map AdminSelected (s "dashboard" </> Admin.parser)
        , Url.map AdminSetup (s "dashboard" </> Admin.parser </> s "setup")
        , Url.map Memory.Slug (s "memory" </> s "game" </> Option.parser </> Size.parser <?> listParam "selection")
            |> Url.map MemoryGame
        ]



-- INTERNAL --


listParam : String -> QueryParser (Maybe (List String) -> b) b
listParam key =
    customParam key
        (\maybeString ->
            maybeString
                |> Maybe.map (String.split ",")
        )


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Root _ ->
                    [ "dashboard" ]

                Admin _ ->
                    [ "dashboard" ]

                AdminSelected slug ->
                    [ "dashboard", (Admin.slugToString slug) ]

                AdminSetup slug ->
                    [ "dashboard", (Admin.slugToString slug), "setup" ]

                MemoryGame slug ->
                    [ "memory", "game", (Memory.toString slug) ]
    in
        "#/" ++ String.join "/" pieces



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just (Root Admin.Init)
    else
        parseHash route location

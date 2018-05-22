module Route exposing (Route(..), fromLocation, href, modifyUrl)

import Data.Admin as Admin exposing (Slug)
import Data.Option as Option exposing (Option)
import Data.Size as Size exposing (Size)
import Data.Memory as Memory
import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), (<?>), Parser, QueryParser, oneOf, parseHash, s, string, customParam)


-- ROUTING --


type Route
    = Root Admin.Slug
    | Admin Admin.Slug
    | AdminSetup Admin.Slug
    | MemoryGame Memory.Slug
    | Test


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Admin.Init (s "") |> Url.map Root
        , Url.map Admin.Init (s "dashboard") |> Url.map Admin
        , Url.map Admin.WithGame (s "dashboard" </> Url.string)
            |> Url.map Admin
        , Url.map Admin.WithSetup (s "dashboard" </> Url.string </> s "setup")
            |> Url.map AdminSetup
        , Url.map Admin.WithOption (s "dashboard" </> Url.string </> s "setup" </> Option.parser)
            |> Url.map AdminSetup
        , Url.map Admin.WithSize (s "dashboard" </> Url.string </> s "setup" </> Option.parser </> Size.parser)
            |> Url.map AdminSetup
        , Url.map Admin.WithWords (s "dashboard" </> Url.string </> s "setup" </> Option.parser </> Size.parser <?> listParam "selection")
            |> Url.map AdminSetup
        , Url.map Memory.Slug (s "memory" </> s "game" </> Option.parser </> Size.parser <?> listParam "selection")
            |> Url.map MemoryGame
        , Url.map Test (s "test")
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

                Admin slug ->
                    [ "dashboard", (Admin.slugToString slug) ]

                AdminSetup slug ->
                    [ "dashboard", (Admin.slugToString slug) ]

                MemoryGame slug ->
                    [ "memory", "game", (Memory.toString slug) ]

                Test ->
                    [ "test" ]
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

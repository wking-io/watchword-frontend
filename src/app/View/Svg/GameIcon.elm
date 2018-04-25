module View.Svg.GameIcon exposing (icons, default)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Dict exposing (Dict)


icons : String -> Bool -> Maybe (Svg msg)
icons key isActive =
    let
        icons =
            Dict.fromList [ ( "memory", (hydrate memory isActive) ) ]
    in
        Dict.get key icons


hydrate : (( String, String ) -> Svg msg) -> Bool -> Svg msg
hydrate icon isActive =
    icon (colorPair isActive)


memory : ( String, String ) -> Svg msg
memory ( primary, secondary ) =
    Svg.svg [ width "20px", height "20px", viewBox "0 0 20 20" ]
        [ Svg.rect [ width "11", height "15", x ".5", y ".5", fill primary, rx ".5", ry ".5" ] []
        , Svg.path [ d "M11 1v14H1V1h10m0-1H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z", fill secondary ] []
        , Svg.rect [ width "11", height "15", x "8.5", y "4.5", fill "#fff", rx ".5", ry ".5" ] []
        , Svg.path [ d "M19 5v14H9V5h10m0-1H9a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1z", fill secondary ] []
        ]


default : Bool -> Svg msg
default =
    hydrate defaultIcon


defaultIcon : ( String, String ) -> Svg msg
defaultIcon ( primary, secondary ) =
    Svg.svg [ width "20px", height "20px", viewBox "0 0 20 20" ]
        [ Svg.rect [ width "11", height "15", x ".5", y ".5", fill primary, rx ".5", ry ".5" ] []
        , Svg.path [ d "M11 1v14H1V1h10m0-1H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z", fill secondary ] []
        , Svg.rect [ width "11", height "15", x "8.5", y "4.5", fill "#fff", rx ".5", ry ".5" ] []
        , Svg.path [ d "M19 5v14H9V5h10m0-1H9a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V5a1 1 0 0 0-1-1z", fill secondary ] []
        ]


colorPair : Bool -> ( String, String )
colorPair isActive =
    if isActive then
        ( "#3bc9db", "#0B7285" )
    else
        ( "#CED4DA", "#868E96" )

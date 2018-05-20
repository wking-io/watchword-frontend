module Styles.Vars exposing (color, font)

import Css exposing (Color, hex, sansSerif)


type alias Colors =
    { black : Color
    , neutralDark : Color
    , neutralExtraLight : Color
    , neutralLight : Color
    , neutralMedium : Color
    , primary : Color
    , primaryDark : Color
    , white : Color
    }


color : Colors
color =
    { primary = (hex "3bc9db")
    , primaryDark = (hex "0b7285")
    , neutralExtraLight = (hex "f1f3f5")
    , neutralLight = (hex "ced4da")
    , neutralMedium = (hex "868e96")
    , neutralDark = (hex "495057")
    , white = (hex "ffffff")
    , black = (hex "495057")
    }


type alias Fonts =
    { sans : List String
    , serif : List String
    }


font : Fonts
font =
    { sans = [ "Roboto", (.value sansSerif) ]
    , serif = [ "Roboto Slab", "Roboto", (.value sansSerif) ]
    }

module View.Asset exposing (src, cardBack, sketchWords)

import Dict exposing (Dict)
import Html exposing (Attribute, Html)
import Html.Attributes as Attr


type Image
    = Image String


imageUrl : String
imageUrl =
    "assets/images"



-- IMAGES --


cardBack : Image
cardBack =
    Image (imageUrl ++ "cardback.jpg")


sketchWords : Dict String Image
sketchWords =
    Dict.fromList
        [ ( "bat", Image (imageUrl ++ "bat.jpg") )
        ]



-- USING IMAGES --


src : Image -> Attribute msg
src (Image url) =
    Attr.src url

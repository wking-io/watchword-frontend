module View.Asset exposing (src, cardBack, summary)

import Html exposing (Attribute, Html)
import Html.Attributes as Attr


type Image
    = Image String


imageUrl : String
imageUrl =
    "assets/images/"



-- IMAGES --


cardBack : Image
cardBack =
    Image (imageUrl ++ "cardback.jpg")


summary : String -> Image
summary filename =
    Image (imageUrl ++ "summary/" ++ filename ++ ".jpg")



-- USING IMAGES --


src : Image -> Attribute msg
src (Image url) =
    Attr.src url

module View.Asset exposing (src, cardBack, contact, info, logo, summary)

import Html exposing (Attribute, Html)
import Html.Attributes as Attr


type Image
    = Image String


imageUrl : String
imageUrl =
    "assets/images/"



-- IMAGES --


logo : Image
logo =
    Image (imageUrl ++ "logo.png")


info : Image
info =
    Image (imageUrl ++ "info.png")


contact : Image
contact =
    Image (imageUrl ++ "contact.png")


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

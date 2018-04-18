module View.Page exposing (frame)

{-| The frame around a typical page - that is, the header and footer.
-}

import Html exposing (..)
import Html.Attributes exposing (..)


{-| Take a page's Html and frame it with a header and footer.
The caller provides the current user, so we can display in either
"signed in" (rendering username) or "signed out" mode.
isLoading is for determining whether we should show a loading spinner
in the header. (This comes up during slow page transitions.)
-}
frame : Bool -> Html msg -> Html msg
frame isLoading content =
    div [ class "page-frame" ]
        [ viewHeader isLoading
        , content
        , viewFooter
        ]


viewHeader : Bool -> Html msg
viewHeader isLoading =
    nav [ class "navbar" ]
        [ div [ class "container" ]
            [ p [] [ text "school-apps" ] ]
        ]


viewFooter : Html msg
viewFooter =
    footer []
        [ div [ class "container" ]
            [ p [] [ text "made by wking-io" ]
            ]
        ]

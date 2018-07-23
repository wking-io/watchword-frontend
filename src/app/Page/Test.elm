module Page.Test exposing (Model, Msg, init, view, update)

import Data.AuthToken exposing (testToken)
import Data.Pattern exposing (Pattern)
import Html exposing (Html)
import Html.Attributes as HA
import Request
import Data.UserSession as UserSession exposing (UserSession)
import Request.Setup as Setup
import Page.Errored exposing (PageLoadError, pageLoadError)
import SelectList exposing (SelectList)
import Util.Infix exposing ((=>))
import Task exposing (Task)
import WatchWord.Enum.PatternType exposing (PatternType(..))
import WatchWord.Scalar exposing (Id(..))


type alias Model =
    { data : Maybe Pattern
    }


init : UserSession -> Task PageLoadError Model
init session =
    let
        handleLoadError _ =
            pageLoadError "Test page is currently unavailable."

        maybeAuthToken =
            Just testToken

        input =
            { email = "contact+gene@wking.io"
            , password = "AIRsoft.9"
            }

        resetToken =
            "c2228a930f95e6cba4ef5f8a7db905a3ec5ec1a01532364287518"

        singleGame =
            Id "cjjc7fi0umfxm0b962kvgizl8"
    in
        Setup.get Identify
            |> Request.query maybeAuthToken
            |> Task.map Model
            |> Task.mapError (Debug.log "Error: ")
            |> Task.mapError handleLoadError


view : Model -> Html Msg
view { data } =
    Html.div []
        [ Html.h2 [] [ Html.text "Data" ]
        , Html.pre
            [ HA.style
                [ ( "display", "block" )
                , ( "padding", "4rem" )
                , ( "color", "black" )
                , ( "background-color", "rgba(0, 0, 0, 0.05)" )
                , ( "white-space", "pre-wrap" )
                , ( "word-break", "break-word" )
                , ( "line-height", "1.6" )
                ]
            ]
            [ Html.text (toString data) ]
        ]


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model => Cmd.none

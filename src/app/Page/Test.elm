module Page.Test exposing (Model, Msg, init, view, update)

import Data.AuthToken exposing (testToken)
import Data.Play exposing (Play)
import Html exposing (Html)
import Html.Attributes as HA
import Request
import Data.UserSession exposing (UserSession)
import Request.Play as Play
import Page.Errored exposing (PageLoadError, pageLoadError)
import Util.Infix exposing ((=>))
import Task exposing (Task)
import WatchWord.Scalar exposing (Id(..))


type alias Model =
    { data : Play
    }


init : UserSession -> Task PageLoadError Model
init session =
    let
        handleLoadError _ =
            pageLoadError "Test page is currently unavailable."

        maybeAuthToken =
            Just testToken

        input =
            { email = "contact@wking.io"
            , password = "AIRsoft9"
            }

        resetToken =
            "f25e8de7d36fab872f0a29b9add2e1ebae5459c91531616933395"

        singleGame =
            Id "cjjc7fi0umfxm0b962kvgizl8"
    in
        Play.get singleGame
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

module Page.Test exposing (Model, Msg, init, view, update)

import Data.AuthToken exposing (testToken)
import Data.Session exposing (Session)
import Html exposing (Html)
import Html.Attributes as HA
import Request


-- import Request.Dashboard as Dashboard exposing (Response)

import Data.Session exposing (Session)
import Request.Auth as Auth
import Page.Errored exposing (PageLoadError, pageLoadError)
import Util.Infix exposing ((=>))
import Task exposing (Task)


type alias Model =
    { data : Session
    }


init : Session -> Task PageLoadError Model
init session =
    let
        handleLoadError _ =
            pageLoadError "Test page is currently unavailable."

        maybeAuthToken =
            Just testToken

        input =
            { email = "contact@wking.io"
            , password = "AIRsoft.9"
            }
    in
        Auth.login input
            |> Request.mutation maybeAuthToken
            |> Task.map Model
            |> Debug.log "Error: "
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

module Page.Test exposing (Model, Msg, init, view, update)

import Data.Session exposing (Session)
import Html exposing (Html, text, div, ul, li)
import Request.Words as Words exposing (Response, Word)
import Page.Errored exposing (PageLoadError, pageLoadError)
import Util.Infix exposing ((=>))
import Task exposing (Task)


type alias Model =
    { words : List Word
    }


init : Session -> Task PageLoadError Model
init session =
    let
        handleLoadError _ =
            pageLoadError "Test page is currently unavailable."

        maybeAuthToken =
            Maybe.map .token session.user
    in
        Task.map Model (Words.get maybeAuthToken)
            |> Task.mapError handleLoadError


view : Model -> Html Msg
view { words } =
    div []
        [ ul [] (List.map viewWord words) ]


viewWord : Word -> Html Msg
viewWord { word } =
    li [] [ text word ]


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model => Cmd.none

module Page.Test exposing (Model, Msg, init, view, update)

import Html exposing (Html, text, div, ul, li)
import Request.Words as Words exposing (Response, Word)
import Page.Errored exposing (PageLoadError, pageLoadError)
import Util.Infix exposing ((=>))
import Task exposing (Task)


type alias Model =
    { words : List Word
    }


init : Task PageLoadError Model
init =
    let
        handleLoadError _ =
            pageLoadError "Testpage is currently unavailable."
    in
        Task.map Model Words.get
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

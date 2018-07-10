module Page.Test exposing (Model, Msg, init, view, update)

import Data.Session exposing (Session)
import Data.Word as Word exposing (Word)
import Data.Words as Words exposing (Words)
import Html exposing (Html)
import Request
import Request.Test as Test
import Page.Errored exposing (PageLoadError, pageLoadError)
import Util.Infix exposing ((=>))
import Task exposing (Task)


type alias Model =
    { words : Words
    }


init : Session -> Task PageLoadError Model
init session =
    let
        handleLoadError _ =
            pageLoadError "Test page is currently unavailable."

        maybeAuthToken =
            Maybe.map .token session.user
    in
        Request.make maybeAuthToken Test.get
            |> Task.map Model
            |> Task.mapError handleLoadError


view : Model -> Html Msg
view { words } =
    Html.div []
        [ Html.h2 [] [ Html.text "Words" ]
        , Html.ul [] (Words.toList words |> List.map viewWord)
        ]


viewWord : Word -> Html Msg
viewWord { word } =
    Html.li [] [ Html.text word ]


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model => Cmd.none

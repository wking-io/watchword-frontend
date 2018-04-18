module Main exposing (main)

import Html exposing (Html, program, text, div, ul, li, img, p)
import Html.Attributes exposing (class, classList)
import Page.Home as Home
import Page.Memory as Memory
import Page.Memory.Setup as MemorySetup
import Page.Errored as Errored exposing (PageLoadError)


type Page
    = Blank
    | NotFound
    | Errored PageLoadError
    | Home Home.Model
    | Memory Memory.Model
    | MemorySetup MemorySetup.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page



-- MODEL --


type alias Model =
    { pageState : PageState }


init : ( Model, Cmd Msg )
init =
    ( Model (Loaded Blank), Cmd.none )



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "container" ] []



-- UPDATE --


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS
-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }

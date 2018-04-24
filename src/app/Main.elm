module Main exposing (main)

import Html exposing (Html, program, text, div, ul, li, img, p)
import Page.Admin as Admin
import Page.Memory.Game as MemoryGame
import Page.NotFound as NotFound
import Page.Errored as Errored exposing (PageLoadError)
import Navigation exposing (Location)
import Route exposing (Route)
import Util.Infix exposing ((=>))
import Random exposing (Generator)
import View.Page as Page


type Page
    = Blank
    | NotFound
    | Errored PageLoadError
    | Admin Admin.Model
    | MemoryGame MemoryGame.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


getPage : PageState -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page



-- MODEL --


type alias Model =
    { pageState : PageState }


init : Location -> ( Model, Cmd Msg )
init location =
    setRoute (Route.fromLocation location) (Model (Loaded initialPage))


initialPage : Page
initialPage =
    Blank



-- VIEW --


view : Model -> Html Msg
view model =
    case model.pageState of
        Loaded page ->
            viewPage False page

        TransitioningFrom page ->
            viewPage True page


viewPage : Bool -> Page -> Html Msg
viewPage isLoading page =
    let
        frame =
            Page.frame isLoading
    in
        case page of
            NotFound ->
                NotFound.view
                    |> frame

            Blank ->
                -- This is for the very initial page load, while we are loading
                -- data via HTTP. We could also render a spinner here.
                Html.text ""
                    |> frame

            Errored subModel ->
                Errored.view subModel
                    |> frame

            Admin subModel ->
                Admin.view subModel
                    |> frame
                    |> Html.map AdminMsg

            MemoryGame subModel ->
                MemoryGame.view subModel
                    |> frame
                    |> Html.map MemoryGameMsg



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
    | AdminLoaded (Result PageLoadError Admin.Model)
    | MemoryGameLoaded MemoryGame.Model
    | AdminMsg Admin.Msg
    | MemoryGameMsg MemoryGame.Msg


setRoute : Maybe Route -> Model -> ( Model, Cmd Msg )
setRoute maybeRoute model =
    let
        generate msg result =
            case result of
                Ok generator ->
                    { model | pageState = TransitioningFrom (getPage model.pageState) }
                        => Random.generate msg generator

                Err error ->
                    { model | pageState = Loaded (Errored error) } => Cmd.none

        isError page init =
            case init of
                Ok subModel ->
                    { model | pageState = Loaded (page subModel) } => Cmd.none

                Err error ->
                    { model | pageState = Loaded (Errored error) } => Cmd.none

        errored =
            pageErrored model
    in
        case maybeRoute of
            Nothing ->
                { model | pageState = Loaded NotFound } => Cmd.none

            Just Route.Admin ->
                isError Admin Admin.init

            Just Route.Root ->
                model => Route.modifyUrl Route.Admin

            Just (Route.MemoryGame slug) ->
                generate MemoryGameLoaded (MemoryGame.init slug)


pageErrored : Model -> String -> ( Model, Cmd msg )
pageErrored model errorMessage =
    let
        error =
            Errored.pageLoadError errorMessage
    in
        { model | pageState = Loaded (Errored error) } => Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updatePage (getPage model.pageState) msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
                ( { model | pageState = Loaded (toModel newModel) }, Cmd.map toMsg newCmd )

        errored =
            pageErrored model
    in
        case ( msg, page ) of
            ( SetRoute route, _ ) ->
                setRoute route model

            ( AdminLoaded (Ok subModel), _ ) ->
                { model | pageState = Loaded (Admin subModel) } => Cmd.none

            ( AdminLoaded (Err error), _ ) ->
                { model | pageState = Loaded (Errored error) } => Cmd.none

            ( MemoryGameLoaded subModel, _ ) ->
                { model | pageState = Loaded (MemoryGame subModel) } => Cmd.none

            ( AdminMsg subMsg, Admin subModel ) ->
                toPage Admin AdminMsg Admin.update subMsg subModel

            ( MemoryGameMsg subMsg, MemoryGame subModel ) ->
                toPage MemoryGame MemoryGameMsg MemoryGame.update subMsg subModel

            ( _, NotFound ) ->
                -- Disregard incoming messages when we're on the
                -- NotFound page.
                model => Cmd.none

            ( _, _ ) ->
                -- Disregard incoming messages that arrived for the wrong page
                model => Cmd.none



-- SUBSCRIPTIONS
-- MAIN


main : Program Never Model Msg
main =
    Navigation.program (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }

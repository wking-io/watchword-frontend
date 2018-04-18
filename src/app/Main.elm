module Main exposing (main)

import Html exposing (Html, program, text, div, ul, li, img, p)
import Html.Attributes exposing (class, classList)
import Page.Home as Home
import Page.Memory as Memory
import Page.Memory.Setup as MemorySetup
import Page.NotFound as NotFound
import Page.Errored as Errored exposing (PageLoadError)
import Navigation exposing (Location)
import Route exposing (Route)
import Util exposing ((=>))
import Random exposing (Generator)
import View.Page as Page


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

            Home subModel ->
                Home.view subModel
                    |> frame
                    |> Html.map HomeMsg

            MemorySetup subModel ->
                MemorySetup.view subModel
                    |> frame
                    |> Html.map MemorySetupMsg

            Memory subModel ->
                Memory.view subModel
                    |> frame
                    |> Html.map MemoryMsg



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
    | HomeLoaded (Result PageLoadError Home.Model)
    | MemorySetupLoaded (Result PageLoadError MemorySetup.Model)
    | MemoryGameLoaded Memory.Model
    | HomeMsg Home.Msg
    | MemorySetupMsg MemorySetup.Msg
    | MemoryMsg Memory.Msg


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

            Just Route.Home ->
                isError Home Home.init

            Just Route.Root ->
                model => Route.modifyUrl Route.Home

            Just Route.MemorySetup ->
                isError MemorySetup MemorySetup.init

            Just (Route.MemoryGame slug) ->
                generate MemoryGameLoaded (Memory.init slug)


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

            ( HomeLoaded (Ok subModel), _ ) ->
                { model | pageState = Loaded (Home subModel) } => Cmd.none

            ( HomeLoaded (Err error), _ ) ->
                { model | pageState = Loaded (Errored error) } => Cmd.none

            ( MemorySetupLoaded (Ok subModel), _ ) ->
                { model | pageState = Loaded (MemorySetup subModel) } => Cmd.none

            ( MemorySetupLoaded (Err error), _ ) ->
                { model | pageState = Loaded (Errored error) } => Cmd.none

            ( MemoryGameLoaded subModel, _ ) ->
                { model | pageState = Loaded (Memory subModel) } => Cmd.none

            ( HomeMsg subMsg, Home subModel ) ->
                toPage Home HomeMsg Home.update subMsg subModel

            ( MemoryMsg subMsg, Memory subModel ) ->
                toPage Memory MemoryMsg Memory.update subMsg subModel

            ( MemorySetupMsg subMsg, MemorySetup subModel ) ->
                toPage MemorySetup MemorySetupMsg MemorySetup.update subMsg subModel

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

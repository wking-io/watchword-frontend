module Main exposing (main)

import Data.UserSession as UserSession exposing (UserSession)
import Json.Encode exposing (Value)
import Html exposing (Html, program, text, div, ul, li, img, p)


-- import Page.Admin as Admin
-- import Page.Memory.Game as MemoryGame

import Page.Test as Test
import Page.NotFound as NotFound
import Page.Errored as Errored exposing (PageLoadError)
import Navigation exposing (Location)
import Route exposing (Route)
import Util.Infix exposing ((=>))
import Random exposing (Generator)
import View.Page as Page
import Task


type Page
    = Blank
    | NotFound
    | Errored PageLoadError
      -- | Admin Admin.Model
      -- | AdminSelected Admin.Model
      -- | AdminSetup Admin.Model
      -- | MemoryGame MemoryGame.Model
    | Test Test.Model


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
    { session : UserSession
    , pageState : PageState
    }


init : Value -> Location -> ( Model, Cmd Msg )
init val location =
    setRoute (Route.fromLocation location)
        { pageState = Loaded initialPage
        , session = UserSession.decoder val
        }


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

            -- Admin subModel ->
            --     Admin.view subModel
            --         |> frame
            --         |> Html.map AdminMsg
            -- AdminSelected subModel ->
            --     Admin.view subModel
            --         |> frame
            --         |> Html.map AdminMsg
            -- AdminSetup subModel ->
            --     Admin.view subModel
            --         |> frame
            --         |> Html.map AdminMsg
            -- MemoryGame subModel ->
            --     MemoryGame.view subModel
            --         |> frame
            --         |> Html.map MemoryGameMsg
            Test subModel ->
                Test.view subModel
                    |> frame
                    |> Html.map TestMsg



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
      -- | AdminLoaded (Result PageLoadError Admin.Model)
    | TestLoaded (Result PageLoadError Test.Model)
      -- | MemoryGameLoaded MemoryGame.Model
      -- | AdminMsg Admin.Msg
      -- | MemoryGameMsg MemoryGame.Msg
    | TestMsg Test.Msg


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

        transition toMsg task =
            { model | pageState = TransitioningFrom (getPage model.pageState) }
                => Task.attempt toMsg task
    in
        case maybeRoute of
            Nothing ->
                { model | pageState = Loaded NotFound } => Cmd.none

            Just Route.Root ->
                transition TestLoaded (Test.init model.session)

            -- Just (Route.Admin slug) ->
            --     isError Admin (Admin.init slug False)
            -- Just (Route.AdminSetup slug) ->
            --     isError Admin (Admin.init slug True)
            -- Just (Route.MemoryGame slug) ->
            --     generate MemoryGameLoaded (MemoryGame.init slug)
            Just Route.Test ->
                transition TestLoaded (Test.init model.session)


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

            -- ( AdminLoaded (Ok subModel), _ ) ->
            --     { model | pageState = Loaded (Admin subModel) } => Cmd.none
            -- ( AdminLoaded (Err error), _ ) ->
            --     { model | pageState = Loaded (Errored error) } => Cmd.none
            ( TestLoaded (Ok subModel), _ ) ->
                { model | pageState = Loaded (Test subModel) } => Cmd.none

            ( TestLoaded (Err error), _ ) ->
                { model | pageState = Loaded (Errored error) } => Cmd.none

            -- ( MemoryGameLoaded subModel, _ ) ->
            --     { model | pageState = Loaded (MemoryGame subModel) } => Cmd.none
            -- ( AdminMsg subMsg, Admin subModel ) ->
            --     toPage Admin AdminMsg Admin.update subMsg subModel
            -- ( MemoryGameMsg subMsg, MemoryGame subModel ) ->
            --     toPage MemoryGame MemoryGameMsg MemoryGame.update subMsg subModel
            ( _, NotFound ) ->
                -- Disregard incoming messages when we're on the
                -- NotFound page.
                model => Cmd.none

            ( _, _ ) ->
                -- Disregard incoming messages that arrived for the wrong page
                model => Cmd.none



-- SUBSCRIPTIONS
-- MAIN


main : Program Value Model Msg
main =
    Navigation.programWithFlags (Route.fromLocation >> SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = \model -> Sub.none
        }

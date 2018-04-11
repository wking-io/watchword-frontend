module Main exposing (main)

import Html exposing (Html, program, text, button, div)
import Html.Attributes as Html exposing (class)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Json.Decode as Decode
import SelectList exposing (SelectList)
import Svg exposing (svg, polyline)
import Svg.Attributes as Svg exposing (class, fill, stroke, strokeLinejoin, strokeWidth, points)
import Mouse exposing (Position)


-- MODEL --


type alias Model =
    { isDrawing : Bool
    , content : HistoryList
    }


type alias HistoryList =
    { done : List (List Position)
    , undone : List (List Position)
    }


init : ( Model, Cmd Msg )
init =
    ( Model False (HistoryList [] []), Cmd.none )



-- VIEW --


view : Model -> Html Msg
view model =
    let
        handlers =
            if model.isDrawing then
                [ getPositionOn "mouseup" DrawEnd, getPositionOn "mousemove" DrawAt, getPositionOn "touchend" DrawEnd, getPositionOn "touchmove" DrawAt ]
            else
                [ getPositionOn "mousedown" DrawStart, getPositionOn "touchstart" DrawStart ]
    in
        Html.main_ []
            [ svg (List.append [ Svg.class "artboard" ] handlers) (renderLines model.content)
            , div [ Html.class "controls" ]
                [ button [ Html.class "eraser", onClick ClearArtboard ] [ text "Clear Artboard" ]
                , button [ Html.class "undo", onClick Undo ] [ text "← Undo" ]
                , button [ Html.class "redo", onClick Redo ] [ text "Redo →" ]
                ]
            ]


renderLines : HistoryList -> List (Html Msg)
renderLines history =
    if (List.length history.done) == 0 then
        [ text "" ]
    else
        history.done
            |> List.reverse
            |> List.map toPoints
            |> List.map toLine


toLine : String -> Html Msg
toLine thePoints =
    polyline [ fill "none", stroke "#000000", strokeWidth "6", strokeLinejoin "round", points thePoints ] []


toPoints : List Position -> String
toPoints coords =
    coords
        |> List.map toPoint
        |> List.intersperse " "
        |> List.foldl (++) ""


toPoint : Position -> String
toPoint { x, y } =
    toString x ++ "," ++ toString y


px : Int -> String
px number =
    toString number ++ "px"


getPositionOn : String -> (Position -> Msg) -> Html.Attribute Msg
getPositionOn event msg =
    on event (Decode.map msg Mouse.position)



-- UPDATE --


type Msg
    = DrawStart Position
    | DrawAt Position
    | DrawEnd Position
    | ClearArtboard
    | Undo
    | Redo


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( updateHelp msg model, Cmd.none )


updateHelp : Msg -> Model -> Model
updateHelp msg model =
    case msg of
        DrawStart position ->
            { model | isDrawing = True, content = startLine model.content position }

        DrawAt position ->
            if model.isDrawing then
                { model | content = drawLine model.content position }
            else
                model

        DrawEnd position ->
            { model | isDrawing = False, content = drawLine model.content position }

        ClearArtboard ->
            { model | content = HistoryList [] [] }

        Undo ->
            { model | content = undo model.content }

        Redo ->
            { model | content = redo model.content }


startLine : HistoryList -> Position -> HistoryList
startLine history position =
    if (List.length history.done) == 0 then
        { history | done = (List.singleton (List.singleton position)) }
    else
        { history | done = ((List.singleton position) :: history.done) }


drawLine : HistoryList -> Position -> HistoryList
drawLine history position =
    case (List.head history.done) of
        Nothing ->
            HistoryList (List.singleton (List.singleton position)) []

        Just line ->
            let
                rest =
                    Maybe.withDefault [] (List.tail history.done)
            in
                { history | done = ((addPosition position line) :: rest) }


addPosition : Position -> List Position -> List Position
addPosition position line =
    List.append line (List.singleton position)


undo : HistoryList -> HistoryList
undo history =
    case (List.head history.done) of
        Nothing ->
            history

        Just line ->
            let
                rest =
                    Maybe.withDefault [] (List.tail history.done)
            in
                { history | done = rest, undone = (line :: history.undone) }


redo : HistoryList -> HistoryList
redo history =
    case (List.head history.undone) of
        Nothing ->
            history

        Just line ->
            let
                rest =
                    Maybe.withDefault [] (List.tail history.undone)
            in
                { history | done = (line :: history.done), undone = rest }



-- HELPERS


getActiveLines : SelectList (List Position) -> List (List Position)
getActiveLines lines =
    (SelectList.selected lines) :: (SelectList.before lines)



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

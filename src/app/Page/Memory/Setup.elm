module Page.Memory.Setup exposing (Model, Msg, init, update, view)

import Data.Word as Word exposing (Word)
import Data.Group as Group exposing (Group)
import Data.Memory as Memory
import Data.Memory.Option as Option exposing (Option)
import Data.Memory.Size as Size exposing (Size)
import Dict exposing (Dict)
import Html exposing (Html, program, text, h2, div, ul, li, p, button, a)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Page.Errored exposing (PageLoadError, pageLoadError)
import Request.Words as Words
import Route


-- TYPES --


type Step
    = StepOne
    | StepTwo Option
    | StepThree Option Size
    | StepFourGroup Option Size (List Group)
    | StepFourWord Option Size (List Word)
    | StepFiveGroup Option Size (List Group) Memory.Slug
    | StepFiveWord Option Size (List Word) Memory.Slug


getOption : Step -> Maybe Option
getOption step =
    case step of
        StepOne ->
            Nothing

        StepTwo option ->
            Just option

        StepThree option _ ->
            Just option

        StepFourGroup option _ _ ->
            Just option

        StepFourWord option _ _ ->
            Just option

        StepFiveGroup option _ _ _ ->
            Just option

        StepFiveWord option _ _ _ ->
            Just option


getSize : Step -> Maybe Size
getSize step =
    case step of
        StepOne ->
            Nothing

        StepTwo _ ->
            Nothing

        StepThree _ size ->
            Just size

        StepFourGroup _ size _ ->
            Just size

        StepFourWord _ size _ ->
            Just size

        StepFiveGroup _ size _ _ ->
            Just size

        StepFiveWord _ size _ _ ->
            Just size


getGroupSelection : Step -> Maybe (List Group)
getGroupSelection step =
    case step of
        StepOne ->
            Nothing

        StepTwo option ->
            Nothing

        StepThree option _ ->
            Just []

        StepFourGroup _ _ selection ->
            Just selection

        StepFourWord _ _ _ ->
            Nothing

        StepFiveGroup _ _ selection _ ->
            Just selection

        StepFiveWord _ _ _ _ ->
            Nothing


getWordSelection : Step -> Maybe (List Word)
getWordSelection step =
    case step of
        StepOne ->
            Nothing

        StepTwo option ->
            Nothing

        StepThree option _ ->
            Just []

        StepFourGroup _ _ _ ->
            Nothing

        StepFourWord _ _ selection ->
            Just selection

        StepFiveGroup _ _ _ _ ->
            Nothing

        StepFiveWord _ _ selection _ ->
            Just selection



-- MODEL --


type alias Model =
    { options : Dict String (List Word)
    , step : Step
    , showUrl : Bool
    }


init : Result PageLoadError Model
init =
    let
        handleLoadError _ =
            pageLoadError "Match & Memory Setup is currently unavailable."
    in
        Result.map3 Model Words.getBase (Ok StepOne) (Ok False)
            |> Result.mapError handleLoadError



-- VIEW --


view : Model -> Html Msg
view model =
    case model.step of
        StepOne ->
            viewOptions

        StepTwo _ ->
            viewSizes

        StepThree option size ->
            let
                slug =
                    Memory.Slug option size Nothing
            in
                case option of
                    Option.Random ->
                        div []
                            [ viewGroups (Group.fromDict model.options)
                            , viewActions False slug
                            ]

                    Option.Pick ->
                        div []
                            [ viewWords (Dict.toList model.options)
                            , viewActions False slug
                            ]

        StepFourGroup option size selection ->
            let
                canPlay =
                    (Size.equals (List.length selection) size)

                slug =
                    Memory.Slug option size (Just (List.map Group.toString selection))
            in
                div []
                    [ viewGroups (Group.fromDict model.options)
                    , viewActions canPlay slug
                    ]

        StepFourWord option size selection ->
            let
                canPlay =
                    (Size.equals (List.length selection) size)

                slug =
                    Memory.Slug option size (Just (List.map Word.toString selection))
            in
                div []
                    [ viewGroups (Group.fromDict model.options)
                    , viewActions canPlay slug
                    ]

        StepFiveGroup option size selection slug ->
            let
                canPlay =
                    (Size.equals (List.length selection) size)
            in
                div []
                    [ viewGroups (Group.fromDict model.options)
                    , viewActions canPlay slug
                    ]

        StepFiveWord option size selection slug ->
            let
                canPlay =
                    (Size.equals (List.length selection) size)
            in
                div []
                    [ viewGroups (Group.fromDict model.options)
                    , viewActions canPlay slug
                    ]


viewOptions : Html Msg
viewOptions =
    div []
        [ button [ onClick (SelectOption Option.Random) ] [ text "Pick Random" ]
        , button [ onClick (SelectOption Option.Pick) ] [ text "Pick Your Own" ]
        ]


viewSizes : Html Msg
viewSizes =
    div []
        [ button [ onClick (SelectSize Size.Small) ] [ text "3" ]
        , button [ onClick (SelectSize Size.Medium) ] [ text "4" ]
        , button [ onClick (SelectSize Size.Large) ] [ text "5" ]
        , button [ onClick (SelectSize Size.ExtraLarge) ] [ text "6" ]
        ]


viewGroups : List Group -> Html Msg
viewGroups groups =
    ul [] (List.map viewGroup groups)


viewGroup : Group -> Html Msg
viewGroup group =
    li [ onClick (SelectGroup group) ] [ text (Group.toString group) ]


viewWords : List ( String, List Word ) -> Html Msg
viewWords sections =
    div [] (List.map viewSections sections)


viewSections : ( String, List Word ) -> Html Msg
viewSections ( group, words ) =
    div []
        [ h2 [] [ text group ]
        , ul [] (List.map viewWord words)
        ]


viewWord : Word -> Html Msg
viewWord word =
    li [] [ button [] [ text (Word.toString word) ] ]


viewActions : Bool -> Memory.Slug -> Html Msg
viewActions canPlay slug =
    div []
        [ button [] [ text "Clear Selection" ]
        , button [ disabled canPlay ] [ text "Share Game" ]
        , viewPlay canPlay slug
        ]


viewPlay : Bool -> Memory.Slug -> Html Msg
viewPlay canPlay slug =
    if canPlay then
        a [ Route.href (Route.MemoryGame slug) ] [ text "Play Game" ]
    else
        button [ disabled False ] [ text "Play Game" ]



-- UPDATE --


type Msg
    = SelectOption Option
    | SelectSize Size
    | UnselectWord Word
    | SelectWord Word
    | SelectGroup Group
    | UnselectGroup Group
    | ClearSelection
    | ShowUrl
    | HideUrl


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectOption option ->
            ( { model | step = StepTwo option }, Cmd.none )

        SelectSize size ->
            let
                current =
                    Maybe.map2 (,) (getOption model.step) (getSize model.step)
            in
                case current of
                    Just ( option, size ) ->
                        ( { model | step = StepThree option size }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        SelectGroup selection ->
            let
                current =
                    Maybe.map3 (,,) (getOption model.step) (getSize model.step) (getGroupSelection model.step)
            in
                case current of
                    Just ( option, size, current ) ->
                        ( { model | step = StepFourGroup option size (selection :: current) }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        UnselectGroup selection ->
            let
                current =
                    Maybe.map2 (,) (getOption model.step) (getSize model.step)

                newSelection =
                    case getGroupSelection model.step of
                        Just oldSelection ->
                            List.filter ((/=) selection) oldSelection

                        Nothing ->
                            []

                noSelection =
                    List.isEmpty newSelection
            in
                case current of
                    Just ( option, size ) ->
                        if noSelection then
                            ( { model | step = StepThree option size }, Cmd.none )
                        else
                            ( { model | step = StepFourGroup option size [ selection ] }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        SelectWord selection ->
            let
                current =
                    Maybe.map3 (,,) (getOption model.step) (getSize model.step) (getWordSelection model.step)
            in
                case current of
                    Just ( option, size, current ) ->
                        ( { model | step = StepFourWord option size (selection :: current) }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        UnselectWord selection ->
            let
                current =
                    Maybe.map2 (,) (getOption model.step) (getSize model.step)

                newSelection =
                    case getWordSelection model.step of
                        Just oldSelection ->
                            List.filter ((/=) selection) oldSelection

                        Nothing ->
                            []

                noSelection =
                    List.isEmpty newSelection
            in
                case current of
                    Just ( option, size ) ->
                        if noSelection then
                            ( { model | step = StepThree option size }, Cmd.none )
                        else
                            ( { model | step = StepFourWord option size newSelection }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        ClearSelection ->
            let
                current =
                    Maybe.map2 (,) (getOption model.step) (getSize model.step)
            in
                case current of
                    Just ( option, size ) ->
                        ( { model | step = StepThree option size }, Cmd.none )

                    Nothing ->
                        ( model, Cmd.none )

        ShowUrl ->
            ( { model | showUrl = True }, Cmd.none )

        HideUrl ->
            ( { model | showUrl = False }, Cmd.none )

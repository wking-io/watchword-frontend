module Page.MemorySetup exposing (Model, Msg, init, update, view)

import Data.Word as Word exposing (Word)
import Data.Group as Group exposing (Group)
import Data.Memory as Memory
import Data.Memory.Option as Option exposing (Option)
import Data.Memory.Size as Size exposing (Size)
import Dict exposing (Dict)
import Html exposing (Html, program, text, h2, div, ul, li, p, button, a)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Route


-- TYPES --


type Step
    = StepOne
    | StepTwo Option
    | StepThree Option Size
    | StepFourGroup Option Size (Maybe (List Group))
    | StepFourWord Option Size (Maybe (List Word))



-- MODEL --


type alias Model =
    { options : Dict String (List Word)
    , step : Step
    }


init : Model
init =
    StepOne



-- VIEW --


view : Model -> Html Msg
view model =
    case model.setup of
        StepOne ->
            viewOptions

        StepTwo _ ->
            viewSizes

        StepThree option size ->
            case option of
                Random ->
                    (viewGroups (Group.fromDict model.options)) ++ (viewActions True)

                Pick ->
                    (viewGroups model.options) ++ (viewActions True)

        StepFourGroup option size maybeSelection ->
            case option of
                RandomOption ->
                    (viewGroups (Group.fromDict model.options) model.step) ++ (viewActions False)

                PickOption ->
                    (viewGroups model.options) ++ (viewActions False)


viewOptions : Html Msg
viewOptions =
    div []
        [ button [ onClick (SelectOption RandomOption) ] [ text "Pick Random" ]
        , button [ onClick (SelectOption PickOption) ] [ text "Pick Your Own" ]
        ]


viewSizes : Html Msg
viewSizes option =
    div []
        [ button [ onClick (SelectSize Small) ] [ text "3" ]
        , button [ onClick (SelectOption Medium) ] [ text "4" ]
        , button [ onClick (SelectOption Large) ] [ text "5" ]
        , button [ onClick (SelectOption ExtraLarge) ] [ text "6" ]
        ]


viewGroups : List Group -> Html Msg
viewGroups groups =
    ul [] List.map viewGroup groups


viewGroup : Group -> Html Msg
viewGroup group =
    li [ onClick ] [ text (Group.toString group) ]


viewWords : List ( String, List Word ) -> Html Msg
viewWords sections =
    div [] (List.map viewSections sections)


viewSections : ( String, List Word ) -> Html Msg
viewSections ( group, words ) =
    div []
        [ h2 [] [ text (Group.toString group) ]
        , ul [] (List.map viewWord words)
        ]


viewWord : String -> Html Msg
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
    | SelectSize Option Size
    | Select Option Size String
    | ClearSelection
    | GetUrl


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectOption option ->
            ( { model | setup = StepTwo option }, Cmd.none )

        SelectSize option size ->
            ( { model | setup = StepThree option size }, Cmd.none )

        Select option size selection ->
            case Option of
                Random ->
                    ( { model | setup = StepFourGroup option size (Group.fromString selection) }, Cmd.none )

                Pick ->
                    ( { model | setup = StepFourGroup option size (Word.fromString selection) }, Cmd.none )

        SelectOption option ->
            ( { model | setup = StepTwo option }, Cmd.none )

        SelectOption option ->
            ( { model | setup = StepTwo option }, Cmd.none )

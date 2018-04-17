module Page.MemorySetup exposing (Model, Msg, init, update, view)

import Data.Word as Word exposing (Word)
import Data.Group as Group exposing (Group)
import Data.Memory as Memory
import Dict exposing (Dict)
import Html exposing (Html, program, text, h2, div, ul, li, p, button, a)
import Html.Attributes exposing (class, classList, disabled)
import Html.Events exposing (on, onMouseDown, onMouseUp, onClick)
import Route


-- TYPES --


type SetupProgress
    = StepOne
    | StepTwo Option
    | StepThree Option Size
    | StepFour Option Size (Maybe (List Group))


type Size
    = Small
    | Medium
    | Large
    | ExtraLarge


type Option
    = RandomOption
    | PickOption



-- MODEL --


type alias Model =
    { options : Dict String (List Word)
    , setup : SetupProgress
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

        StepThree option _ ->
            case option of
                RandomOption ->
                    (viewGroups (Group.fromDict model.options)) ++ (viewActions True)

                PickOption ->
                    (viewGroups model.options) ++ (viewActions True)

        StepFour option _ _ ->
            case option of
                RandomOption ->
                    (viewGroups (Group.fromDict model.options)) ++ (viewActions False)

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
    li [] [ text (Group.toString group) ]


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
    | SelectSize Size
    | Select String
    | ClearSelection
    | GetUrl

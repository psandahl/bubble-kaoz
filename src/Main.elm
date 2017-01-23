module Main exposing (main)

import Html exposing (Html, div, text)


type alias Model =
    Int


type Msg
    = NoOp


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }


init : ( Model, Cmd Msg )
init =
    ( 1, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text "Hello" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

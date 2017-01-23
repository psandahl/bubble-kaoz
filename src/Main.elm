module Main exposing (main)

import Emitter exposing (Emitter)
import Html exposing (Html)
import Html.Attributes as Attr
import Math.Matrix4 exposing (Mat4, makePerspective, makeLookAt)
import Math.Vector3 exposing (Vec3, vec3)
import WebGL as GL


type alias Model =
    { eyePosition :
        Vec3
        -- Position of the eye, needed for the scaling of point sprites.
    , proj :
        Mat4
        -- The projection matrix.
    , view :
        Mat4
        -- The camera matrix.
    , emitter :
        Emitter
        -- The bubble emitter.
    }


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
    let
        eye =
            vec3 0 0 50
    in
        ( { eyePosition = eye
          , proj =
                makePerspective 45 (toFloat width / toFloat height) 0.01 100
          , view = makeLookAt eye (vec3 0 0 0) (vec3 0 1 0)
          , emitter = Emitter.init
          }
        , Cmd.none
        )


view : Model -> Html Msg
view model =
    GL.toHtmlWith
        [ GL.depth 1
        , GL.antialias
        , GL.alpha True
        , GL.clearColor 0 0 (102 / 255) 1
        ]
        [ Attr.width width
        , Attr.height height
        ]
        [ Emitter.render model.proj model.view model.eyePosition model.emitter
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


width : Int
width =
    800


height : Int
height =
    600

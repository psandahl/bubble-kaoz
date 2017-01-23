module Emitter exposing (Emitter, init, render)

import Math.Matrix4 exposing (Mat4, makeTranslate)
import Math.Vector3 exposing (Vec3, vec3)
import Shaders exposing (vertexShader, fragmentShader)
import WebGL as GL


type alias Emitter =
    { position :
        Vec3
        -- Model space coordinates for the Emitter.
    , model :
        Mat4
        -- Model matrix for the emitter.
    , point : GL.Mesh { position : Vec3 }
    }


init : Emitter
init =
    let
        position =
            vec3 0 0 0
    in
        { position = position
        , model = makeTranslate position
        , point = GL.points [ { position = vec3 0 0 0 } ]
        }


render : Mat4 -> Mat4 -> Emitter -> GL.Entity
render proj view emitter =
    GL.entity vertexShader
        fragmentShader
        emitter.point
        { proj = proj
        , view = view
        , model = emitter.model
        }

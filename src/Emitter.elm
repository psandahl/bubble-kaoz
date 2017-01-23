module Emitter exposing (Emitter, init, render)

import Math.Matrix4 exposing (Mat4)
import Math.Vector3 exposing (vec3)
import Point exposing (Point, init, render)
import WebGL as GL


type alias Emitter =
    { point1 : Point
    , point2 : Point
    }


init : Emitter
init =
    { point1 = Point.init <| vec3 0 0 0
    , point2 = Point.init <| vec3 1 0 -3
    }


render : Mat4 -> Mat4 -> Emitter -> List GL.Entity
render proj view emitter =
    [ Point.render proj view emitter.point1
    , Point.render proj view emitter.point2
    ]

module BubbleMaker exposing (BubbleMaker, init, render)

import Math.Matrix4 exposing (Mat4)
import Math.Vector3 exposing (vec3)
import Point exposing (Point, init, render)
import WebGL as GL


type alias BubbleMaker =
    { point1 : Point
    , point2 : Point
    }


init : BubbleMaker
init =
    { point1 = Point.init <| vec3 0 0 0
    , point2 = Point.init <| vec3 0.3 0 5
    }


render : Mat4 -> Mat4 -> BubbleMaker -> List GL.Entity
render proj view bubbleMaker =
    [ Point.render proj view bubbleMaker.point1
    , Point.render proj view bubbleMaker.point2
    ]

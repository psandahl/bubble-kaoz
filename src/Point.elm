module Point exposing (Point, init, render)

import Math.Matrix4 exposing (Mat4, makeTranslate)
import Math.Vector3 exposing (Vec3, vec3)
import Shaders exposing (vertexShader, fragmentShader)
import WebGL as GL
import WebGL.Settings.Blend as GLBlend
import WebGL.Settings.DepthTest as GLDepth


type alias Point =
    { position :
        Vec3
        -- The position of the point.
    , model :
        Mat4
        -- The model matrix for the point.
    , point :
        GL.Mesh { position : Vec3 }
        -- Geometric data for the point.
    }


init : Vec3 -> Point
init position =
    { position = position
    , model = makeTranslate position
    , point = GL.points [ { position = vec3 0 0 0 } ]
    }


render : Mat4 -> Mat4 -> Point -> GL.Entity
render proj view point =
    GL.entityWith
        [ GLBlend.add GLBlend.srcAlpha GLBlend.dstAlpha
        , GLDepth.always { write = True, near = 0, far = 1 }
        ]
        vertexShader
        fragmentShader
        point.point
        { proj = proj
        , view = view
        , model = point.model
        }

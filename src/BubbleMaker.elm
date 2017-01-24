module BubbleMaker exposing (BubbleMaker, init, render)

import Math.Matrix4 exposing (Mat4, makeTranslate)
import Math.Vector3 exposing (Vec3, vec3)
import Shaders exposing (vertexShader, fragmentShader)
import WebGL as GL
import WebGL.Settings.Blend as GLBlend
import WebGL.Settings.DepthTest as GLDepth


type alias BubbleMaker =
    { geoPoint :
        GL.Mesh Point
        -- Geometric data for the point.
    , bubbles :
        List Bubble
        -- List of Bubbles.
    }


type alias Point =
    { position : Vec3
    }


type alias Bubble =
    { position : Vec3
    , model : Mat4
    }


init : BubbleMaker
init =
    { geoPoint = GL.points [ { position = vec3 0 0 0 } ]
    , bubbles = [ newBubble <| vec3 0 0 0 ]
    }


render : Mat4 -> Mat4 -> BubbleMaker -> List GL.Entity
render proj view bubbleMaker =
    List.map (renderBubble proj view bubbleMaker.geoPoint) bubbleMaker.bubbles


newBubble : Vec3 -> Bubble
newBubble position =
    { position = position
    , model = makeTranslate position
    }


renderBubble : Mat4 -> Mat4 -> GL.Mesh Point -> Bubble -> GL.Entity
renderBubble proj view point bubble =
    GL.entityWith
        [ GLBlend.add GLBlend.srcAlpha GLBlend.dstAlpha
        , GLDepth.always { write = True, near = 0, far = 1 }
        ]
        vertexShader
        fragmentShader
        point
        { proj = proj
        , view = view
        , model = bubble.model
        }

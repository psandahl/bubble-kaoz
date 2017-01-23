module Shaders exposing (vertexShader, fragmentShader)

import Math.Matrix4 exposing (Mat4)
import Math.Vector3 exposing (Vec3)
import WebGL exposing (Shader)


vertexShader :
    Shader { position : Vec3 }
        { proj : Mat4
        , view : Mat4
        , model : Mat4
        , eyePosition : Vec3
        }
        {}
vertexShader =
    [glsl|
// Point position in local coordinates (i.e. 0 0 0).
attribute vec3 position;

// Projection matrix.
uniform mat4 proj;

// View matrix.
uniform mat4 view;

// Model matrix
uniform mat4 model;

// Eye position, already in model space (may be removed if
// calculation is done in view space).
uniform vec3 eyePosition;

const float MaxPointSize = 100.0;

void main(void)
{
  // Transform the point's position to model space.
  vec4 positionT = model * vec4(position, 1.0);

  // Calculate the proportional size of the point, given the distance from
  // the eye.
  float propSize =
    1.0 - distance(positionT.xyz, eyePosition) / 100.0;

  gl_PointSize = max(propSize * MaxPointSize, 0.0);
  gl_Position = proj * view * positionT;
}
|]


fragmentShader : Shader {} unif {}
fragmentShader =
    [glsl|
precision mediump float;

void main(void)
{
  gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}
|]

module Shaders exposing (vertexShader, fragmentShader)

import Math.Matrix4 exposing (Mat4)
import Math.Vector3 exposing (Vec3)
import WebGL exposing (Shader)


vertexShader :
    Shader { position : Vec3 }
        { proj : Mat4
        , view : Mat4
        , model : Mat4
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

// The maximum point size.
const float MaxPointSize = 100.0;

// The distance until the point no longer can be seen.
const float Vista = 100.0;

void main(void)
{
  // Transform the point's position to view space.
  vec4 positionT = view * model * vec4(position, 1.0);

  // Calculate the proportional size of the point, given the distance from
  // the eye (which is at origin).
  float propSize = 1.0 - distance(vec3(0.0), positionT.xyz) / Vista;

  gl_PointSize = max(propSize * MaxPointSize, 0.0);
  gl_Position = proj * positionT;
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

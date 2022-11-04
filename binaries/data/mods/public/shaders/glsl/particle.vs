#version 110

#include "common/los_vertex.h"
#include "common/vertex.h"

uniform mat4 transform;
uniform mat4 modelViewMatrix;

varying vec2 v_tex;
varying vec4 v_color;

attribute vec3 a_vertex;
attribute vec4 a_color;
attribute vec2 a_uv0;
attribute vec2 a_uv1;

void main()
{
  vec3 axis1 = vec3(modelViewMatrix[0][0], modelViewMatrix[1][0], modelViewMatrix[2][0]);
  vec3 axis2 = vec3(modelViewMatrix[0][1], modelViewMatrix[1][1], modelViewMatrix[2][1]);
  vec2 offset = a_uv1;

  vec3 position = axis1*offset.x + axis1*offset.y + axis2*offset.x + axis2*-offset.y + a_vertex;

  OUTPUT_VERTEX_POSITION(transform * vec4(position, 1.0));

  calculateLOSCoordinates(position.xz);

  v_tex = a_uv0;
  v_color = a_color;
}

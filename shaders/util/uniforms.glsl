#ifndef UNIFORMS_GLSL
#define UNIFORMS_GLSL 1

// So I don't have to manually include for each file
#include "settings.glsl"

uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferModelView;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferProjection;

uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform mat4 shadowModelViewInverse;

uniform vec3 cameraPosition;

// Shadow samplers
#ifdef HARDWARE_SHADOW_FILTERING
uniform sampler2DShadow shadowtex0;
uniform sampler2DShadow shadowtex1;
#else
uniform sampler2D shadowtex0;
uniform sampler2D shadowtex1;
#endif
uniform sampler2D shadowcolor0;
uniform sampler2D shadowcolor1;

// Color samplers
uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D colortex2;
uniform sampler2D colortex3;
uniform sampler2D colortex4;
uniform sampler2D colortex5;
uniform sampler2D colortex6;
uniform sampler2D colortex7;

// Depth samplers
uniform sampler2D depthtex0;
uniform sampler2D depthtex1;
uniform sampler2D depthtex2;
uniform sampler2D depthtex3;

// Misc samplers
uniform sampler2D texture;
uniform sampler2D noisetex;

uniform float frameTimeCounter;
uniform int worldTime;
uniform float viewWidth;
uniform float viewHeight;
uniform float rainStrength;
uniform float far;
uniform float near;

#endif
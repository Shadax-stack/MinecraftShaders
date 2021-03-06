#version 120

#define VERTEX

#include "lib/Utility/Attributes.glsl"
#include "lib/Utility/Packing.glsl"
#include "lib/Transform/Transform.glsl"
#include "lib/Misc/Masks.glsl"

varying vec3 Normal;
flat varying float fMasks;

void main(){
    gl_Position = TransformVertex();
    gl_TexCoord[0].st = gl_MultiTexCoord0.st;
    gl_TexCoord[1].st = mat2(gl_TextureMatrix[1]) * gl_MultiTexCoord1.st;
    gl_FrontColor = gl_Color;
    fMasks = CompressMaskStruct(ConstructMaskStruct(mc_Entity.x));
    Normal = mat3(gbufferModelViewInverse) * gl_NormalMatrix * gl_Normal;
}
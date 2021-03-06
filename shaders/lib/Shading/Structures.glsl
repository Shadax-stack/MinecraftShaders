#ifndef SHADING_STRUCTURES_GLSL
#define SHADING_STRUCTURES_GLSL 1

// Use the same names that SEUS V10.1 did
struct SurfaceStruct {
    vec4 Diffuse;

    vec3 ViewNormal;
    vec3 Normal;

    vec3 Screen;
    vec3 Clip;
    vec3 View;
    vec3 Player;
    vec3 World;
    vec3 ShadowClip;
    float Distortion;
    vec3 ShadowScreen;

    float Torch;
    float Sky;

    float NdotL;

    float Shininess;
    float SpecularStrength;
};

struct ShadingStruct {
    vec4 Color;

    vec3 Sun;
    vec3 Torch;
    vec3 Sky;
    vec3 Reflection;
    vec3 Volumetric;
    vec3 OpticalDepth;

    float AmbientOcclusion;
};

#endif
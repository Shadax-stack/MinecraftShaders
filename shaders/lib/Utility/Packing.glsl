#ifndef UTILITY_PACKING_GLSL
#define UTILITY_PACKING_GLSL

#include "../Misc/Masks.glsl"

int PackMask(bool mask, const int bit){
    return (mask ? bit : 0);
}

bool UnpackMask(int ival, const int bit){
    return bool(ival & bit);
}

bool UnpackMask(float fval, const int bit){
    return bool(int(fval * 65535.0f) & bit);
}

float CompressMaskStruct(in MaskStruct masks){
    int imasks = 0;
    imasks |= PackMask(masks.Sky,   SKY_BIT  );
    imasks |= PackMask(masks.Plant, PLANT_BIT);
    float fmasks = float(imasks) / 65535.0f;
    return fmasks;
}

MaskStruct DecompressMaskStruct(in float fmasks){
    int imasks = int(fmasks * 65535.0f);
    MaskStruct UnpackedMasks;
    UnpackedMasks.Sky   = UnpackMask(imasks, SKY_BIT);
    UnpackedMasks.Plant = UnpackMask(imasks, PLANT_BIT);
    return UnpackedMasks;
}

vec2 PackNormal(in vec3 unpackednormal){
    return unpackednormal.xy * 0.5f + 0.5f;
}

vec3 UnpackNormal(in vec2 packednormal){
    vec3 normal;
    normal.xy = packednormal * 2.0f - 1.0f;
    normal.z = sqrt(1.0f - dot(normal.xy, normal.xy));
    return normal;
}

#endif
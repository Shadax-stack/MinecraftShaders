#ifndef MULTIPASS_DEPTH_OF_FIELD_GLSL
#define MULTIPASS_DEPTH_OF_FIELD_GLSL 1

#include "../Utility/Uniforms.glsl"

#define DOF_KERNEL_SIZE 6.0f

// TODO: have only a single first pass
// Both passes use the same input

void main() {
    float CurrentDepth = texture2D(depthtex0, gl_TexCoord[0].st).r;
    float CoC0 = texture2D(colortex0, gl_TexCoord[0].st).a;
    float CoC1 = texture2D(colortex1, gl_TexCoord[0].st).a;

    vec4 Accum0 = vec4(0.0f);
    vec4 Accum1 = vec4(0.0f);

    int ValidSamples0 = 0;
    int ValidSamples1 = 0;

    const float RotationAngle0 = radians(45.0f);
    const float RotationAngle1 = -RotationAngle0;
    const mat2 Rotation0 = mat2(cos(RotationAngle0), -sin(RotationAngle0), sin(RotationAngle0), cos(RotationAngle0));
    const mat2 Rotation1 = mat2(cos(RotationAngle1), -sin(RotationAngle1), sin(RotationAngle1), cos(RotationAngle1));

    for(float sample = -DOF_KERNEL_SIZE; sample <= DOF_KERNEL_SIZE; sample++){

        #ifdef DOF_BOKEH_X
        vec2 Offset0 = vec2(sample, 0.0f);
        vec2 Offset1 = vec2(sample, 0.0f);
        #else
        vec2 Offset0 = Rotation0 * vec2(sample, 0.0f);
        Offset0.y *= aspectRatio;
        vec2 Offset1 = Rotation1 * vec2(sample, 0.0f);
        Offset1.y *= aspectRatio;
        #endif
        Offset0 *= CoC0;
        Offset1 *= CoC1;

        vec2 SampleCoord0 = gl_TexCoord[0].st + Offset0;
        float SampleDepth0 = texture2D(depthtex0, SampleCoord0).r;
        vec4 SampleColor0 = texture2D(colortex0, SampleCoord0);
        // Solution to intensity leakage proposed by L. McIntosh et al
        if(!(SampleDepth0 < CurrentDepth && SampleColor0.a > CoC0)){
            Accum0.rgb += SampleColor0.rgb;
            ValidSamples0++;
        }
        
        vec2 SampleCoord1 = gl_TexCoord[0].st + Offset1;
        float SampleDepth1 = texture2D(depthtex0, SampleCoord1).r;
        vec4 SampleColor1= texture2D(colortex1, SampleCoord1);
        // Solution to intensity leakage proposed by L. McIntosh et al
        if(!(SampleDepth1 < CurrentDepth && SampleColor1.a > CoC1)){
            Accum1.rgb += SampleColor1.rgb;
            ValidSamples1++;
        }

    }
    Accum0.rgb /= ValidSamples0;
    Accum1.rgb /= ValidSamples1;
    // Do not blur the CoC like in L. McIntosh et al
    // It caused really weird artefacts
    // Instead use the solution proposed by Hammon
    Accum0.a = CoC0;
    Accum1.a = CoC1;
    /* DRAWBUFFERS:01 */
    gl_FragData[0] = Accum0;
    gl_FragData[1] = Accum1;
}

#endif
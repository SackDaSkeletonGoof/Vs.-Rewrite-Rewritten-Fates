// CombinedShader.frag
#version 330 core

uniform float iTime;
uniform vec2 iResolution;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;

out vec4 fragColor;

const float FINAL_BLUR_BIAS = 1.0;
const float PRE_BLUR_BIAS = 1.0;
const float UNSHARP_AMOUNT = 2.0;
const float UNSHARP_THRESHOLD = 0.0;
const float BLACK_LEVEL = 0.1;
const float WHITE_LEVEL = 0.9;
const float SATURATION_LEVEL = 0.75;
const vec3 SHADOW_TINT = vec3(0.7, 0.0, 0.9);
const float NOISE_BLEND = 0.05;

// Utility Functions

float GetLuminance(vec3 color) {
    return dot(color, vec3(0.299, 0.587, 0.114));
}

vec3 SetLum(vec3 c, float l) {
    float d = l - GetLuminance(c);
    c += d;
    return clamp(c, 0.0, 1.0);
}

vec4 BlendColor(vec4 base, vec4 blend) {
    vec3 c = SetLum(blend.rgb, GetLuminance(base));
    return vec4(c, blend.a);
}

vec4 BlendLuminosity(vec4 base, vec4 blend) {
    vec3 c = SetLum(base.rgb, GetLuminance(blend));
    return vec4(c, blend.a);
}

// Shrink and Blend Pass

vec4 Shrink(in vec2 fragCoord, const in float shrinkRatio, const in float bias) {
    float scale = 1.0 / iResolution.x;
    float numBands = iResolution.x * shrinkRatio;
    float bandWidth = iResolution.x / numBands;

    float t = mod(fragCoord.x, bandWidth) / bandWidth;
    fragCoord.x = floor(fragCoord.x * shrinkRatio) / shrinkRatio;
    vec2 uv = fragCoord / iResolution.xy;
    vec4 colorA = texture(iChannel0, uv, bias);

    uv.x += bandWidth * scale;
    vec4 colorB = texture(iChannel0, uv, bias);

    return mix(colorA, colorB, t);
}

// Color Correction Pass

vec4 ColorCorrection(vec4 pixel) {
    pixel = BlendLuminosity(vec4(0.5, 0.5, 0.5, 1.0), pixel);
    return pixel;
}

// Unsharp Mask Pass

vec4 UnsharpMask(const in float amount, const in float radius, const in float threshold, const in float preBlurBias, const in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 scale = vec2(1.0) / iResolution.xy;

    vec4 pixel = texture(iChannel0, uv, preBlurBias);
    vec4 blurPixel = texture(iChannel0, uv, preBlurBias + 1.0);

    float lumDelta = abs(GetLuminance(pixel) - GetLuminance(blurPixel));

    if (lumDelta >= threshold)
        pixel = pixel + (pixel - blurPixel) * amount;

    return pixel;
}

// Clamp Levels Pass

vec4 ClampLevels(in vec4 pixel, const in float blackLevel, const in float whiteLevel) {
    pixel = mix(pixel, vec4(0.0), 1.0 - whiteLevel);
    pixel = mix(pixel, vec4(1.0), blackLevel);

    return pixel;
}

// Saturation Pass

vec4 Saturation(vec4 pixel, float adjustment) {
    vec3 intensity = vec3(dot(pixel.rgb, vec3(0.299, 0.587, 0.114)));
    return vec4(mix(intensity, pixel.rgb, adjustment), 1.0);
}

// Tint Shadows Pass

vec4 TintShadows(vec4 pixel, vec3 color) {
    const float POWER = 1.5;

    if (color.r > 0.0)
        pixel.r = mix(pixel.r, 1.0 - pow(abs(pixel.r - 1.0), POWER), color.r);
    if (color.g > 0.0)
        pixel.g = mix(pixel.g, 1.0 - pow(abs(pixel.g - 1.0), POWER), color.g);
    if (color.b > 0.0)
        pixel.b = mix(pixel.b, 1.0 - pow(abs(pixel.b - 1.0), POWER), color.b);

    return pixel;
}

// Interlace and Noise Grain Pass

vec4 InterlaceNoise(const in float lineThickness, const in float opacity, const in vec4 pixel, const in vec2 fragCoord) {
    float LINE_HEIGHT = 2.0;
    float NOISE_GRAIN_SIZE = 4.0;

    vec2 uv = fragCoord / iResolution.xy;
    bool updateOddLines = mod(float(iFrame), 2.0) == 0.0;
    bool isOddLine = mod(floor(fragCoord.y), 2.0 * LINE_HEIGHT) >= LINE_HEIGHT;

    if (isOddLine && updateOddLines || !isOddLine && !updateOddLines)
        return texture(iChannel1, uv);
    else
        return texture(iChannel0, uv);
}

// Warps and Noise Lines Pass

vec2 Tracking(const in float speed, const in float offset, const in float jitter, const in vec2 fragCoord) {
    float t = 1.0 - mod(iTime, speed) / speed;
    float trackingStart = mod(t * iResolution.y, iResolution.y);
    float trackingJitter = GoldNoise(vec2(5000.0, 5000.0), 10.0 + fract(iTime)) * jitter;

    trackingStart += trackingJitter;

    vec2 uv;
    if (fragCoord.y > trackingStart)
        uv = (fragCoord + vec2(offset, 0)) / iResolution.xy;
    else
        uv = fragCoord / iResolution.xy;

    return uv;
}

vec2 Wave(const in float frequency, const in float offset, const in vec2 fragCoord, const in vec2 uv) {
    float phaseNumber = floor(fragCoord.y / (iResolution.y / frequency));
    float offsetNoiseModifier = GoldNoise(vec2(1.0 + phaseNumber, phaseNumber), 10.0);

    float offsetUV = sin((uv.y + fract(iTime * 0.05)) * 6.283185 * frequency) * ((offset * offsetNoiseModifier) / iResolution.x);

    return uv + vec2(offsetUV, 0.0);
}

vec4 WarpBottom(const in float height, const in float offset, const in float jitterExtent, in vec2 uv) {
    float uvHeight = height / iResolution.y;
    if (uv.y > uvHeight)
        return texture(iChannel0, uv);

    float t = uv.y / uvHeight;

    float offsetUV = t * (offset / iResolution.x);
    float jitterUV = (GoldNoise(vec2(500.0, 500.0), fract(iTime)) * jitterExtent) / iResolution.x;

    uv = vec2(uv.x - offsetUV - jitterUV, uv.y);

    vec4 pixel = texture(iChannel0, uv);

    pixel = pixel * t;

    return pixel;
}

vec4 WhiteNoise(const in float lineThickness, const in float opacity, const in vec4 pixel, const in vec2 fragCoord) {
    if (GoldNoise(vec2(600.0, 500.0), fract(iTime) * 10.0) > 0.97) {
        float lineStart = floor(GoldNoise(vec2(800.0, 50.0), fract(iTime)) * iResolution.y);
        float lineEnd = floor(lineStart + lineThickness);

        if (floor(fragCoord.y) >= lineStart && floor(fragCoord.y) < lineEnd) {
            float frequency = GoldNoise(vec2(850.0, 50.0), fract(iTime)) * 3.0 + 1.0;
            float offset = GoldNoise(vec2(900.0, 51.0), fract(iTime));
            float x = floor(fragCoord.x) / floor(iResolution.x) + offset;
            float white = pow(cos(3.1415927 * fract(x * frequency) / 2.0), 10.0) * opacity;
            float grit = GoldNoise(vec2(floor(fragCoord.x /3.0), 800.0), fract(iTime));
            white = max(white - grit * 0.3, 0.0);

            return pixel + white;
        }
    }

    return pixel;
}

// Combined Main Function

void main() {
    vec2 fragCoord = gl_FragCoord.xy;

    // Pass 1: Televisionfy
    vec2 uv = fragCoord / iResolution.xy;
    vec4 pixel1 = texture(iChannel0, uv, FINAL_BLUR_BIAS);
    pixel1 = Televisionfy(pixel1, uv);

    // Pass 2: Shrink and Blend
    vec4 luma = Shrink(fragCoord, 0.5, 0.0);
    luma = BlendLuminosity(vec4(0.5, 0.5, 0.5, 1.0), luma);

    vec4 chroma = Shrink(fragCoord, 1.0 / 32.0, 3.0);
    chroma = BlendColor(luma, chroma);

    // Pass 3: Unsharp Mask and Color Correction
    vec4 pixel3 = UnsharpMask(UNSHARP_AMOUNT, DEFINE(20.0), UNSHARP_THRESHOLD, PRE_BLUR_BIAS, fragCoord);
    pixel3 = ClampLevels(pixel3, BLACK_LEVEL, WHITE_LEVEL);
    pixel3 = TintShadows(pixel3, SHADOW_TINT);
    pixel3 = Saturation(pixel3, SATURATION_LEVEL);

    // Pass 4: Interlace and Noise Grain
    vec4 pixel4 = InterlaceNoise(2.0, 0.3, pixel3, fragCoord);
    pixel4 = BlendSoftLight(pixel4, Noise(4.0, true, fragCoord, SOURCE_FPS), NOISE_BLEND);

    // Pass 5: Warps and Noise Lines
    float TRACKING_HORIZONTAL_OFFSET = 8.0;
    float TRACKING_JITTER = 20.0;
    float WAVE_OFFSET = 1.0;
    float BOTTOM_WARP_HEIGHT = 15.0;
    float BOTTOM_WARP_OFFSET = 100.0;
    float BOTTOM_WARP_JITTER_EXTENT = 50.0;
    float NOISE_HEIGHT = 6.0;

    vec2 uv5 = Tracking(8.0, TRACKING_HORIZONTAL_OFFSET, TRACKING_JITTER, fragCoord);
    uv5 = Wave(70.0, WAVE_OFFSET, fragCoord, uv5);
    vec4 pixel5 = WarpBottom(BOTTOM_WARP_HEIGHT, BOTTOM_WARP_OFFSET, BOTTOM_WARP_JITTER_EXTENT, uv5);
    pixel5 = WhiteNoise(NOISE_HEIGHT, 0.3, pixel5, fragCoord);

    // Combine all passes
    fragColor = pixel5;
}

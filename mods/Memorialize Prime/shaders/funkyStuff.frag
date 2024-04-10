#pragma header
precision mediump float;

uniform float u_time;
uniform vec2 u_resolution;
out vec4 fragColor;

mat2 r2d(float a) {
    float c = cos(a), s = sin(a);
    return mat2(c, s, -s, c);
}

float de(vec3 p) {
    p.y += cos(u_time * 2.0) * 0.2;
    p.xy *= r2d(u_time + p.z);

    vec3 r;
    float d = 0.0, s = 1.0;

    for (int i = 0; i < 3; i++) {
        r = max(r = abs(mod(p * s + 1.0, 2.0) - 1.0), r.yzx),
        d = max(d, (0.9 - min(r.x, min(r.y, r.z))) / s),
        s *= 3.0;
    }

    return d;
}

void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution.xy - 0.5;
    uv.x *= u_resolution.x / u_resolution.y;

    vec3 ro = vec3(0.1 * cos(u_time), 0.0, -u_time), p;
    vec3 rd = normalize(vec3(uv, -1.0));
    p = ro;

    float it = 0.0;
    for (float i = 0.0; i < 1.0; i += 0.01) {
        it = i;
        float d = de(p);
        if (d < 0.0001) break;
        p += rd * d * 0.4;
    }
    it /= 0.4 * sqrt(abs(tan(u_time) + p.x * p.x + p.y * p.y));

    vec3 c = mix(vec3(0.1, 0.1, 0.3), vec3(0.7, 0.1, 0.3), it * sin(p.z));

    fragColor = vec4(c, 1.0);
}

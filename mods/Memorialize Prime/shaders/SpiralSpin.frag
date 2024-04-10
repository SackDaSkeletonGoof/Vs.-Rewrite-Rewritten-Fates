#pragma header

        uniform float iTime;
        uniform vec3 iResolution;
        uniform float speed;
        
        void main() {
            float aspectRatio = 1.77777777778; // 16/9
            vec2 p = 2.0 * vec2(openfl_TextureCoordv.x * aspectRatio, openfl_TextureCoordv.y) - vec2(aspectRatio, 1.0);
            vec2 uv = 0.4 * p;
            float distSqr = dot(uv, uv);
            float vignette = 0.7 - distSqr;
            float angle = atan(p.y, p.x);
            float shear = sqrt(distSqr);
            float blur = 0.3;
            
            float stripes = smoothstep(-blur, blur, cos(8.0 * angle + speed * iTime - 12.0 * shear));
            const vec3 color1 = vec3(0.212,0.004,0.043);
            const vec3 color2 = vec3(0.145,0.,0.016);
            gl_FragColor = vec4(vignette * mix(color1, color2, stripes), 1.0);
        }
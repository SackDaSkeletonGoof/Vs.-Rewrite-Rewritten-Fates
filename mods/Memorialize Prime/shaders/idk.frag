// Automatically converted with https://github.com/TheLeerName/ShadertoyToFlixel

#pragma header

#define round(a) floor(a + 0.5)
#define iResolution vec3(openfl_TextureSize, 0.)
uniform float iTime;
#define iChannel0 bitmap
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
#define texture flixel_texture2D

// third argument fix
vec4 flixel_texture2D(sampler2D bitmap, vec2 coord, float bias) {
	vec4 color = texture2D(bitmap, coord, bias);
	if (!hasTransform)
	{
		return color;
	}
	if (color.a == 0.0)
	{
		return vec4(0.0, 0.0, 0.0, 0.0);
	}
	if (!hasColorTransform)
	{
		return color * openfl_Alphav;
	}
	color = vec4(color.rgb / color.a, color.a);
	mat4 colorMultiplier = mat4(0);
	colorMultiplier[0][0] = openfl_ColorMultiplierv.x;
	colorMultiplier[1][1] = openfl_ColorMultiplierv.y;
	colorMultiplier[2][2] = openfl_ColorMultiplierv.z;
	colorMultiplier[3][3] = openfl_ColorMultiplierv.w;
	color = clamp(openfl_ColorOffsetv + (color * colorMultiplier), 0.0, 1.0);
	if (color.a > 0.0)
	{
		return vec4(color.rgb * color.a * openfl_Alphav, color.a * openfl_Alphav);
	}
	return vec4(0.0, 0.0, 0.0, 0.0);
}

// variables which is empty, they need just to avoid crashing shader
uniform float iTimeDelta;
uniform float iFrameRate;
uniform int iFrame;
#define iChannelTime float[4](iTime, 0., 0., 0.)
#define iChannelResolution vec3[4](iResolution, vec3(0.), vec3(0.), vec3(0.))
uniform vec4 iMouse;
uniform vec4 iDate;

mat2 r2d(float a) {
	float c = cos(a), s = sin(a);
	return mat2(c, s, -s, c);
}

float de(vec3 p) {

	p.y += cos(iTime*2.) * .2;

	p.xy *= r2d(iTime + p.z);

	vec3 r;
	float d = 0., s = 1.;

	for (int i = 0; i < 3; i++)
		r = max(r = abs(mod(p*s + 1., 2.) - 1.), r.yzx),
		d = max(d, (.9 - min(r.x, min(r.y, r.z))) / s),
		s *= 3.;

	return d;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
	vec2 uv = fragCoord.xy / iResolution.xy - .5;
	uv.x *= iResolution.x / iResolution.y;

	vec3 ro = vec3(.1*cos(iTime), 0, -iTime), p;
	vec3 rd = normalize(vec3(uv, -1));
	p = ro;

	float it = 0.;
	for (float i=0.; i < 1.; i += .01) {
        it = i;
		float d = de(p);
		if (d < .0001) break;
		p += rd * d*.4;
	}
	it /= .4 * sqrt(abs(tan(iTime) + p.x*p.x + p.y*p.y));

	vec3 c = mix(vec3(.1, .1, .3), vec3(.7, .1, .3), it*sin(p.z));

	fragColor = vec4(c, texture(iChannel0, uv).a);
}

void main() {
	mainImage(gl_FragColor, openfl_TextureCoordv*openfl_TextureSize);
}
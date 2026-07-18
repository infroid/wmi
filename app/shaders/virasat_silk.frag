#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform vec4 uStartColor;
uniform vec4 uEndColor;
uniform float uUseGradient;
uniform float uGradientAngle;
uniform float uMaterial;
uniform float uFoldStrength;
uniform float uLightAngle;
uniform float uTextureScale;

out vec4 fragColor;

float softBand(float value, float width) {
  return smoothstep(1.0 - width, 1.0, value);
}

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  vec2 centred = uv - vec2(0.5);

  vec2 gradientDirection = vec2(cos(uGradientAngle), sin(uGradientAngle));
  float gradientMix = clamp(dot(centred, gradientDirection) + 0.5, 0.0, 1.0);
  vec3 base = mix(uStartColor.rgb, uEndColor.rgb, gradientMix * uUseGradient);

  float warpFrequency = mix(520.0, 260.0, step(0.5, uMaterial));
  warpFrequency = mix(warpFrequency, 720.0, step(1.5, uMaterial));
  warpFrequency = mix(warpFrequency, 360.0, step(2.5, uMaterial));
  warpFrequency *= mix(0.28, 1.05, uTextureScale);
  float weftFrequency = warpFrequency * mix(0.62, 0.9, step(2.5, uMaterial));

  float warpThread = softBand(0.5 + 0.5 * cos(uv.x * warpFrequency), 0.15);
  float weftThread = softBand(0.5 + 0.5 * cos(uv.y * weftFrequency), 0.2);
  float weave = warpThread * 0.62 + weftThread * 0.38;
  float crossing = warpThread * weftThread;

  float broadFold = sin(uv.x * 18.0 + sin(uv.y * 5.0) * 0.9);
  float fineFold = sin(uv.x * 43.0 - uv.y * 7.0) * 0.32;
  float foldHeight = broadFold + fineFold;
  float foldNormal = cos(uv.x * 18.0 + sin(uv.y * 5.0) * 0.9);
  vec2 lightDirection = normalize(vec2(cos(uLightAngle), sin(uLightAngle)));
  float directional = 0.5 + 0.5 * dot(normalize(vec2(foldNormal, 0.72)), lightDirection);

  float katan = 1.0 - step(0.5, uMaterial);
  float kora = step(0.5, uMaterial) * (1.0 - step(1.5, uMaterial));
  float tissue = step(1.5, uMaterial) * (1.0 - step(2.5, uMaterial));
  float silkCotton = step(2.5, uMaterial);

  float sheenStrength = katan * 0.34 + kora * 0.22 + tissue * 0.58 + silkCotton * 0.12;
  float anisotropicSheen = pow(max(0.0, directional), mix(7.0, 18.0, tissue));
  anisotropicSheen *= 0.45 + warpThread * 0.55;
  float diffuseFold = 0.78 + foldHeight * 0.08 * uFoldStrength;
  float microContrast = (weave - 0.45) * (katan * 0.13 + kora * 0.21 + tissue * 0.16 + silkCotton * 0.11);

  vec3 colour = base * (diffuseFold + microContrast);
  colour += vec3(1.0, 0.84, 0.62) * anisotropicSheen * sheenStrength * uFoldStrength;
  colour += vec3(1.0, 0.92, 0.78) * warpThread * 0.025;
  colour += vec3(0.16, 0.08, 0.04) * crossing * tissue * 0.13;

  float openWeave = 1.0 - crossing * 0.12;
  float alpha = mix(1.0, openWeave * 0.9, kora);
  colour = clamp(colour, 0.0, 1.0);
  fragColor = vec4(colour * alpha, alpha);
}

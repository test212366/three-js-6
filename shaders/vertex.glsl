varying vec2 vUv;
varying vec3 vPos;
varying vec2 vCoordinates;
attribute vec3 aCoordinates;
attribute float aOffset;
attribute float aSpeed;
attribute float aDirection;
attribute float aPress;


uniform float move;
uniform float time;
uniform vec2 mouse;


void main() {
	vUv = uv;

	vec3 pos = position;


	pos.x += sin(move*aSpeed) * 3.;
	pos.y += sin(move*aSpeed) * 3.;
	pos.z = mod(position.z + move * 20. * aSpeed + aOffset, 2000.) - 1000.;



	vec3 stable = position;
	float dist = distance(stable.xy, mouse);
	float area = 1. - smoothstep(0., 300., dist);

	stable.x += 50. * sin(0.1 * time * aPress) * aDirection * area;
	stable.y += 50. * sin(0.1 * time * aPress) * aDirection * area;
	stable.z += 200. * cos(0.1 * time * aPress) * aDirection * area;

	vec4 mvPosition = modelViewMatrix * vec4(stable, 1.);
	

	gl_PointSize = 2000. * (1. / - mvPosition.z);
	gl_Position = projectionMatrix * mvPosition;

	vCoordinates = aCoordinates.xy;
	vPos = pos;
}
shader_type canvas_item;

uniform vec4 colourA = vec4(1,0,0,1);
uniform vec4 colourB = vec4(0,1,0,1);

void fragment() {
	vec4 brightness = texture(TEXTURE, UV);
	if (brightness.r > 0.5) {
		COLOR = colourA * brightness.r;
	} else {
		COLOR = colourB * (brightness.r + 0.75);
	}
}

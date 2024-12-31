shader_type canvas_item;

uniform vec4 colour = vec4(280, 144, 99, 255); // BRICK-ISH
//uniform vec4 colour = vec4(180, 255, 210, 255); // GREEN
//uniform vec4 colour = vec4(180,225,300,255); // BLUE

void fragment() {
	vec4 brightness = texture(TEXTURE, UV);
	if (brightness.a != 0.0) {
		COLOR = colour/255.0 * brightness;
	}
}
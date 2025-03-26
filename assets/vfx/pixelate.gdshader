shader_type canvas_item;

uniform float pixelate: hint_range(2, 512, 4) = 256;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

void fragment(){
	vec2 uv = floor(UV * pixelate) / pixelate;
	COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
}
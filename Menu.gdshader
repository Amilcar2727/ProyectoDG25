shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float brightness : hint_range(-1.0, 1.0) = -0.1;
uniform float contrast : hint_range(0.5, 2.0) = 1.1;
uniform vec3 tint_color : source_color = vec3(0.2, 0.25, 0.3); // Azul sombrío
uniform float tint_strength : hint_range(0.0, 1.0) = 0.2;

void fragment() {
    vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV);

    // Ajustar brillo
    color.rgb += brightness;

    // Ajustar contraste
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;

    // Aplicar tinte sombrío
    color.rgb = mix(color.rgb, tint_color, tint_strength);

    COLOR = color;
}
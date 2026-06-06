if(room != rm_level_city)
{
	exit;
}

if (global.is_url_enabled)
{
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * current_button_scale, image_yscale * current_button_scale, 0, c_white, image_alpha);
}
    
var _gm_scale = 1;

draw_sprite_ext(spr_gamemaker_logo, 0, x, y + y_offset * current_text_scale, current_text_scale * _gm_scale, current_text_scale * _gm_scale, 0, c_white, image_alpha);
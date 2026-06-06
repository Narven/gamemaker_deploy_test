// Calculate how transparent the HUD should be
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = 1 - obj_effect_overlay.blocker_alpha;
}

var _alpha_paused_clamped = _alpha_paused;//clamp(_alpha_paused, 0.1, 1.0);

draw_set_alpha(_alpha_paused_clamped);

image_alpha = _alpha_paused_clamped;

// Draw the wave bar in the housing at the aesthetic level
draw_self();
draw_sprite_ext(obj_wave_manager.new_wave_timer % 0.5 > 0.25 ? spr_ui_wave_fill_white : spr_ui_wave_fill, 0, x - sprite_get_width(spr_ui_wave_housing) / 2, y + 2, fake_wave_progress, 1, 0, c_white, _alpha_paused_clamped);

// Draw some decoration for the bar
draw_sprite(spr_ui_wave_end, 0, x - sprite_get_width(spr_ui_wave_housing) / 2 + sprite_get_width(spr_ui_wave_housing) * fake_wave_progress, y);
draw_sprite(spr_ui_enemy_icon, 0, x - sprite_get_width(spr_ui_wave_housing) / 2 - 80, y);
draw_sprite(spr_ui_wave_flag, 0, x + sprite_get_width(spr_ui_wave_housing) / 2 + 50, y);

// Draw a separation line for the wave number text
draw_sprite(spr_ui_deco_line, 0, x, y - 50);

// Set text drawing settings
draw_set_font(fnt_rationale_regular_30);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);

// Draw the wave number text
draw_text(x, y - 80, $"WAVE {obj_wave_manager.wave_num}");

// Reset the alignments
draw_set_valign(fa_top);
draw_set_halign(fa_left);

// Reset the draw alpha
draw_set_alpha(1);
if (obj_input_manager.input_style != input_styles.TOUCH)
{
    instance_destroy();
}

current_button_state = BUTTON_STATE.IDLE;

current_button_scale = 1.0;

target_button_scale = 1.0;

button_scale_rate = 10;

current_colour = c_silver;
target_colour = c_silver;

colour_mix_value = 1.0;
colour_mix_rate = 10;

current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);

is_pressed = false;
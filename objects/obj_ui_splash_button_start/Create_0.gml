// Inherit the parent event
event_inherited();

// Change the text draw settings
button_set_font = fnt_rationale_regular_96;
y_offset = 15;

// Store the text to display on the button
button_text = "START";

// Store when the button should actually be active
active_state = SPLASH_STATE.START;

// Store a sound effect to play when the button is pressed
button_pressed_sfx = obj_sound_manager.asset_ui_confirm;
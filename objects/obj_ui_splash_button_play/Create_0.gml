// Inherit the parent event
event_inherited();

// Change the text draw settings
button_set_font = fnt_rationale_regular_48;
y_offset = 7.5;

// Store the text to display on the button
button_text = "PLAY";

// Store when the button should actually be active
active_state = SPLASH_STATE.MAIN;

// Store a sound effect to play when the button is pressed
button_pressed_sfx = obj_sound_manager.asset_ui_confirm;
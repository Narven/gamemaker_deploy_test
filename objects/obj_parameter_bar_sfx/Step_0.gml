// Inherit the parent event
event_inherited();

// Mirror the bar's fullness to the sound manager's SFX level
obj_sound_manager.sfx_level = bar_percent;
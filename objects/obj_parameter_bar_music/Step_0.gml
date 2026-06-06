// Inherit the parent event
event_inherited();

// Set the bar's fullness to mirror the sound manager's music level
obj_sound_manager.bgm_level = bar_percent;

// If there is music playing, set its gain to the sound manager's music level
if (obj_sound_manager.current_bgm != -1 && audio_is_playing(obj_sound_manager.current_bgm))
{
	audio_sound_gain(obj_sound_manager.current_bgm, obj_sound_manager.bgm_level, 0);
}

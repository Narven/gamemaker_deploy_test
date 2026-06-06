// Play a sound effect and register as hovered
if (!hovered)
{
	audio_play_sound(obj_sound_manager.asset_ui_hover, 50, false, obj_sound_manager.ui_level, 0.05);	
}

hovered = true;
stale_hover = false;
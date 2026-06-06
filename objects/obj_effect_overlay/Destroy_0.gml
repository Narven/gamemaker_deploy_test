// Clear screen effects
if (layer_get_fx("Screen_Effects") != -1)
{
    layer_clear_fx("Screen_Effects");
}

// Flag that controls aren't locked any more
global.is_controls_locked = false;
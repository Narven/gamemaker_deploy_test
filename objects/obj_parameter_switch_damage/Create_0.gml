// Inherit the parent event
event_inherited();

// Set the switch's label
switch_name = "Damage Number";

// Create a link between the switch's value and the global variable it should control
if (variable_global_exists("damage_ui"))
{
	switch_value = global.damage_ui;
}
else
{
	global.damage_ui = switch_value;
}
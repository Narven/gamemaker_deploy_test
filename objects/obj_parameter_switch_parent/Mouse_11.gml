// If the button is not pressed, register as unhovered
if (!pressed)
{
	hovered = false;
}
else // Otherwise, mark that the button is no longer hovered but should still act like it is
{
	stale_hover = true;	
}
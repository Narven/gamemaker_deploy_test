// Free up all the surfaces
surface_free(surf_source);

for (var _i = 0; _i < array_length(surf_destination); _i++)
{
	if (surface_exists(surf_destination[_i]))
	{
		surface_free(surf_destination[_i]);
	}
}
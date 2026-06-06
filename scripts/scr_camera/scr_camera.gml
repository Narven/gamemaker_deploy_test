/// @func screen_to_plane_3d(_screenX, _screenY, _planePoint, planeNormal, _matrixViewProjInv)
/// @desc Projects a 2D point on the screen onto a 3D plane.
/// @param {Real} _screenX The X coordinate of the 2D point on the screen.
/// @param {Real} _screenY The Y coordinate of the 2D point on the screen.
/// @param {Array<Real>} _planePoint An array with X,Y,Z coordinates of a point on the plane.
/// @param {Array<Real>} _planeNormal An array with the plane's normal vector (X,Y,Z).
/// @return {Array<Real>, Undefined} Returns an array containing the X,Y,Z coordinates of the
/// projected point on success or undefined on fail (i.e. there's no intersection with a ray
/// coming from the camera and the specified plane).
function screen_to_plane_3d(
	_screenX,
	_screenY,
	_planePoint,
	_planeNormal,
	_matrixViewProjInv)
{
	var _m = _matrixViewProjInv;

	_screenX = (_screenX / room_width) * 2 - 1;
	_screenY = (_screenY / room_height) * 2 - 1;

	var _rayStartX = _m[0] * _screenX + _m[4] * _screenY + _m[12];
	var _rayStartY = _m[1] * _screenX + _m[5] * _screenY + _m[13];
	var _rayStartZ = _m[2] * _screenX + _m[6] * _screenY + _m[14];
	var _rayStartW = _m[3] * _screenX + _m[7] * _screenY + _m[15];

	_rayStartX /= _rayStartW;
	_rayStartY /= _rayStartW;
	_rayStartZ /= _rayStartW;

	var _rayEndX = _m[0] * _screenX + _m[4] * _screenY + _m[8] + _m[12];
	var _rayEndY = _m[1] * _screenX + _m[5] * _screenY + _m[9] + _m[13];
	var _rayEndZ = _m[2] * _screenX + _m[6] * _screenY + _m[10] + _m[14];
	var _rayEndW = _m[3] * _screenX + _m[7] * _screenY + _m[11] + _m[15];

	_rayEndX /= _rayEndW;
	_rayEndY /= _rayEndW;
	_rayEndZ /= _rayEndW;

	var _rayDirX = _rayEndX - _rayStartX;
	var _rayDirY = _rayEndY - _rayStartY;
	var _rayDirZ = _rayEndZ - _rayStartZ;

	var _length = point_distance_3d(0, 0, 0, _rayDirX, _rayDirY, _rayDirZ);
	_rayDirX /= _length;
	_rayDirY /= _length;
	_rayDirZ /= _length;

	var _denom = dot_product_3d(
		_rayDirX,
		_rayDirY,
		_rayDirZ,
		_planeNormal[0],
		_planeNormal[1],
		_planeNormal[2]
	);

	if (_denom == 0)
		return undefined;

	var _pX = _planePoint[0] - _rayStartX;
	var _pY = _planePoint[1] - _rayStartY;
	var _pZ = _planePoint[2] - _rayStartZ;

	var _t = dot_product_3d(
		_pX, _pY, _pZ, _planeNormal[0], _planeNormal[1], _planeNormal[2]) / _denom;

	if (_t < 0)
		return undefined;

	return [
		_rayStartX + _rayDirX * _t,
		_rayStartY + _rayDirY * _t,
		_rayStartZ + _rayDirZ * _t,
	];
}

/// @func world_to_screen(_x, _y, _z, _matrix_view_projection[, _flip_y[, _screen_width[, _screen_height]]])
/// @desc Converts 3D world coordinates into 2D coordinates on the screen.
/// @param {Real} _x The X position in the world.
/// @param {Real} _y The Y position in the world.
/// @param {Real} _z The Z position in the world.
/// @param {Array<Real>} _matrix_view_projection Multiplication of the view and the projection matrices.
/// @param {Bool] [_flip_y] Whether the resulting 2D coordinate needs to be flipped on the Y axis. Defaults to false.
/// @param {Real} [_screen_width] The width of the screen. Defaults to the window's width.
/// @param {Real} [_screen_height] The height of the screen. Defaults to the window's height.
/// @return {Array<Real>, Undefined} An array with the 2D X and Y coordinates or undefined if given point is not inside the viewport.
function world_to_screen(
	_x, _y, _z, _matrix_view_projection, _flip_y = false, _screen_width = undefined, _screen_height = undefined)
{
	var _is_browser = (os_type == os_gxgames || os_browser != browser_not_a_browser);
	var _app_pos = application_get_position();

	_screen_width ??= max(_is_browser ? (_app_pos[2] - _app_pos[0]) : window_get_width(), 1);
	_screen_height ??= max(_is_browser ? (_app_pos[3] - _app_pos[1]) : window_get_height(), 1);

	var _screen_pos = matrix_transform_vertex(_matrix_view_projection, _x, _y, _z, 1);

	if (_screen_pos[2] < 0)
	{
		return undefined;
	}

	_screen_pos[@ 0] /= _screen_pos[3];
	_screen_pos[@ 1] /= _screen_pos[3];
	_screen_pos[@ 0] = ((_screen_pos[@ 0] * 0.5) + 0.5) * _screen_width;
	_screen_pos[@ 1] = ((_screen_pos[@ 1] * 0.5) + 0.5) * _screen_height;

	if (_flip_y)
	{
		_screen_pos[@ 1] = _screen_height - _screen_pos[1];
	}

	return _screen_pos;
}

function screen_get_ratio() {
	return window_get_width() / room_width
}

function screen_get_mouse_y() {
	return mouse_y / screen_get_ratio();
}

function screen_get_width() {
	return room_width / screen_get_ratio()
}

function screen_get_height() {
	return room_height / screen_get_ratio()
}
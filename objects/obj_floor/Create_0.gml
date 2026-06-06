// Create a vertex buffer that will act as the floor in 6 parts
// Create a vertex format holding position, colour information, and texture coordinates
vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_colour();
	vertex_format_add_texcoord();
vformat = vertex_format_end();

// Find the full width of the plane based on the amount of depth units it needs to cover due to perspective projection
var scale_mod = (depth + 9500 - layer_get_depth("Character"))/7000;

// Lay out how wide and tall each part of the floor should be
var part_width = 2 * room_width * scale_mod / 3;
var part_height = room_height / 8;

// Hold the left and top positions of the parts
var left = room_width / 2 -room_width * scale_mod;
var top = room_height * 3/4;

// Floor Part 1
floor_buffer_1 = vertex_create_buffer();
vertex_begin(floor_buffer_1, vformat);
{
	vertex_position_3d(floor_buffer_1, left, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_1, 0, -1, 0);
	vertex_colour(floor_buffer_1, c_white, 1);
	vertex_texcoord(floor_buffer_1, sprite_get_uvs(spr_floor_1,0)[0], sprite_get_uvs(spr_floor_1,0)[1]);
	
	vertex_position_3d(floor_buffer_1, left, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_1, 0, -1, 0);
	vertex_colour(floor_buffer_1, c_white, 1);
	vertex_texcoord(floor_buffer_1, sprite_get_uvs(spr_floor_1,0)[0], sprite_get_uvs(spr_floor_1,0)[3]);
	
	vertex_position_3d(floor_buffer_1, left + part_width, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_1, 0, -1, 0);
	vertex_colour(floor_buffer_1, c_white, 1);
	vertex_texcoord(floor_buffer_1, sprite_get_uvs(spr_floor_1,0)[2], sprite_get_uvs(spr_floor_1,0)[1]);
	
	vertex_position_3d(floor_buffer_1, left + part_width, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_1, 0, -1, 0);
	vertex_colour(floor_buffer_1, c_white, 1);
	vertex_texcoord(floor_buffer_1, sprite_get_uvs(spr_floor_1,0)[2], sprite_get_uvs(spr_floor_1,0)[3]);
}
vertex_end(floor_buffer_1);
vertex_freeze(floor_buffer_1);

// Floor Part 2
left += part_width;
floor_buffer_2 = vertex_create_buffer();
vertex_begin(floor_buffer_2, vformat);
{
	vertex_position_3d(floor_buffer_2, left, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_2, 0, -1, 0);
	vertex_colour(floor_buffer_2, c_white, 1);
	vertex_texcoord(floor_buffer_2, sprite_get_uvs(spr_floor_2,0)[0], sprite_get_uvs(spr_floor_2,0)[1]);
	
	vertex_position_3d(floor_buffer_2, left, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_2, 0, -1, 0);
	vertex_colour(floor_buffer_2, c_white, 1);
	vertex_texcoord(floor_buffer_2, sprite_get_uvs(spr_floor_2,0)[0], sprite_get_uvs(spr_floor_2,0)[3]);
	
	vertex_position_3d(floor_buffer_2, left + part_width, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_2, 0, -1, 0);
	vertex_colour(floor_buffer_2, c_white, 1);
	vertex_texcoord(floor_buffer_2, sprite_get_uvs(spr_floor_2,0)[2], sprite_get_uvs(spr_floor_2,0)[1]);
	
	vertex_position_3d(floor_buffer_2, left + part_width, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_2, 0, -1, 0);
	vertex_colour(floor_buffer_2, c_white, 1);
	vertex_texcoord(floor_buffer_2, sprite_get_uvs(spr_floor_2,0)[2], sprite_get_uvs(spr_floor_2,0)[3]);
}
vertex_end(floor_buffer_2);
vertex_freeze(floor_buffer_2);

// Floor Part 3
left += part_width;
floor_buffer_3 = vertex_create_buffer();
vertex_begin(floor_buffer_3, vformat);
{
	vertex_position_3d(floor_buffer_3, left, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_3, 0, -1, 0);
	vertex_colour(floor_buffer_3, c_white, 1);
	vertex_texcoord(floor_buffer_3, sprite_get_uvs(spr_floor_3,0)[0], sprite_get_uvs(spr_floor_3,0)[1]);
	
	vertex_position_3d(floor_buffer_3, left, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_3, 0, -1, 0);
	vertex_colour(floor_buffer_3, c_white, 1);
	vertex_texcoord(floor_buffer_3, sprite_get_uvs(spr_floor_3,0)[0], sprite_get_uvs(spr_floor_3,0)[3]);
	
	vertex_position_3d(floor_buffer_3, left + part_width, top, layer_get_depth("Character") + 8500);
	vertex_normal(floor_buffer_3, 0, -1, 0);
	vertex_colour(floor_buffer_3, c_white, 1);
	vertex_texcoord(floor_buffer_3, sprite_get_uvs(spr_floor_3,0)[2], sprite_get_uvs(spr_floor_3,0)[1]);
	
	vertex_position_3d(floor_buffer_3, left + part_width, top + part_height, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_3, 0, -1, 0);
	vertex_colour(floor_buffer_3, c_white, 1);
	vertex_texcoord(floor_buffer_3, sprite_get_uvs(spr_floor_3,0)[2], sprite_get_uvs(spr_floor_1,0)[3]);
}
vertex_end(floor_buffer_3);
vertex_freeze(floor_buffer_3);

// Floor Part 4
left -= part_width * 2;
top += part_height;
floor_buffer_4 = vertex_create_buffer();
vertex_begin(floor_buffer_4, vformat);
{
	vertex_position_3d(floor_buffer_4, left, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_4, 0, -1, 0);
	vertex_colour(floor_buffer_4, c_white, 1);
	vertex_texcoord(floor_buffer_4, sprite_get_uvs(spr_floor_4,0)[0], sprite_get_uvs(spr_floor_4,0)[1]);
	
	vertex_position_3d(floor_buffer_4, left, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_4, 0, -1, 0);
	vertex_colour(floor_buffer_4, c_white, 1);
	vertex_texcoord(floor_buffer_4, sprite_get_uvs(spr_floor_4,0)[0], sprite_get_uvs(spr_floor_4,0)[3]);
	
	vertex_position_3d(floor_buffer_4, left + part_width, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_4, 0, -1, 0);
	vertex_colour(floor_buffer_4, c_white, 1);
	vertex_texcoord(floor_buffer_4, sprite_get_uvs(spr_floor_4,0)[2], sprite_get_uvs(spr_floor_4,0)[1]);
	
	vertex_position_3d(floor_buffer_4, left + part_width, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_4, 0, -1, 0);
	vertex_colour(floor_buffer_4, c_white, 1);
	vertex_texcoord(floor_buffer_4, sprite_get_uvs(spr_floor_4,0)[2], sprite_get_uvs(spr_floor_4,0)[3]);
}
vertex_end(floor_buffer_4);
vertex_freeze(floor_buffer_4);

// Floor Part 5
left += part_width;
floor_buffer_5 = vertex_create_buffer();
vertex_begin(floor_buffer_5, vformat);
{
	vertex_position_3d(floor_buffer_5, left, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_5, 0, -1, 0);
	vertex_colour(floor_buffer_5, c_white, 1);
	vertex_texcoord(floor_buffer_5, sprite_get_uvs(spr_floor_5,0)[0], sprite_get_uvs(spr_floor_5,0)[1]);
	
	vertex_position_3d(floor_buffer_5, left, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_5, 0, -1, 0);
	vertex_colour(floor_buffer_5, c_white, 1);
	vertex_texcoord(floor_buffer_5, sprite_get_uvs(spr_floor_5,0)[0], sprite_get_uvs(spr_floor_5,0)[3]);
	
	vertex_position_3d(floor_buffer_5, left + part_width, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_5, 0, -1, 0);
	vertex_colour(floor_buffer_5, c_white, 1);
	vertex_texcoord(floor_buffer_5, sprite_get_uvs(spr_floor_5,0)[2], sprite_get_uvs(spr_floor_5,0)[1]);
	
	vertex_position_3d(floor_buffer_5, left + part_width, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_5, 0, -1, 0);
	vertex_colour(floor_buffer_5, c_white, 1);
	vertex_texcoord(floor_buffer_5, sprite_get_uvs(spr_floor_5,0)[2], sprite_get_uvs(spr_floor_5,0)[3]);
}
vertex_end(floor_buffer_5);
vertex_freeze(floor_buffer_5);

// Floor Part 6
left += part_width;
floor_buffer_6 = vertex_create_buffer();
vertex_begin(floor_buffer_6, vformat);
{
	vertex_position_3d(floor_buffer_6, left, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_6, 0, -1, 0);
	vertex_colour(floor_buffer_6, c_white, 1);
	vertex_texcoord(floor_buffer_6, sprite_get_uvs(spr_floor_6,0)[0], sprite_get_uvs(spr_floor_6,0)[1]);
	
	vertex_position_3d(floor_buffer_6, left, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_6, 0, -1, 0);
	vertex_colour(floor_buffer_6, c_white, 1);
	vertex_texcoord(floor_buffer_6, sprite_get_uvs(spr_floor_6,0)[0], sprite_get_uvs(spr_floor_6,0)[3]);
	
	vertex_position_3d(floor_buffer_6, left + part_width, top, layer_get_depth("Character") + 4250);
	vertex_normal(floor_buffer_6, 0, -1, 0);
	vertex_colour(floor_buffer_6, c_white, 1);
	vertex_texcoord(floor_buffer_6, sprite_get_uvs(spr_floor_6,0)[2], sprite_get_uvs(spr_floor_6,0)[1]);
	
	vertex_position_3d(floor_buffer_6, left + part_width, top + part_height, layer_get_depth("Character"));
	vertex_normal(floor_buffer_6, 0, -1, 0);
	vertex_colour(floor_buffer_6, c_white, 1);
	vertex_texcoord(floor_buffer_6, sprite_get_uvs(spr_floor_6,0)[2], sprite_get_uvs(spr_floor_6,0)[3]);
}
vertex_end(floor_buffer_6);
vertex_freeze(floor_buffer_6);
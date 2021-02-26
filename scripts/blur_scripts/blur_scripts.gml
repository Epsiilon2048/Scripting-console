
function sprite_create_blur(sprite, downamount, width, height, blurradius, quality, directions)
{
	/// @func sprite_create_blur(sprite,downamount,width,height,blurradius,quality,directions)
	/// @arg sprite
	/// @arg downamount
	/// @arg width
	/// @arg height
	/// @arg blurradius
	/// @arg quality
	/// @arg directions
	// Return: Sprite Index
		
	var _sprite = sprite;
	var _downamount = downamount;
	var _width = width;
	var _height = height;
	var _blurradius = blurradius;
	var _quality = quality;
	var _directions = directions;
	var _shader = sh_blur_static;
	
	var uni_size = shader_get_uniform(_shader,"bl_size"); //uniform for width, height, radius
	var uni_quality = shader_get_uniform(_shader,"bl_quality"); //blur quality
	var uni_directions = shader_get_uniform(_shader,"bl_directions"); //what directions to blur
	
	var tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(true);
	
	var surf_blur_resize = surface_create(_width/_downamount, _height/_downamount);
	surface_set_target(surf_blur_resize);
	draw_sprite_stretched(_sprite, 0, 0, 0, surface_get_width(surf_blur_resize), surface_get_height(surf_blur_resize));
	surface_reset_target();
	
	var surf_blur_final = surface_create(_width, _height);
	surface_set_target(surf_blur_final);
	shader_set(_shader);
	shader_set_uniform_f(uni_size, surface_get_width(surf_blur_final), surface_get_height(surf_blur_final), _blurradius); //width,height,radius
	shader_set_uniform_i(uni_quality, _quality);
	shader_set_uniform_i(uni_directions, _directions);
	draw_surface_stretched(surf_blur_resize, 0, 0, _width, _height);
	shader_reset();
	surface_reset_target();
	
	
	var surf_sprite_blur = sprite_create_from_surface(surf_blur_final, 0, 0, surface_get_width(surf_blur_final), surface_get_height(surf_blur_final), 0, 0, 0, 0);
	
	gpu_set_tex_filter(tex_filter_old);
	surface_free(surf_blur_resize);
	surface_free(surf_blur_final);
	
	return surf_sprite_blur;
}



function sprite_draw_blur(blur_id, x, y)
{
	/// @func sprite_draw_blur(blur_id, x, y)
	/// @arg id
	/// @arg x
	/// @arg y
	/*
	*   Example:
	*   sprite_draw_blur(blur_background,x,y);
	*   You can draw the blur sprite id without this script too.
	*/
	
	draw_sprite(blur_id, 0, x, y);
}



function sprite_blur_clear(blur_id)
{
	/// @func sprite_blur_clear(blur_id)
	/// @arg blur_id
	// You can delete the blur sprite id without this script too.
	
	sprite_delete(blur_id);
}



function draw_surface_blur(surface, x, y, w, h, downamount)
{
	/// @func draw_surface_blur(surface, x, y, w, h, downamount);
	/// @arg surface
	/// @arg x
	/// @arg y
	/// @arg w
	/// @arg h
	/// @arg downamount
	
	var _surface = surface;
	var _xx = x;
	var _yy = y;
	var _ww = w;
	var _hh = h;
	var _downscale = downamount;
	var _shader = sh_blur_realtime;
	var _uni_texel_size = shader_get_uniform(_shader, "texel_size");
	var _uni_blur_vector = shader_get_uniform(_shader, "blur_vector");
	var _texel_w = 1/_ww;
	var _texel_h = 1/_hh;
	
	var surf_pang = surface_create(_ww, _hh);
	var surf_ping = surface_create(_ww*_downscale, _hh*_downscale);
	var surf_pong = surface_create(_ww*_downscale, _hh*_downscale);
	
	var tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(true);
	gpu_set_blendenable(false);

	// surface blur area
	surface_set_target(surf_pang);
	draw_surface_part(_surface, _xx, _yy, _ww, _hh, 0, 0);
	surface_reset_target();

	// ping surface (downscale)
	surface_set_target(surf_ping);
	draw_surface_stretched(surf_pang, 0, 0, round(_ww*_downscale), round(_hh*_downscale));
	surface_reset_target();

	// apply blur shader
	shader_set(_shader);

	shader_set_uniform_f(_uni_texel_size, _texel_w/_downscale, _texel_h/_downscale);
	shader_set_uniform_f(_uni_blur_vector, 1, 0);
	surface_set_target(surf_pong)
	draw_surface(surf_ping, 0, 0);
	surface_reset_target();

	shader_set_uniform_f(_uni_blur_vector, 0, 1);
	surface_set_target(surf_ping)
	draw_surface(surf_pong, 0, 0);
	surface_reset_target();

	shader_reset();

	// draw blur
	draw_surface_stretched(surf_ping, _xx, _yy, _ww, _hh);

	gpu_set_tex_filter(tex_filter_old);
	gpu_set_blendenable(true);
	surface_free(surf_pang);
	surface_free(surf_ping);
	surface_free(surf_pong);
}


function draw_surface_blur_ext(surface, x, y, w, h, xscale, yscale, downamount)
{
	/// @func draw_surface_blur(surface, x, y, w, h, downamount);
	/// @arg surface
	/// @arg x
	/// @arg y
	/// @arg w
	/// @arg h
	/// @arg downamount
	
	var _surface = surface;
	var _xx = x;
	var _yy = y;
	var _ww = w;
	var _hh = h;
	var _downscale = downamount;
	var _shader = sh_blur_realtime;
	var _uni_texel_size = shader_get_uniform(_shader, "texel_size");
	var _uni_blur_vector = shader_get_uniform(_shader, "blur_vector");
	var _texel_w = 1/_ww;
	var _texel_h = 1/_hh;
	
	var surf_pang = surface_create(_ww, _hh);
	var surf_ping = surface_create(_ww*_downscale, _hh*_downscale);
	var surf_pong = surface_create(_ww*_downscale, _hh*_downscale);
	
	var tex_filter_old = gpu_get_tex_filter();
	gpu_set_tex_filter(true);
	gpu_set_blendenable(false);

	// surface blur area
	
	surface_set_target(surf_pang);
	draw_surface_part_ext(_surface, _xx/xscale, _yy/yscale, _ww, _hh, 0, 0, xscale, yscale, c_white, 1);
	surface_reset_target();

	// ping surface (downscale)
	surface_set_target(surf_ping);
	draw_surface_stretched(surf_pang, 0, 0, round(_ww*_downscale), round(_hh*_downscale));
	surface_reset_target();

	// apply blur shader
	shader_set(_shader);

	shader_set_uniform_f(_uni_texel_size, _texel_w/_downscale, _texel_h/_downscale);
	shader_set_uniform_f(_uni_blur_vector, 1, 0);
	surface_set_target(surf_pong)
	draw_surface_stretched(surf_ping, 0, 0, 1, 1);
	surface_reset_target();

	shader_set_uniform_f(_uni_blur_vector, 0, 1);
	surface_set_target(surf_ping)
	draw_surface_stretched(surf_pong, 0, 0, 1, 1);
	surface_reset_target();

	shader_reset();

	// draw blur
	draw_surface_stretched(surf_ping, _xx, _yy, _ww, _hh);

	gpu_set_tex_filter(tex_filter_old);
	gpu_set_blendenable(true);
	surface_free(surf_pang);
	surface_free(surf_ping);
	surface_free(surf_pong);
}

function wave(from, to, duration, offset)
{
	/// @func wave(from, to, duration, offset)
	/// @param from
	/// @param to
	/// @param duration
	/// @param offset
	
	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4;
}

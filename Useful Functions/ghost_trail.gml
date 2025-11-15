///@desc Instantiates a new ghost trail system struct.
///@param {real} _length The number of after-images the ghost trail system should store.
///@param {real} _spacing The number of frames between after-images.
///@param {real} _starting_alpha The starting opacity of a freshly generated after-image. 
function GhostTrailSystem(_length,_spacing,_starting_alpha) constructor {
	__array = [];
	__counter = 0;
	__spacing = _spacing;
	__length = _length;
	__alpha = _starting_alpha;
	
	///@method Updates the ghost trail with additional images.
	///@param {assset} _spr The sprite to add.
	///@param {real} _img The frame number to add.
	///@param {real} _x The x coordinate at which to draw the sprite.
	///@param {real} _y The y coordinate at which to draw the sprite.
	///@param {real} _xscale Horizontal scale multiplier for the sprite.
	///@param {real} _yscale Vertical scale multiplier for the sprite.
	///@param {real} _angle The angle at which to draw the sprite.
	///@param {Constant.Color} _col The color with which to draw the sprite.
	static add = function(_spr,_img,_x,_y,_xscale,_yscale,_angle,_col){
		if (__counter < __spacing){
			__counter++;
			return false;
		} else {
			__counter = 0;
			var _img_struct = {
				spr : _spr,
				img : _img,
				X : _x,
				Y : _y,
				xscale : _xscale,
				yscale : _yscale,
				angle : _angle,
				col : _col
			}
			array_insert(__array,0,_img_struct);
			if (array_length(__array) > __length){
				array_resize(__array,__length);
			}
			return true;
		}	
	}
	
	///@method Draws the ghost trail system.
	static draw = function(){
		for (var i = 0; i < array_length(__array); i++){
			var _img = __array[i];
			var _alpha = lerp(__alpha,0,i * (1/__length));
			if (_img != -1)
			draw_sprite_ext(_img.spr,_img.img,_img.X,_img.Y,_img.xscale,_img.yscale,_img.angle,_img.col,_alpha)
		
		}
	}
	
	///@method Updates the ghost trail with dummy entries, causing the remaining after-images to fade away without generating new images.
	static fade = function(){
		if (__counter < __spacing){
			__counter++;
		} else {
			__counter = 0;
			array_insert(__array,0,-1);
		}
	}
	
	///@method Clears the ghost trail system.
	static clear = function(){
		__array = [];
	}
}

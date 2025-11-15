function executeMovement() {
    var _subpixel = .5;
    var _collided = false;


    //Horizontal stuff.
    if (!place_meeting(x + move_x, y, collidables_array)) {
        //Check for downward slopes & go down them
        if (move_y >= 0 && !place_meeting(x + move_x, y + 1, collidables_array) && place_meeting(x + move_x, y + abs(move_x), collidables_array)) {
            while (!place_meeting(x + move_x, y + _subpixel, collidables_array)) {
                y += _subpixel;
            }
        }
        x += move_x;

    //Check for upward slopes & go up them.
    } else if (!place_meeting(x + move_x, y - round(max(abs(move_x),1)), collidables_array)) {
        while (place_meeting(x + move_x, y, collidables_array)) {
            y -= _subpixel;
        }
        x += move_x;
    } else {
    //Otherwise, get as close as you can.
        while (!place_meeting(x + sign(move_x) * _subpixel, y, collidables_array)) {
            x += sign(move_x) * _subpixel;
        }
        _collided = true;
    }


    //Check for vertical collisions, vertical move commit.
    if (!place_meeting(x, y + move_y, collidables_array)) {
        y += move_y;
    } else {
        while (!place_meeting(x, y + sign(move_y) * _subpixel, collidables_array)) {
            y += sign(move_y) * _subpixel;
        }
        _collided = true;
    }
	
	var _movingPlatform = instance_place(x,y + max(1,move_y),obj_platform_parent);
	if (_movingPlatform != noone){
		var _is_collidable = false;
		for (var i = 0; i < array_length(collidables_array);i++){
			if (collidables_array[i] == _movingPlatform) _is_collidable = true;	
		}
		if (_is_collidable && onground){
			x += _movingPlatform.move_x;
			y += _movingPlatform.move_y;
		}
	}
	
    return _collided;
}

function execute_movement(_moveX,_moveY,_collidables = collidables,_downslopes = true,_upslopes = true,_x_col_stop = true,_y_col_stop = true,_check_vert_points = true) {
	//check_top_points();
    var _subpixel = .5;
	var _collided = {}
    _collided.X = false;
	_collided.Y = false;

    //Horizontal stuff.
    if (!place_meeting(x + _moveX, y, collidables)) {
        //Check for downward slopes & go down them
        if (_downslopes == true && _moveY >= 0 && !place_meeting(x + _moveX, y + 1, collidables) && place_meeting(x + _moveX, y + max(abs(_moveX),1)+1, collidables)) {
            while (!place_meeting(x + _moveX, y + _subpixel, collidables)) {
                y += _subpixel;
            }
        }
        x += _moveX;

    //Check for upward slopes & go up them.
    } else if (_upslopes == true && !place_meeting(x + _moveX, y - round(max(abs(_moveX),1)+1), collidables)) {
        while (place_meeting(x + _moveX, y, collidables)) {
            y -= _subpixel;
        }
        x += _moveX;
    } else {
    //Otherwise, get as close as you can.
        while (!place_meeting(x + sign(_moveX) * _subpixel, y, collidables)) {
            x += sign(_moveX) * _subpixel;
        }
		if (_x_col_stop == true) moveX = 0;
        _collided.X = true;
    }
	
	

		
	check_top_points();
	
    //Check for vertical collisions, vertical move commit.
    if (!place_meeting(x, y + _moveY, collidables)) {
        y += _moveY;
    } else if (_check_vert_points == true && topLeftBlocked == true && topMiddleLeftBlocked == false && sign(hInput) >= 0) {
		while (place_meeting(x,y + _moveY,collidables) == true && place_meeting(x+_subpixel,y,collidables)== false){
			x+=_subpixel;
		}
	
	} else if (_check_vert_points == true && topRightBlocked == true && topMiddleRightBlocked == false && sign(hInput) <= 0){
		while (place_meeting(x,y + _moveY,collidables) == true && place_meeting(x-_subpixel,y,collidables)== false){
			x-=_subpixel;
		}			
		
	} else {	
        while (!place_meeting(x, y + sign(_moveY) * _subpixel, collidables)) {
            y += sign(_moveY) * _subpixel;
        }
		if (object_index == obj_player) jumpHoldTimer = 0;
		if (sign(moveY) > 0) onground = true;
		if (_y_col_stop == true) moveY = 0;
        _collided.Y = true;
    }
	
	var _movingPlatform = instance_place(x,y + max(1,_moveY),obj_platform_parent);
	if (_movingPlatform != noone &&	array_contains(collidables,_movingPlatform)){
		myplatform = _movingPlatform		
	} else {
		_movingPlatform = instance_place(x,y + max(1,_moveY),obj_pushable_parent);
		if (_movingPlatform != noone) {
			myplatform = _movingPlatform;
		} else {
			myplatform = noone;	
		}
	}
    return _collided;
}


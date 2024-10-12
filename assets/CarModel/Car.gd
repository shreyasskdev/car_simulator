extends VehicleBody3D

var max_rpm = 500
var max_torque = 500 

func _physics_process(delta):
	steering = lerp( steering, Input.get_axis("right", "left") * 0.4, 5 * delta)
	var acceleretion = Input.get_axis("front", "back")
	var rpm = abs($BackLeftWheel.get_rpm())
	$BackLeftWheel.engine_force = -acceleretion * max_torque * ( 1 - rpm / max_rpm)
	rpm = abs($BackRightWheel.get_rpm())
	$BackRightWheel.engine_force = -acceleretion * max_torque * ( 1 - rpm / max_rpm)

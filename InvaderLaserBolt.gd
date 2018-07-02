extends RigidBody2D

signal hiding

export (int) var SPEED  # how fast the player will move (pixels/sec)

var LaserBoltMoving = false

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    hide()

func _process(delta):
    # move the laser bolt up the screen
    if (LaserBoltMoving):
        position.y += SPEED 

func _disable_laserbolt():   
    LaserBoltMoving = false
    hide()
    emit_signal("hiding")
    $CollisionShape2D.disabled = true # stop it from destroying anything else

func _on_VisibilityNotifier2D_screen_exited():
    # stop the laser bolt moving 
    _disable_laserbolt()

func _on_InvaderLaserBolt_body_entered(body):
    # delete the laser bolt
    print("Laser bolt has hit the target!")
    print(body) 
    _disable_laserbolt()
    
func EnableCollision():
    $CollisionShape2D.disabled = false 

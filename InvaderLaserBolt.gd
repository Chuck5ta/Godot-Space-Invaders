extends Area2D

signal hit(area, LaserPosition)
signal hiding

export (int) var SPEED  # how fast the player will move (pixels/sec)

var LaserBoltMoving = false
# Used for resetting the invader
var StartPositionX = 0;
var StartPositionY = 0;

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
    print("Disable laser")
    LaserBoltMoving = false
    hide()
    $AnimatedSprite.stop()
    $CollisionShape2D.disabled = true # stop it from destroying anything else

func _on_VisibilityNotifier2D_screen_exited():
    # stop the laser bolt moving 
    _disable_laserbolt()
    emit_signal("hiding")
        
func _reset_laserbolt(): 
    print("Activate Invader!")
    show()   
    $AnimatedSprite.play() 
    $AnimatedSprite.show()
    LaserBoltMoving = true
    $CollisionShape2D.disabled = false 


func _on_InvaderLaserBolt_area_entered(area):
 #   if area.getname() == "Barrier1":
 #       queue_free()
 #       var Barrier = get_tree().get_root().get_node("Barrier1")
  #  position.x = StartPositionX
  #  position.y = StartPositionY  
    print("Invader laser hit something!")
    LaserBoltMoving = false
    $AnimatedSprite.stop()
    $AnimatedSprite.visible = false
    hide()
    emit_signal("hit", area, position)
    _disable_laserbolt()
    
    
    
    
    
    
    

extends RigidBody2D
signal hit

var Flying = false
var FlyDirection = 5 # +5 move right, -5 move left across the screen
var MothershipAlive = true
# Used for resetting the mothership
var StartPositionX = 0;
var StartPositionY = 0;

func _ready():  
    # store starting position - required for resetting for the next wave
    StartPositionX = position.x
    StartPositionY = position.y  
    randomize()
    $AppearTimer.start()

func _process(delta):
    if (MothershipAlive && Flying):
        position.x += FlyDirection

func _on_AppearTimer_timeout():
    $AppearTimer.stop()
    $FlyingSound.play();
    $AppearTimer.wait_time = 10 + randi() % 11  # between 10 and 20
    $AppearTimer.start()
    Flying = true

func _on_VisibilityNotifier2D_screen_exited():
    if (MothershipAlive):
        Flying = false
        $FlyingSound.stop();
        if (FlyDirection == 5):
            FlyDirection = -5
        else: 
            FlyDirection = 5
    else:
        $AppearTimer.stop()

func _on_Mothership_body_entered(body):
    print("Mothership has been hit!!")
    $CollisionShape2D.disabled = true
    MothershipAlive = false
    emit_signal("hit")
    $FlyingSound.stop();
    $ExplosionSound.play()
    $MothershipSprite.visible = false 
    $ExplosionSprite.visible = true 
    $ExplosionTimer.start() 
    $AppearTimer.stop()

func _on_ExplsionTimer_timeout():
    $ExplosionSprite.visible = false
    
func disable_mothership():
    $CollisionShape2D.disabled = true
    MothershipAlive = false
    $MothershipSprite.visible = false 
    $AppearTimer.stop()
    
# Run at the start of a new level
func _reset_mothership_scene():
    show()  
    $MothershipSprite.show()
    $MothershipSprite.visible = true 
    position.x = StartPositionX
    position.y = StartPositionY
    MothershipAlive = true
    FlyDirection = 5 # move right
    $CollisionShape2D.disabled = false
    $AppearTimer.start()

    

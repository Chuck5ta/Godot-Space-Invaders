extends RigidBody2D
signal hit

var Flying = false
var FlyDirection = 5 # move right
var MothershipAlive = true
# Used for resetting the mothership
var StartPositionX = 0;
var StartPositionY = 0;

func _ready():  
    # store position
    StartPositionX = position.x
    StartPositionY = position.y  
    randomize()
    $AppearTimer.start()

func _process(delta):
    if (MothershipAlive && Flying):
        position.x += FlyDirection

func _on_AppearTimer_timeout():
    #show()
    $FlyingSound.play();
    var WaitTime = randi() % 5
    $AppearTimer.wait_time = WaitTime
    Flying = true


func _on_VisibilityNotifier2D_screen_exited():
    if (MothershipAlive):
        Flying = false
        $FlyingSound.stop();
        print("Mothership POP")
        if (FlyDirection == 5):
            FlyDirection = -5
        else: 
            FlyDirection = 5
    else:
        $AppearTimer.stop()
    # restart the timer
    #$AppearTimer.stop()
    #$AppearTimer.start()
    


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
    # hide animation    
    #$AnimatedSprite.stop()
    #$AnimatedSprite.visible = false  
    #$Explosion.visible = true   


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
    Flying = true
    FlyDirection = 5 # move right
    $CollisionShape2D.disabled = false
    $AppearTimer.start()

    

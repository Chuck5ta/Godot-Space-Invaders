extends RigidBody2D
signal hit

var Flying = false
var FlyDirection = 5 # move right
var MothershipAlive = true
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():    
    randomize()
    #hide()
    $AppearTimer.start()
    #position.x = 100
    #position.y = 100

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

    

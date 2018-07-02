extends RigidBody2D
#export (PackedScene) var ExplodingInvader
signal hit
signal enteringEarth
var SPEED = 0.4
var MovementRight = true #Invader will move right when initially spawned
var MovementDown = false
var MaxDistanceToTravel = 80 # max distance to move left and right
var DistanceTravelled = 0 # Distance travelled so far in pixels
var DistanceToMoveDown = 25 #move 50 pixels down the screen
var Attack = false # to prevent movement before the game starts 
var AnimationSpeed = 1

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    $AnimatedSprite.get_sprite_frames().set_animation_speed("animate", 1)
    
func _process(delta):
    if (!Attack):
        pass
    #move the Invader
    if (MovementDown):
        position.y += DistanceToMoveDown      
        MovementDown = false 
    elif (MovementRight):
        position.x += SPEED
        DistanceTravelled += SPEED 
    else: # move left
        position.x -= SPEED
        DistanceTravelled += SPEED 
    if (DistanceTravelled >= MaxDistanceToTravel):
        #time to go down the screen
        MovementDown = true
        DistanceTravelled = 0
        MovementRight = !MovementRight
        #increase movement speed
        SPEED += 0.01
        AnimationSpeed += SPEED
        $AnimatedSprite.frames.set_animation_speed("animate", AnimationSpeed)
    
func _on_Invader1_body_entered(body):
    $CollisionShape2D.disabled = true
    print("Invader has been hit!!")
    print(body)
    # hide animation    
    $AnimatedSprite.stop()
    $AnimatedSprite.visible = false  
    $Explosion.visible = true    
    $ExplosionSound.play()
    $ExplosionTimer.start()
    emit_signal("hit")

func _on_ExplosionTimer_timeout():
    # Hide the scene
    hide()
    #queue_free()

func _on_VisibilityNotifier2D_screen_entered():
    Attack = false
    # activate animation
    $AnimatedSprite.play()

# Called when game is over in order to hide any remaining invaders
func _disable_invader():
    Attack = false
    $CollisionShape2D.disabled = true # should not be needed, but just in case
    $AnimatedSprite.hide()

func _on_VisibilityNotifier2D_screen_exited():
    # game over
    emit_signal("enteringEarth")

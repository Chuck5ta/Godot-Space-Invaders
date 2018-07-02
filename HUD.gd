extends CanvasLayer

signal start_game

var GameOver = false

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    $ScoreLabel.hide()
    $MessageLabel.hide()
    $StartButton.hide()

func _process(delta):
    pass

func show_message(text, score):
    $ScoreLabel.text = str(score)
    $ScoreLabel.show()
    $MessageLabel.text = text
    $MessageLabel.show()
    $MessageTimer.start()
    
func show_game_over(score):
    # make sure this is not run more than once while Game Over
    if (!GameOver):
        GameOver = true
        show_message("Game Over", score)
        yield($MessageTimer, "timeout")
        $StartButton.show()
        $MessageLabel.text = "Space Invaders!"
        $MessageLabel.show()

func _on_MessageTimer_timeout():
    print("MESSAGE TIMER FIRED!!!!!")
    $MessageLabel.hide()   

func _on_StartButton_pressed():
    $StartButton.hide()
    emit_signal("start_game")
    GameOver = false
    print("FUCK YOU!!!!!")

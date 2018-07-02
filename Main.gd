extends Node

export (PackedScene) var LaserBolt
export (PackedScene) var InvaderLaserBolt01
#export (PackedScene) var LaserBolt
# Player related
var PlayerAlive = true
var LaserBoltExists = false
# Invader related 
var TotalRows = 5
var TotalInvadersPerRow = 11
var TotalInvaders = 55
var InvaderAliveStateMatrix = [] # stored row by column
var TotalInvaderLaserbolts = 0
var MaxInvaderLaserbolts = 2 # no more than 2 bolts can exist at any one time
# SCORING
var TotalScore = 0
var Invader1Score = 10
var Invader2Score = 20
var Invader3Score = 30
var MothershipScore = 100
var MothershipAlive = true
# Game Over
var GameOver = false


func _ready():
    # Called when the node is added to the scene for the first time.
    randomize()
    # Initialization here
    _initialise()   
    $InvaderSoundTimer.start() 
    $InvaderSoundSpeed.start() 

func _new_game():
    $HUD.show_message("Get Ready", 0)
    get_tree().reload_current_scene() 
    
func _game_over():
    if (TotalInvaders == 0 && !MothershipAlive):
        print ("Total Invaders = 0!!!!")
        GameOver = true
        return true
    if (GameOver == true): # set when the player is killed or the aliens break through
        if (MothershipAlive):
            $Mothership.disable_mothership() # we no longer want to see the Mothership
        return true
               

func _process(delta):
    if (!_game_over()):
        # fire LaserBolt when spacebar pressed
        if (PlayerAlive):
            if Input.is_action_pressed("ui_select") && LaserBoltExists == false:  
                LaserBoltExists = true
                $LaserBolt.position= $Player.position
                $LaserBolt.position.y -= 22 # position it just above the gun tip
                $LaserBolt.show()
                $LaserBolt.LaserBoltMoving = true
                $LaserBolt.EnableCollision()
                $LaserBoltSound.play()
            
        # INVADERS FIRING LASER (only 2 lasers allowed to exist)
        if (TotalInvaderLaserbolts == 0):
            var invaderFire = randi() % 100 # we don't want the invaders firing too often
            if (invaderFire < 25):
                var NoOfLaserToFire = randi() % 2
                # while (TotalInvaderLaserbolts != NoOfLaserToFire):
                _invaders_fire_laserbolts(NoOfLaserToFire+1) # fire 1 or 2 lasers
    else:           
        $InvaderSoundTimer.stop() 
        $InvaderSoundSpeed.stop() 
        $HUD.show_game_over(TotalScore)
        # clear remaining invaders
        if (TotalInvaders > 0):
            _clear_invaders()

#
# Game Start
# ===========

func _initialise():
    # set all invaders to alive
    for Row in range(TotalRows):
        InvaderAliveStateMatrix.append([])
        for Column in range(TotalInvadersPerRow):
            InvaderAliveStateMatrix[Row].append(true) ## show invader as being alive   
    #GameOver = false 


#
# INVADERS RELATED
# =================


# Invader has broken through to Earth
func _on_Invader_entering_earth():
    GameOver = true


# Called when the game is over
func _clear_invaders():
    #loop through Alive matrix to see who needs disabling
    # row 0
    if (InvaderAliveStateMatrix[0][0] == true):
        $Invader00._disable_invader()
    if (InvaderAliveStateMatrix[0][1] == true):
        $Invader01._disable_invader()
    if (InvaderAliveStateMatrix[0][2] == true):
        $Invader02._disable_invader()
    if (InvaderAliveStateMatrix[0][3] == true):
        $Invader03._disable_invader()
    if (InvaderAliveStateMatrix[0][4] == true):
        $Invader04._disable_invader()
    if (InvaderAliveStateMatrix[0][5] == true):
        $Invader05._disable_invader()
    if (InvaderAliveStateMatrix[0][6] == true):
        $Invader06._disable_invader()
    if (InvaderAliveStateMatrix[0][7] == true):
        $Invader07._disable_invader()
    if (InvaderAliveStateMatrix[0][8] == true):
        $Invader08._disable_invader()
    if (InvaderAliveStateMatrix[0][9] == true):
        $Invader09._disable_invader()
    if (InvaderAliveStateMatrix[0][10] == true):
        $Invader010._disable_invader()
    # row 1
    if (InvaderAliveStateMatrix[1][0] == true):
        $Invader10._disable_invader()
    if (InvaderAliveStateMatrix[1][1] == true):
        $Invader11._disable_invader()
    if (InvaderAliveStateMatrix[1][2] == true):
        $Invader12._disable_invader()
    if (InvaderAliveStateMatrix[1][3] == true):
        $Invader13._disable_invader()
    if (InvaderAliveStateMatrix[1][4] == true):
        $Invader14._disable_invader()
    if (InvaderAliveStateMatrix[1][5] == true):
        $Invader15._disable_invader()
    if (InvaderAliveStateMatrix[1][6] == true):
        $Invader16._disable_invader()
    if (InvaderAliveStateMatrix[1][7] == true):
        $Invader17._disable_invader()
    if (InvaderAliveStateMatrix[1][8] == true):
        $Invader18._disable_invader()
    if (InvaderAliveStateMatrix[1][9] == true):
        $Invader19._disable_invader()
    if (InvaderAliveStateMatrix[1][10] == true):
        $Invader110._disable_invader()
    # row 2
    if (InvaderAliveStateMatrix[2][0] == true):
        $Invader20._disable_invader()
    if (InvaderAliveStateMatrix[2][1] == true):
        $Invader21._disable_invader()
    if (InvaderAliveStateMatrix[2][2] == true):
        $Invader22._disable_invader()
    if (InvaderAliveStateMatrix[2][3] == true):
        $Invader23._disable_invader()
    if (InvaderAliveStateMatrix[2][4] == true):
        $Invader24._disable_invader()
    if (InvaderAliveStateMatrix[2][5] == true):
        $Invader25._disable_invader()
    if (InvaderAliveStateMatrix[2][6] == true):
        $Invader26._disable_invader()
    if (InvaderAliveStateMatrix[2][7] == true):
        $Invader27._disable_invader()
    if (InvaderAliveStateMatrix[2][8] == true):
        $Invader28._disable_invader()
    if (InvaderAliveStateMatrix[2][9] == true):
        $Invader29._disable_invader()
    if (InvaderAliveStateMatrix[2][10] == true):
        $Invader210._disable_invader()
    # row 3
    if (InvaderAliveStateMatrix[3][0] == true):
        $Invader30._disable_invader()
    if (InvaderAliveStateMatrix[3][1] == true):
        $Invader31._disable_invader()
    if (InvaderAliveStateMatrix[3][2] == true):
        $Invader32._disable_invader()
    if (InvaderAliveStateMatrix[3][3] == true):
        $Invader33._disable_invader()
    if (InvaderAliveStateMatrix[3][4] == true):
        $Invader34._disable_invader()
    if (InvaderAliveStateMatrix[3][5] == true):
        $Invader35._disable_invader()
    if (InvaderAliveStateMatrix[3][6] == true):
        $Invader36._disable_invader()
    if (InvaderAliveStateMatrix[3][7] == true):
        $Invader37._disable_invader()
    if (InvaderAliveStateMatrix[3][8] == true):
        $Invader38._disable_invader()
    if (InvaderAliveStateMatrix[3][9] == true):
        $Invader39._disable_invader()
    if (InvaderAliveStateMatrix[3][10] == true):
        $Invader310._disable_invader()
    # row 3
    if (InvaderAliveStateMatrix[4][0] == true):
        $Invader40._disable_invader()
    if (InvaderAliveStateMatrix[4][1] == true):
        $Invader41._disable_invader()
    if (InvaderAliveStateMatrix[4][2] == true):
        $Invader42._disable_invader()
    if (InvaderAliveStateMatrix[4][3] == true):
        $Invader43._disable_invader()
    if (InvaderAliveStateMatrix[4][4] == true):
        $Invader44._disable_invader()
    if (InvaderAliveStateMatrix[4][5] == true):
        $Invader45._disable_invader()
    if (InvaderAliveStateMatrix[4][6] == true):
        $Invader46._disable_invader()
    if (InvaderAliveStateMatrix[4][7] == true):
        $Invader47._disable_invader()
    if (InvaderAliveStateMatrix[4][8] == true):
        $Invader48._disable_invader()
    if (InvaderAliveStateMatrix[4][9] == true):
        $Invader49._disable_invader()
    if (InvaderAliveStateMatrix[4][10] == true):
        $Invader410._disable_invader()
        

# Top right of screen
func _update_total_score(NewScore):
    TotalScore += NewScore
    $TotalScore.text = str(TotalScore)

# Game Over UI (HUD scen)
func update_score(score):
    $ScoreLabel.text = str(score)
    
func _on_InvaderLaserBolt1_hiding():
    TotalInvaderLaserbolts -= 1    

func _on_InvaderLaserBolt2_hiding():
    TotalInvaderLaserbolts -= 1    

func _on_Mothership_hit():
    MothershipAlive = false
    _update_total_score(MothershipScore)    

func _invader_killed(Row, Column, InvaderScore):
    InvaderAliveStateMatrix[Row][Column] = false
    print("Invader at ", Row, " ", Column, " alive state is: ",  InvaderAliveStateMatrix[Row][Column])
    _update_total_score(InvaderScore)
    LaserBoltExists = false
    TotalInvaders -= 1 # Game Over when 0 invaders left    

func _invader_fire_laser(Invader):
    print("**** FIRE *****")
    if (TotalInvaderLaserbolts == 0):
        $InvaderLaserBolt1.position = Invader.position
        $InvaderLaserBolt1.position.y += 28 # position it just above the gun tip
        $InvaderLaserBolt1.show()        
        $InvaderLaserBolt1.LaserBoltMoving = true
        $InvaderLaserBolt1.EnableCollision()
    else:
        $InvaderLaserBolt2.position = Invader.position
        $InvaderLaserBolt2.position.y += 28 # position it just above the gun tip
        $InvaderLaserBolt2.show()
        $InvaderLaserBolt2.LaserBoltMoving = true
        $InvaderLaserBolt2.EnableCollision()
    TotalInvaderLaserbolts += 1
    #$InvaderLaserBolt01.LaserBoltMoving = true
    #$InvaderLaserBolt01.EnableCollision()
    # $LaserBoltSound.play()

func _get_invader(row, column):
    if (row == 0):
        if (column == 0):
            _invader_fire_laser($Invader00)
        elif (column == 1):
            _invader_fire_laser($Invader01)
        elif (column == 2):
            _invader_fire_laser($Invader02)
        elif (column == 3):
            _invader_fire_laser($Invader03)
        elif (column == 4):
            _invader_fire_laser($Invader04)
        elif (column == 5):
            _invader_fire_laser($Invader05)
        elif (column == 6):
            _invader_fire_laser($Invader06)
        elif (column == 7):
            _invader_fire_laser($Invader07)
        elif (column == 8):
            _invader_fire_laser($Invader08)
        elif (column == 9):
            _invader_fire_laser($Invader09)
        elif (column == 10):
            _invader_fire_laser($Invader010)
    if (row == 1):
        if (column == 0):
            _invader_fire_laser($Invader10)
        elif (column == 1):
            _invader_fire_laser($Invader11)
        elif (column == 2):
            _invader_fire_laser($Invader12)
        elif (column == 3):
            _invader_fire_laser($Invader13)
        elif (column == 4):
            _invader_fire_laser($Invader14)
        elif (column == 5):
            _invader_fire_laser($Invader15)
        elif (column == 6):
            _invader_fire_laser($Invader16)
        elif (column == 7):
            _invader_fire_laser($Invader17)
        elif (column == 8):
            _invader_fire_laser($Invader18)
        elif (column == 9):
            _invader_fire_laser($Invader19)
        elif (column == 10):
            _invader_fire_laser($Invader110)
    if (row == 2):        
        if (column == 0):
            _invader_fire_laser($Invader20)
        elif (column == 1):
            _invader_fire_laser($Invader21)
        elif (column == 2):
            _invader_fire_laser($Invader22)
        elif (column == 3):
            _invader_fire_laser($Invader23)
        elif (column == 4):
            _invader_fire_laser($Invader24)
        elif (column == 5):
            _invader_fire_laser($Invader25)
        elif (column == 6):
            _invader_fire_laser($Invader26)
        elif (column == 7):
            _invader_fire_laser($Invader27)
        elif (column == 8):
            _invader_fire_laser($Invader28)
        elif (column == 9):
            _invader_fire_laser($Invader29)
        elif (column == 10):
            _invader_fire_laser($Invader210)
    if (row == 3):        
        if (column == 0):
            _invader_fire_laser($Invader30)
        elif (column == 1):
            _invader_fire_laser($Invader31)
        elif (column == 2):
            _invader_fire_laser($Invader32)
        elif (column == 3):
            _invader_fire_laser($Invader33)
        elif (column == 4):
            _invader_fire_laser($Invader34)
        elif (column == 5):
            _invader_fire_laser($Invader35)
        elif (column == 6):
            _invader_fire_laser($Invader36)
        elif (column == 7):
            _invader_fire_laser($Invader37)
        elif (column == 8):
            _invader_fire_laser($Invader38)
        elif (column == 9):
            _invader_fire_laser($Invader39)
        elif (column == 10):
            _invader_fire_laser($Invader310)
    if (row == 4):        
        if (column == 0):
            _invader_fire_laser($Invader40)
        elif (column == 1):
            _invader_fire_laser($Invader41)
        elif (column == 2):
            _invader_fire_laser($Invader42)
        elif (column == 3):
            _invader_fire_laser($Invader43)
        elif (column == 4):
            _invader_fire_laser($Invader44)
        elif (column == 5):
            _invader_fire_laser($Invader45)
        elif (column == 6):
            _invader_fire_laser($Invader46)
        elif (column == 7):
            _invader_fire_laser($Invader47)
        elif (column == 8):
            _invader_fire_laser($Invader48)
        elif (column == 9):
            _invader_fire_laser($Invader49)
        elif (column == 10):
            _invader_fire_laser($Invader410)


func _invaders_fire_laserbolts(TotalLasersToFire):
    while (TotalInvaderLaserbolts != TotalLasersToFire):
        # pick an invader at random
        var InvaderToCheckRow = randi() % 5 # 0 to 4
        var InvaderToCheckColumn = randi() % 11 # 0 to 10
        while (InvaderAliveStateMatrix[InvaderToCheckRow][InvaderToCheckColumn] != true && TotalInvaders > 0):
            InvaderToCheckRow = randi() % 5 # 0 to 4
            InvaderToCheckColumn = randi() % 11 # 0 to 10
        
        if (TotalInvaders == 0):
            return
        
        # check if the invader has a clear view to fire (no invaders in the way)        
        # row 0 - check for invaders on rows 1, 2, 3 and 4
        # row 1 - check for invaders on rows 2, 3 and 4
        # row 2 - check for invaders on rows 3, and 4
        # row 3 - check for invaders on rows 4        
        if (InvaderToCheckRow == 4 && TotalInvaderLaserbolts < 2):
            # fire laser from this invader
            print("It can fire")
            _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 3 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false):
                # fire laser
                print("It can fire")
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 2 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
                print("It can fire")
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 1 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 2
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 3][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
                print("It can fire")
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 0 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 1
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false &&  # check row 2
                InvaderAliveStateMatrix[InvaderToCheckRow + 3][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 4][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
                print("It can fire")
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
                

# ROW 0
# ======

func _on_Invader00_hit():
    _invader_killed(0, 0, Invader3Score)
    print("Invader 0 0 DEAD!")

func _on_Invader01_hit():
    print("Invader 0 1 DEAD!")
    _invader_killed(0, 1, Invader3Score)

func _on_Invader02_hit():
    print("Invader 0 2 DEAD!")
    _invader_killed(0, 2, Invader3Score)

func _on_Invader03_hit():
    print("Invader 0 3 DEAD!")
    _invader_killed(0, 3, Invader3Score)

func _on_Invader04_hit():
    print("Invader 0 4 DEAD!")
    _invader_killed(0, 4, Invader3Score)

func _on_Invader05_hit():
    print("Invader 0 5 DEAD!")
    _invader_killed(0, 5, Invader3Score)

func _on_Invader06_hit():
    print("Invader 0 6 DEAD!")
    _invader_killed(0, 6, Invader3Score)

func _on_Invader07_hit():
    print("Invader 0 7 DEAD!")
    _invader_killed(0, 7, Invader3Score)

func _on_Invader08_hit():
    print("Invader 0 8 DEAD!")
    _invader_killed(0, 8, Invader3Score)

func _on_Invader09_hit():
    print("Invader 0 9 DEAD!")
    _invader_killed(0, 9, Invader3Score)

func _on_Invader010_hit():
    print("Invader 0 10 DEAD!")
    _invader_killed(0, 10, Invader3Score)

# ROW 1
# ======

func _on_Invader10_hit():
    _invader_killed(1, 0, Invader2Score)
    print("Invader 1 0 DEAD!")

func _on_Invader11_hit():
    print("Invader 1 1 DEAD!")
    _invader_killed(1, 1, Invader2Score)

func _on_Invader12_hit():
    print("Invader 1 2 DEAD!")
    _invader_killed(1, 2, Invader2Score)

func _on_Invader13_hit():
    print("Invader 1 3 DEAD!")
    _invader_killed(1, 3, Invader2Score)

func _on_Invader14_hit():
    print("Invader 1 4 DEAD!")
    _invader_killed(1, 4, Invader2Score)

func _on_Invader15_hit():
    print("Invader 1 5 DEAD!")
    _invader_killed(1, 5, Invader2Score)

func _on_Invader16_hit():
    print("Invader 1 6 DEAD!")
    _invader_killed(1, 6, Invader2Score)

func _on_Invader17_hit():
    print("Invader 1 7 DEAD!")
    _invader_killed(1, 7, Invader2Score)

func _on_Invader18_hit():
    print("Invader 1 8 DEAD!")
    _invader_killed(1, 8, Invader2Score)

func _on_Invader19_hit():
    print("Invader 1 9 DEAD!")
    _invader_killed(1, 9, Invader2Score)

func _on_Invader110_hit():
    print("Invader 1 10 DEAD!")
    _invader_killed(1, 10, Invader2Score)

# ROW 2
# ======

func _on_Invader20_hit():
    _invader_killed(2, 0, Invader2Score)
    print("Invader 2 0 DEAD!")

func _on_Invader21_hit():
    print("Invader 2 1 DEAD!")
    _invader_killed(2, 1, Invader2Score)

func _on_Invader22_hit():
    print("Invader 2 2 DEAD!")
    _invader_killed(2, 2, Invader2Score)

func _on_Invader23_hit():
    print("Invader 2 3 DEAD!")
    _invader_killed(2, 3, Invader2Score)

func _on_Invader24_hit():
    print("Invader 2 4 DEAD!")
    _invader_killed(2, 4, Invader2Score)

func _on_Invader25_hit():
    print("Invader 2 5 DEAD!")
    _invader_killed(2, 5, Invader2Score)

func _on_Invader26_hit():
    print("Invader 2 6 DEAD!")
    _invader_killed(2, 6, Invader2Score)

func _on_Invader27_hit():
    print("Invader 2 7 DEAD!")
    _invader_killed(2, 7, Invader2Score)

func _on_Invader28_hit():
    print("Invader 2 8 DEAD!")
    _invader_killed(2, 8, Invader2Score)

func _on_Invader29_hit():
    print("Invader 2 9 DEAD!")
    _invader_killed(2, 9, Invader2Score)

func _on_Invader210_hit():
    print("Invader 2 10 DEAD!")
    _invader_killed(2, 10, Invader2Score)


# ROW 3
# ======

func _on_Invader30_hit():
    _invader_killed(3, 0, Invader1Score)
    print("Invader 3 0 DEAD!")

func _on_Invader31_hit():
    print("Invader 3 1 DEAD!")
    _invader_killed(3, 1, Invader1Score)

func _on_Invader32_hit():
    print("Invader 3 2 DEAD!")
    _invader_killed(3, 2, Invader1Score)

func _on_Invader33_hit():
    print("Invader 3 3 DEAD!")
    _invader_killed(3, 3, Invader1Score)

func _on_Invader34_hit():
    print("Invader 3 4 DEAD!")
    _invader_killed(3, 4, Invader1Score)

func _on_Invader35_hit():
    print("Invader 3 5 DEAD!")
    _invader_killed(3, 5, Invader1Score)

func _on_Invader36_hit():
    print("Invader 3 6 DEAD!")
    _invader_killed(3, 6, Invader1Score)

func _on_Invader37_hit():
    print("Invader 3 7 DEAD!")
    _invader_killed(3, 7, Invader1Score)

func _on_Invader38_hit():
    print("Invader 3 8 DEAD!")
    _invader_killed(3, 8, Invader1Score)

func _on_Invader39_hit():
    print("Invader 3 9 DEAD!")
    _invader_killed(3, 9, Invader1Score)

func _on_Invader310_hit():
    print("Invader 3 10 DEAD!")
    _invader_killed(3, 10, Invader1Score)

# ROW 4
# ======
    
func _on_Invader40_hit():
    _invader_killed(4, 0, Invader1Score)
    print("Invader 4 0 DEAD!")

func _on_Invader41_hit():
    print("Invader 4 1 DEAD!")
    _invader_killed(4, 1, Invader1Score)

func _on_Invader42_hit():
    print("Invader 4 2 DEAD!")
    _invader_killed(4, 2, Invader1Score)

func _on_Invader43_hit():
    print("Invader 4 3 DEAD!")
    _invader_killed(4, 3, Invader1Score)

func _on_Invader44_hit():
    print("Invader 4 4 DEAD!")
    _invader_killed(4, 4, Invader1Score)

func _on_Invader45_hit():
    print("Invader 4 5 DEAD!")
    _invader_killed(4, 5, Invader1Score)

func _on_Invader46_hit():
    print("Invader 4 6 DEAD!")
    _invader_killed(4, 6, Invader1Score)

func _on_Invader47_hit():
    print("Invader 4 7 DEAD!")
    _invader_killed(4, 7, Invader1Score)

func _on_Invader48_hit():
    print("Invader 4 8 DEAD!")
    _invader_killed(4, 8, Invader1Score)

func _on_Invader49_hit():
    print("Invader 4 9 DEAD!")
    _invader_killed(4, 9, Invader1Score)

func _on_Invader410_hit():
    print("Invader 4 10 DEAD!")
    _invader_killed(4, 10, Invader1Score)



# PLAYER RELATED
# ===============

func _on_LaserBolt_hiding():
    LaserBoltExists = false  

func _on_Player_hit():
    PlayerAlive = false
    # Game Over
    GameOver = true
    
    

func _wait(WaitTime):
    var t = Timer.new()
    t.set_wait_time(WaitTime)
    t.set_one_shot(true)
    self.add_child(t)
    t.start()
    yield(t, "timeout")

func _on_InvaderSoundTimer_timeout():
    $InvaderMovementSound1.play()
    $InvaderMovementSound2.play()
    $InvaderMovementSound3.play()
    $InvaderMovementSound4.play()


func _on_InvaderSoundSpeed_timeout():
    $InvaderSoundTimer.wait_time = $InvaderSoundTimer.wait_time / 1.5

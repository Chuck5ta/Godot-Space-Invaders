extends Node

#onready var InvaderLaser = preload("res://InvaderLaserBolt.tscn")
#onready var InvaderLaser01 = get_node(InvaderLaserBolt1)
#onready var InvaderLaser02 = get_node(InvaderLaserBolt2)


# Player related
var PlayerAlive = true
var LaserBoltExists = false
var TotalPlayerLives = 3
# Invader related 
var TotalRows = 5
var TotalInvadersPerRow = 11
var TotalInvaders = 55
var TotalInvaderLaserbolts = 0
var MaxInvaderLaserbolts = 2 # no more than 2 bolts can exist at any one time
var InvaderAliveStateMatrix = [] # stored row by column
var MothershipAlive = true
# SCORING
var TotalScore = 0
var Invader1Score = 10
var Invader2Score = 20
var Invader3Score = 30
var MothershipScore = 100
# Game Over - Wave Killed
var GameOver = false
var WaveKilled = false
var WaveNumber = 1

var fireTest = true


func _ready():
    # Called when the node is added to the scene for the first time.
    randomize()
    # Initialization here
    _initialise() 
    _set_off_invaders()
    $InvaderSoundTimer.start() 
    $InvaderSoundSpeed.start() 

func _new_game():
    if (GameOver):  # Player dead or invaders have broken through 
        $HUD.show_message("Get Ready", TotalScore)     
        get_tree().reload_current_scene() 
    else: # continue to next wave
        print("***** NEW WAVE ******")
        WaveKilled = false
        PlayerAlive = true
        $HUD.show_message("Get Ready", TotalScore)
        WaveNumber += 1
        # Put Invaders back
        TotalInvaders = 55
        MothershipAlive = true
        $Mothership._reset_mothership_scene()
        $Player._reset_player_scene()
        _reset_invaders()
        $InvaderSoundTimer.wait_time = 1
        $InvaderSoundSpeed.wait_time = 10
        $InvaderSoundTimer.start() 
        $InvaderSoundSpeed.start() 
        
func _process(delta):
    if (TotalInvaders == 0):        
        $InvaderSoundTimer.stop()  
        $InvaderSoundSpeed.stop()         
    if (_wave_killed()):
        $HUD.show_next_wave(TotalScore, WaveNumber)
        return
    if (!_game_over()):
        # fire LaserBolt when spacebar pressed
        if (PlayerAlive):
            if Input.is_action_pressed("ui_select") && LaserBoltExists == false:  
                LaserBoltExists = true
                $LaserBolt.position= $Player.position
                $LaserBolt.position.y -= 22 # position it just above the gun tip
                $LaserBolt._reset_laserbolt()
                $LaserBoltSound.play()
            
  #      while (fireTest):
  #          _invader_fire_laser($Invader44)
  #          fireTest = false
        # INVAD
        
        if (TotalInvaderLaserbolts == 0):
            var invaderFire = randi() % 100 # we don't want the invaders firing too often        
            if (invaderFire < 25):                
                var NoOfLaserToFire = randi() % 2      
                _invaders_fire_laserbolts(NoOfLaserToFire+1) # fire 1 or 2 lasers
    else:           
        #$InvaderSoundTimer.stop() 
        #$InvaderSoundSpeed.stop()       
        $HUD.show_game_over(TotalScore)
        # clear remaining invaders
        if (TotalInvaders > 0):
            _clear_invaders()

 
func _game_over():
    if (GameOver == true): # set when the player is killed or the aliens break through
        if (MothershipAlive):
            $Mothership.disable_mothership() # we no longer want to see the Mothership
        return true
    return false
   
func _wave_killed():
    if (TotalInvaders == 0 && !MothershipAlive):
        print("----==== WAVE KILLED ====----")
        WaveKilled = true
        return true
    return false
    

# ============
# HUD related
# ============       

# Top right of screen
func _update_total_score(NewScore):
    TotalScore += NewScore
    $TotalScore.text = str(TotalScore)

# Game Over UI (HUD scen)
func update_score(score):
    $ScoreLabel.text = str(score)


# =================
# INVADERS RELATED
# =================

# Game Start
# -----------

func _initialise():
    # set all invaders to alive
    for Row in range(TotalRows):
        InvaderAliveStateMatrix.append([])
        for Column in range(TotalInvadersPerRow):
            InvaderAliveStateMatrix[Row].append(true) ## show invader as being alive   

# New Wave - after successfully destroying a wave of invaders
# ---------

func _reset_invaders():
    # set all invaders to alive
    for Row in range(TotalRows):
        for Column in range(TotalInvadersPerRow):
            InvaderAliveStateMatrix[Row][Column] = true ## show invader as being alive  
    # Row 0
    $Invader00._reset_invader_scene()
    $Invader01._reset_invader_scene()
    $Invader02._reset_invader_scene()
    $Invader03._reset_invader_scene()
    $Invader04._reset_invader_scene()
    $Invader05._reset_invader_scene()
    $Invader06._reset_invader_scene()
    $Invader07._reset_invader_scene()    
    $Invader08._reset_invader_scene()
    $Invader09._reset_invader_scene()
    $Invader010._reset_invader_scene()
    # Row 1
    $Invader10._reset_invader_scene()
    $Invader11._reset_invader_scene()
    $Invader12._reset_invader_scene()
    $Invader13._reset_invader_scene()
    $Invader14._reset_invader_scene()
    $Invader15._reset_invader_scene()
    $Invader16._reset_invader_scene()
    $Invader17._reset_invader_scene()    
    $Invader18._reset_invader_scene()
    $Invader19._reset_invader_scene()
    $Invader110._reset_invader_scene()
    # Row 2
    $Invader20._reset_invader_scene()
    $Invader21._reset_invader_scene()
    $Invader22._reset_invader_scene()
    $Invader23._reset_invader_scene()
    $Invader24._reset_invader_scene()
    $Invader25._reset_invader_scene()
    $Invader26._reset_invader_scene()
    $Invader27._reset_invader_scene()    
    $Invader28._reset_invader_scene()
    $Invader29._reset_invader_scene()
    $Invader210._reset_invader_scene()
    # Row 3
    $Invader30._reset_invader_scene()
    $Invader31._reset_invader_scene()
    $Invader32._reset_invader_scene()
    $Invader33._reset_invader_scene()
    $Invader34._reset_invader_scene()
    $Invader35._reset_invader_scene()
    $Invader36._reset_invader_scene()
    $Invader37._reset_invader_scene()    
    $Invader38._reset_invader_scene()
    $Invader39._reset_invader_scene()
    $Invader310._reset_invader_scene()
    # Row 4
    $Invader40._reset_invader_scene()
    $Invader41._reset_invader_scene()
    $Invader42._reset_invader_scene()
    $Invader43._reset_invader_scene()
    $Invader44._reset_invader_scene()
    $Invader45._reset_invader_scene()
    $Invader46._reset_invader_scene()
    $Invader47._reset_invader_scene()    
    $Invader48._reset_invader_scene()
    $Invader49._reset_invader_scene()
    $Invader410._reset_invader_scene()

# Called when the game is over
# this is required in order to hide the invaders while the Game Over/new game (HUD) screen is up
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

# Invader laser bolt
# -------------------   
    
func _on_InvaderLaserBolt1_hit(area, LaserPosition):
    TotalInvaderLaserbolts -= 1  
    if (TotalInvaderLaserbolts < 0):
        TotalInvaderLaserbolts = 0
    # did we hit a barrier?
    if area.get_name() == "Barrier1":
        # pass coords to the barrier
        $Barrier1.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier2":
        $Barrier2.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier3":
        $Barrier3.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier4":
        $Barrier4.blast_away_pixels(LaserPosition)
    

func _on_InvaderLaserBolt2_hit(area, LaserPosition):
    TotalInvaderLaserbolts -= 1 
    if (TotalInvaderLaserbolts < 0):
        TotalInvaderLaserbolts = 0   
    # did we hit a barrier?
    if area.get_name() == "Barrier1":
        $Barrier1.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier2":
        $Barrier2.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier3":
        $Barrier3.blast_away_pixels(LaserPosition)
    elif area.get_name() == "Barrier4":
        $Barrier4.blast_away_pixels(LaserPosition)

func _on_InvaderLaserBolt_hiding():
    TotalInvaderLaserbolts -= 1 
    if (TotalInvaderLaserbolts < 0):
        TotalInvaderLaserbolts = 0   

func _invader_killed(Row, Column, InvaderScore):
    InvaderAliveStateMatrix[Row][Column] = false
    _update_total_score(InvaderScore)
    LaserBoltExists = false
    TotalInvaders -= 1 # Game Over when 0 invaders left (+ mothership dead)    


func _invader_fire_laser(Invader):
    if (!$InvaderLaserBolt1.LaserBoltMoving):
        $InvaderLaserBolt1.position = Invader.position
        $InvaderLaserBolt1.position.y += 50 # position it just below the invader
        $InvaderLaserBolt1._reset_laserbolt()
    elif (!$InvaderLaserBolt2.LaserBoltMoving):
        $InvaderLaserBolt2.position = Invader.position
        $InvaderLaserBolt2.position.y += 50 # position it just below the invader
        $InvaderLaserBolt2._reset_laserbolt()
    TotalInvaderLaserbolts += 1





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
            _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 3 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false):
                # fire laser
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 2 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 1 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 2
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 3][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
                _get_invader(InvaderToCheckRow, InvaderToCheckColumn)
        elif (InvaderToCheckRow == 0 && TotalInvaderLaserbolts < 2):
            # make sure an invader is not in front of it
            if (InvaderAliveStateMatrix[InvaderToCheckRow + 1][InvaderToCheckColumn] == false &&  # check row 1
                InvaderAliveStateMatrix[InvaderToCheckRow + 2][InvaderToCheckColumn] == false &&  # check row 2
                InvaderAliveStateMatrix[InvaderToCheckRow + 3][InvaderToCheckColumn] == false &&  # check row 3
                InvaderAliveStateMatrix[InvaderToCheckRow + 4][InvaderToCheckColumn] == false):   # check row 4
                # fire laser
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
 
#
# Invader movement sound - TODO needs fixing!!!
# ----------------------------------------------

# Invader has broken through to Earth
func _on_Invader_entering_earth():
    GameOver = true
   
# TODO - lose this! 
func _wait():
    var t = Timer.new()
    t.set_wait_time($InvaderSoundTimer.wait_time)
    t.set_one_shot(true)
    self.add_child(t)
    t.start()
    yield(t, "timeout")

func _on_InvaderSoundSpeed_timeout():
    $InvaderSoundTimer.wait_time = $InvaderSoundTimer.wait_time / 1.1

func _on_InvaderSoundTimer_timeout():
    $InvaderMovementSound1.play()
    _wait()
    $InvaderMovementSound2.play()
    _wait()
    $InvaderMovementSound3.play()
    _wait()
    $InvaderMovementSound4.play()
    _wait()

func _set_off_invaders():
    $Line4InvaderStartTimer.start()  
    $Line3InvaderStartTimer.start()  
    $Line2InvaderStartTimer.start()  
    $Line1InvaderStartTimer.start()  
    $Line0InvaderStartTimer.start() 

func _on_Line4InvaderStartTimer_timeout():
    # Activate line 4 invaders  
    $Invader40.Attack = true
    $Invader41.Attack = true
    $Invader42.Attack = true
    $Invader43.Attack = true
    $Invader44.Attack = true
    $Invader45.Attack = true
    $Invader46.Attack = true
    $Invader47.Attack = true
    $Invader48.Attack = true
    $Invader49.Attack = true
    $Invader410.Attack = true

func _on_Line3InvaderStartTimer_timeout():
    # Activate line 3 invaders    
    $Invader30.Attack = true
    $Invader31.Attack = true
    $Invader32.Attack = true
    $Invader33.Attack = true
    $Invader34.Attack = true
    $Invader35.Attack = true
    $Invader36.Attack = true
    $Invader37.Attack = true
    $Invader38.Attack = true
    $Invader39.Attack = true
    $Invader310.Attack = true
    
func _on_Line2InvaderStartTimer_timeout():
    # Activate line 2 invaders  
    $Invader20.Attack = true
    $Invader21.Attack = true
    $Invader22.Attack = true
    $Invader23.Attack = true
    $Invader24.Attack = true
    $Invader25.Attack = true
    $Invader26.Attack = true
    $Invader27.Attack = true
    $Invader28.Attack = true
    $Invader29.Attack = true
    $Invader210.Attack = true

func _on_Line1InvaderStartTimer_timeout():    
    # Activate line 1 invaders  
    $Invader10.Attack = true   
    $Invader11.Attack = true
    $Invader12.Attack = true
    $Invader13.Attack = true
    $Invader14.Attack = true
    $Invader15.Attack = true
    $Invader16.Attack = true
    $Invader17.Attack = true
    $Invader18.Attack = true
    $Invader19.Attack = true
    $Invader110.Attack = true

func _on_Line0InvaderStartTimer_timeout():
    # Activate line 0 invaders  
    $Invader00.Attack = true
    $Invader01.Attack = true
    $Invader02.Attack = true
    $Invader03.Attack = true
    $Invader04.Attack = true
    $Invader05.Attack = true
    $Invader06.Attack = true
    $Invader07.Attack = true
    $Invader08.Attack = true
    $Invader09.Attack = true
    $Invader010.Attack = true


# Mothership related
# ===================

func _on_Mothership_hit():
    print("Mothership killed!!!!")
    MothershipAlive = false
    _update_total_score(MothershipScore)    


# PLAYER RELATED
# ===============

# this allows for a new bolt to be fired
func _on_LaserBolt_hiding(): 
    LaserBoltExists = false  

func _on_Player_hit():
    TotalPlayerLives -= 1
    if (TotalPlayerLives == 2):
        # remove 2nd player life image (bottom left of screen)
        $PlayerLife2.hide()
    elif (TotalPlayerLives == 1):
        $PlayerLife.hide()
    if (TotalPlayerLives == 0):
        PlayerAlive = false
        # Game Over
        GameOver = true
    else: # reset player
        $Player._reset_player_scene()


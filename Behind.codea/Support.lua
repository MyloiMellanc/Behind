

ROTATE = {}

ROTATE.LEFT = 2
ROTATE.RIGHT = -2



SUPPORT = {}

--Gunner

SUPPORT.GUNNER_SPRITE = 
        {"Space Art:Green Ship", 
         "Space Art:Red Ship"}

SUPPORT.GUNNER_RADIUS = 35

SUPPORT.GUNNER_POSITION = 
        {vec2(WIDTH / 2, HEIGHT / 2 + 60), vec2(WIDTH / 2, HEIGHT / 2 - 60)}

SUPPORT.GUNNER_LOOKAT = 
        {vec2(0, 1), vec2(0, 1)}

SUPPORT.GUNNER_ROTATION = 
        {0,
         180}

SUPPORT.GUNNER_COLOR = 
        {color(255, 0, 0, 255)  , color(255, 255, 0, 255)}


SUPPORT.FIRE_DELAY = 0.5


--Controller

SUPPORT.CONTROL_LEFT = 
        {vec2(WIDTH / 4, HEIGHT / 4), vec2(WIDTH / 4 * 3, HEIGHT / 4 * 3)}
SUPPORT.CONTROL_RIGHT = 
        {vec2(WIDTH / 4 * 3, HEIGHT / 4), vec2(WIDTH / 4, HEIGHT / 4 * 3)}


--Ragnaros
SUPPORT.BASE_VECTOR = {vec2(0,1), vec2(0, -1)}
SUPPORT.BASE_DISTANCE = HEIGHT * 0.7
SUPPORT.METEOR_ANGLE_MIN = -65
SUPPORT.METEOR_ANGLE_MAX = 65

SUPPORT.LAUNCH_DELAY = 3


--Meteor
SUPPORT.METEOR_SPEED_MIN = 0.5
SUPPORT.METEOR_SPEED_MAX = 1
SUPPORT.METEOR_SPRITE = 
        {"Tyrian Remastered:Rock 2", 
         "Tyrian Remastered:Rock 3", 
         "Tyrian Remastered:Rock 5"}

SUPPORT.METEOR_RADIUS = 
        {18,
         27,
         50}




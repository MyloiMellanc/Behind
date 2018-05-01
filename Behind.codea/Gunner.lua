

Gunner = class()


function Gunner:init(player, bullet_table)
    self.player = player
    self.sprite = SUPPORT.GUNNER_SPRITE[self.player]
    self.bullet_table = bullet_table
    
    
    self.position = SUPPORT.GUNNER_POSITION[player]
    self.lookat = SUPPORT.GUNNER_LOOKAT[player]
    self.rotation = SUPPORT.GUNNER_ROTATION[player]
    
    
    self.color = SUPPORT.GUNNER_COLOR[player]   
    self.radius = SUPPORT.GUNNER_RADIUS
    
    self.fire_delay = SUPPORT.FIRE_DELAY
    self.current_delay = 0
    
    self.toggle_available_fire = true
    self.toggle_dead = false
end


function Gunner:rotateLookat(rotation)
    self.rotation = (self.rotation + rotation) % 360
end

function Gunner:update(toggle_warning)
    self.current_delay = self.current_delay - DeltaTime
    
    if toggle_warning == true then
        self.toggle_available_fire = false
    else
        self.toggle_available_fire = true
    end
end

function Gunner:draw()

    
    pushMatrix()
    pushStyle()
   
    translate(self.position.x, self.position.y)   
    rotate(self.rotation) 
    
    --body
    sprite(self.sprite, 0, 0)
    
    --lookat
    if self.toggle_available_fire == true then
        stroke(93, 93, 93, 255)
        local lookat = self.lookat * 250
        strokeWidth(1)
        line(0, 0, lookat.x, lookat.y)
    end
   
    --[[ 
    lookat = lookat * 5
    
    stroke(255, 231, 0, 61)
    local lookat_left = lookat:rotate(math.rad(-35))
    local lookat_right = lookat:rotate(math.rad(35))
    line(0,0,lookat_left.x,lookat_left.y)
    line(0,0,lookat_right.x,lookat_right.y)
    ]]--
       
    --fill(255, 0, 0, 255)
    --text(self.rotation,0,0)

    popStyle()
    popMatrix()
end


function Gunner:getLookat()
    return self.lookat:rotate(math.rad(self.rotation))
end


function Gunner:fireBullet()
    if (self.current_delay <= 0) and (self.toggle_available_fire == true) then
        local current_lookat = self.lookat:rotate(math.rad(self.rotation))
        
        local position = self.position + current_lookat
        local bullet = Bullet(self.player, position, current_lookat)
        table.insert(self.bullet_table, bullet)
        self.current_delay = self.fire_delay
    end
end


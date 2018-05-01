

Bullet = class()


function Bullet:init(player, position, lookat)
    self.player = player
    self.position = vec2(position.x, position.y)
    self.direction = vec2(lookat.x, lookat.y)
    
    self.toggle_remove = false
end


function Bullet:update()
    self.position = self.position + self.direction * 7
    
    if self:isInScreen() == false then
        self.toggle_remove = true
    end
end


function Bullet:isInScreen()
    if ((self.position.y > 0) and (self.position.y < HEIGHT)) then
        if ((self.position.x > 0) and (self.position.x < WIDTH)) then
            return true
        end
    end
    
    return false
end


function Bullet:draw()
    pushStyle()
    
    stroke(236, 0, 255, 255)
    strokeWidth(5)
    local pos2 = self.position - self.direction * 15
    line(self.position.x, self.position.y, pos2.x, pos2.y)
    
    popStyle()
end





Meteor = class()

--메테오는 크기별로 총 3가지의 종류를 가진다.
--각각 스프라이트, 반지름, 속도(무작위)가 다르다.

function Meteor:init(player, meteor_type, position, direction)
    self.player = player
    self.sprite = SUPPORT.METEOR_SPRITE[meteor_type]
    self.radius = SUPPORT.METEOR_RADIUS[meteor_type]
    
    self.position = position
    self.direction = direction
    
    
    self.rotation = 0
    self.rotation_speed = self.radius / 10

    self.toggle_remove = false
end


function Meteor:update()
    self.position = self.position + self.direction * 0.7
    self.rotation = self.rotation + self.rotation_speed
end


function Meteor:draw()
    --빙글빙글 돌면서 떨어진다.
    pushMatrix()
    pushStyle()
       
    translate(self.position.x, self.position.y)
    rotate(self.rotation)
    scale(1.5)
    
    sprite(self.sprite, 0, 0)
    
    popStyle()
    popMatrix()
 
end


function Meteor:touched(touch)
    --not used
end

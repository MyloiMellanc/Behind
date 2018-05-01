

Ragnaros = class()


function Ragnaros:init(player, meteor_table)
    self.player = player
    self.meteor_table = meteor_table
    
    self.angle_min = SUPPORT.METEOR_ANGLE_MIN
    self.angle_max = SUPPORT.METEOR_ANGLE_MAX
    
    self.base_vector = SUPPORT.BASE_VECTOR[self.player]
    self.base_distance = SUPPORT.BASE_DISTANCE
    
    self.launch_delay = SUPPORT.LAUNCH_DELAY
    self.current_delay = self.launch_delay
    
end



function Ragnaros:update()
    --딜레이 줄이고, 메테오 생성해서 테이블에 넣기
    self.current_delay = self.current_delay - DeltaTime
    
    if self.current_delay <= 0 then
        self:createMeteor()
        self.current_delay = self.launch_delay
    end
    
end



function Ragnaros:createMeteor()
    --메테오를 만들어, 테이블에 삽입한다.
    local angle = math.random(self.angle_min, self.angle_max)
    local set_direction = self.base_vector:rotate(math.rad(angle))
    set_direction = set_direction * self.base_distance
    
    local gunner_position = SUPPORT.GUNNER_POSITION[self.player]
    local meteor_position = gunner_position + set_direction
    
    
    local meteor_direction = (gunner_position - meteor_position):normalize()
    local meteor_type = math.random(1, 3)
    
    local meteor = Meteor(self.player, meteor_type, 
                                    meteor_position, meteor_direction)
    
    table.insert(self.meteor_table, meteor)
end



function Ragnaros:draw()
    --not used
end


function Ragnaros:touched(touch)
    --not used
end

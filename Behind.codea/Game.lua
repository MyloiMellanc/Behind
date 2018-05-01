

Game = class()


function Game:init()
    self.gunner_table = {}
    self.controller_table = {}
    self.ragnaros_table = {}
    
    self.bullet_table = {}
    self.meteor_table = {}

    
    self.toggle_warning = false
    
    self:initGame()
end


function Game:initGame()
    
    for player = 1, 2 do
        --create gunner
        local gunner = Gunner(player, self.bullet_table)
        table.insert(self.gunner_table, gunner)

        --create controller
        --해당 플레이어에 해당하는 거너 참조함
        local controller = Controller(player, self.gunner_table[player])
        table.insert(self.controller_table, controller)
        
        --create ragnaros
        local ragnaros = Ragnaros(player, self.meteor_table)
        table.insert(self.ragnaros_table, ragnaros)
        
    end
end


function Game:touched(touch_table)
    --컨테이너 토글 설정하기
    for k,v in pairs(self.controller_table) do
        v:touched(touch_table)
    end
end


function Game:update()
    --각도 계산 후 좁으면 공격불가
    self:checkToggleWarning()
    
    --update fire delay of gunner
    for k,v in pairs(self.gunner_table) do
        v:update(self.toggle_warning)
    end
    
    
    --컨트롤러 토글에 대한 업데이트
    for k,v in pairs(self.controller_table) do
        v:update()
    end
    
    --update ragnaros table
    for k,v in pairs(self.ragnaros_table) do
        v:update()
    end
    
        
    --update bullet table
    for k,v in pairs(self.bullet_table) do
        v:update()
        --총알별 운석충돌판단
        self:checkBulletCollision(v)
    end
    
    --update meteor table 
    for k,v in pairs(self.meteor_table) do
        v:update()
    end
    
    self:checkGunnerCollision()
    
    self:deleteAllDeadObject()
    
    self:checkGameOver()
end


function Game:checkToggleWarning()
    local player_1_rotation = self.gunner_table[1].rotation
    local player_2_rotation = self.gunner_table[2].rotation
    
    if (90 < player_1_rotation) and (player_1_rotation < 270) then
        if (270 < player_2_rotation) or (player_2_rotation < 90) then
            self.toggle_warning = true
        else
            self.toggle_warning = false
        end
    else
        self.toggle_warning = false
    end
end


function Game:checkBulletCollision(bullet)
    --각각의 총알마다 거너,운석간의 충돌 파악
    --총알 업데이트 후 실행
    local bullet_position = bullet.position
    for k,v in pairs(self.meteor_table) do
        if bullet_position:dist(v.position) < v.radius then
            self:MeteorDestroy(v.player)
            v.toggle_remove = true
            bullet.toggle_remove = true
        end
    end
    
    for k,v in pairs(self.gunner_table) do
        if  (bullet.player ~= v.player) and
            (bullet_position:dist(v.position) < v.radius) then
            v.sprite = "Tyrian Remastered:Explosion Huge"
            v.toggle_dead = true
            bullet.toggle_remove = true
        end
    end
end


function Game:checkGunnerCollision()
    --거너가 메테오에 맞을경우
    for player,gunner in pairs(self.gunner_table) do
        for k, meteor in pairs(self.meteor_table) do
            if gunner.position:dist(meteor.position) < meteor.radius then
                gunner.sprite = "Tyrian Remastered:Explosion Huge"
                gunner.toggle_dead = true
                meteor.toggle_remove = true
            end
        end
    end
end


function Game:checkGameOver()
    for k,v in pairs(self.gunner_table) do
        if v.toggle_dead == true then
            is_gameover = true
        end
    end
end


--체크된 오브젝트들을 일괄제거하는 함수
--혹시 루프가 넘어가도 다음 프래임 때 지워지므로 상관없음
function Game:deleteAllDeadObject()
    for k,v in pairs(self.bullet_table) do
        if v.toggle_remove == true then
            table.remove(self.bullet_table, k)
        end
    end
    
    for k,v in pairs(self.meteor_table) do
        if v.toggle_remove == true then
            table.remove(self.meteor_table, k)
        end
    end
end

function Game:MeteorDestroy(player)
    if player == 1 then
        self.ragnaros_table[2]:createMeteor()
    elseif player == 2 then
        self.ragnaros_table[1]:createMeteor()
    end
end



function Game:draw()
    --warning zone
    self:drawWarningZone()
    
    
    --gunner
    for k,v in pairs(self.gunner_table) do
        v:draw()
    end
    
    --controller
    --지금은 아무것도 안그림
    for k,v in pairs(self.controller_table) do
        v:draw()
    end
    
    --ragnaros
    --지금은 안그림
    
    
    --bullet
    for k,v in pairs(self.bullet_table) do
        v:draw()
    end
    
    --meteor
    for k,v in pairs(self.meteor_table) do
        v:draw()
    end
    
end


function Game:drawWarningZone()
    pushMatrix()
    pushStyle()
    
    if self.toggle_warning == true then
        fill(255, 84, 0, 43)
        rect(0, self.gunner_table[2].position.y,WIDTH, 
            self.gunner_table[1].position.y - self.gunner_table[2].position.y)
        
        fill(255, 0, 0, 255)
        fontSize(30)
        text("WARNING!", 200, HEIGHT / 2)
        text("WARNING!", WIDTH - 200, HEIGHT / 2)
    else
        stroke(60, 60, 60, 255)
        strokeWidth(1)
        line(0, self.gunner_table[1].position.y, 
            WIDTH, self.gunner_table[1].position.y)
        line(0, self.gunner_table[2].position.y, 
            WIDTH, self.gunner_table[2].position.y)
            
        line(WIDTH/2, HEIGHT, WIDTH/2, HEIGHT - 150)
        line(WIDTH/2, 0, WIDTH/2, 150)
        
        fill(255, 0, 0, 255)
        text("WARNING ZONE", WIDTH / 2, HEIGHT / 2)
    end
    popStyle()
    popMatrix()
end



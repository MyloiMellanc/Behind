

Controller = class()


function Controller:init(player, gunner)
    self.player = player
    self.gunner = gunner
    
    self.left = SUPPORT.CONTROL_LEFT[player]
    self.right = SUPPORT.CONTROL_RIGHT[player]
    
    self.toggle_left = false
    self.toggle_right = false
end


function Controller:update()
    --토글상태에 따라 담당하는 거너를 조종
    if ((self.toggle_left == true) and (self.toggle_right == true)) then
        self.gunner:fireBullet()
    elseif self.toggle_left == true then
        self.gunner:rotateLookat(ROTATE.LEFT)
    elseif self.toggle_right == true then
        self.gunner:rotateLookat(ROTATE.RIGHT)
    end
end


function Controller:draw()
    
end


function Controller:touched(touch_table)
    --토글 전부 false로 초기화
    self:resetToggle()
    
    --해당 컨트롤러 구간에 있는 터치 만 토글체킹하기
    for k,v in pairs(touch_table) do
        if self:checkAvailableTouch(v) == true then
            self:setToggleByTouch(v)
        end
    end
end


function Controller:resetToggle()
    self.toggle_left = false
    self.toggle_right = false
end


--자신의 컨트롤러 범위에 들어왔는지 확인
function Controller:checkAvailableTouch(touch)
    if self.player == 1 then
        if touch.y < HEIGHT/2 then
            return true
        end
    elseif self.player == 2 then
        if touch.y > HEIGHT/2 then
            return true
        end
    end
    
    return false
end


--왼쪽 오른쪽 확인 후 토글
function Controller:setToggleByTouch(touch)
    local dist_x = math.abs(touch.x - self.left.x)
    local dist_y = math.abs(touch.y - self.left.y)
    local dist_left = (dist_x^2) + (dist_y^2)
    
    dist_x = math.abs(touch.x - self.right.x)
    dist_y = math.abs(touch.y - self.right.y)
    local dist_right = (dist_x^2) + (dist_y^2)
    
    if dist_left < dist_right then
        self.toggle_left = true
    elseif dist_left > dist_right then
        self.toggle_right = true
    end
end

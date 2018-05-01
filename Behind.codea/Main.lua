

function setup()
    displayMode(FULLSCREEN)
    ellipseMode(RADIUS)
    game = Game()
    
    touch_table = {}
    
    
    is_gameover = false
    toggle_count = 0
end


function update()
    game:touched(touch_table)
    
    game:update()
end

function draw()
    if is_gameover == false then
        update()
    end
    
    background(0, 0, 0, 255)
    --drawLength()
    game:draw()
    

end


function touched(touch)  
    if touch.state == ENDED then
        touch_table[touch.id] = nil
    else
        touch_table[touch.id] = touch
    end
end





function drawLength()
        local y = 30
        local x = 50
        
        while x < WIDTH do
            fontSize(10)
            fill(127, 127, 127, 255)
            text(x, x,y)
            
            x = x + 50
        end
        
        
        y = 50
        
        while y < HEIGHT do
            
            fontSize(10)
            fill(127, 127, 127, 255)
            text(y, 10, y)
            
            y = y + 50
        end
end
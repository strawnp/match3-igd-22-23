

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local highScore = false
        local scoreIndex = 11
    
        for i = 10, 1, -1 do
          local score = self.highScores[i].score or 0
          if self.score > score then
            highScoreIndex = i
            highScore = true
          end
        end
    
        if highScore then
          gSounds['victory']:play()
          gStateMachine:change('enter-high-score', {
            highScores = self.highScores,
            score = self.score,
            scoreIndex = highScoreIndex
          })
        else
          gStateMachine:change('start', {
            highScores = self.highScores
          })
        end
      end
    
    if love.keyboard.wasPressed('escape') then
    love.event.quit()
    end
end
function GameOverState:render()
    love.graphics.setFont(gFonts['large'])

    love.graphics.setColor(56/255, 56/255, 56/255, 234/255)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 64, 64, 128, 136, 4)

    love.graphics.setColor(99/255, 155/255, 255/255, 255/255)
    love.graphics.printf('GAME OVER', VIRTUAL_WIDTH / 2 - 64, 64, 128, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Your Score: ' .. tostring(self.score), VIRTUAL_WIDTH / 2 - 64, 140, 128, 'center')
    love.graphics.printf('Press Enter', VIRTUAL_WIDTH / 2 - 64, 180, 128, 'center')
end
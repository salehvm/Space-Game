//
//  MenuScene.swift
//  SpaceGame
//
//  Created by Saleh Majıdov on 7/13/18.
//  Copyright © 2018 Saleh Majıdov. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    var starfield: SKEmitterNode!
    var newGameButtonNode: SKSpriteNode!
    var difficultyButtonNode: SKSpriteNode!
    var difficultyLabelNode: SKLabelNode!
    
    override func didMove(to view: SKView) {
        starfield = self.childNode(withName: "starfield") as! SKEmitterNode
        starfield.advanceSimulationTime(10)
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as! SKSpriteNode
        difficultyButtonNode = self.childNode(withName: "diffucultyButton") as! SKSpriteNode
        
        difficultyButtonNode.texture = SKTexture(imageNamed: "diffucultyButton")
        difficultyLabelNode = self.childNode(withName: "difucultyLabel") as! SKLabelNode
        
        
        let userDefaults = UserDefaults.standard
        
        if userDefaults.bool(forKey: "hard") {
            difficultyLabelNode.text = "Hard"
        } else {
            difficultyLabelNode.text = "Easy"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "newGameButton" {
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let gameScene = GameScene(size: self.size)
                self.view?.presentScene(gameScene, transition: transition)
                
            }
            else if nodeArray.first?.name == "diffucultyButton"{
                changeDifficulty()
            }
        }
    }
    
    func changeDifficulty() {
        let userDefaults = UserDefaults.standard
        
        if difficultyLabelNode.text == "Easy" {
            difficultyLabelNode.text = "Hard"
            userDefaults.set(true, forKey: "hard")
        }
        else {
            difficultyLabelNode.text = "Easy"
            userDefaults.set(false, forKey: "hard")
        }
        userDefaults.synchronize()
    }
    
}

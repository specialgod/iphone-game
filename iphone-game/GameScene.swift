//
//  GameScene.swift
//  iphone-game
//
//  Created by 高橋　音穏 on 2018/03/06.
//  Copyright © 2018年 mesuki. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let tileMap = JSTileMap(named: "map.tmx")
    
    private var myLocation = CGPoint(x: 0, y: 0)
    private var x:CGFloat = 0
    private var y:CGFloat = 0
    
    private var player:SKSpriteNode?
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        
        if let map = tileMap {
            y =  self.frame.midY/2
            map.position = CGPoint(x: x, y: y)
            self.addChild(map)
            self.backgroundColor = SKColor(displayP3Red: 0.4, green: 0.7, blue: 0.95, alpha: 1.0)
        }
        
//        let player = SKSpriteNode(imageNamed: "player")
//        self.addChild(player)
//        player.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        player.zPosition = 100
//        self.player = player
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        myLocation = CGPoint(x: x, y: y)
        tileMap?.position = myLocation
        
        x = x - 3
    }
}

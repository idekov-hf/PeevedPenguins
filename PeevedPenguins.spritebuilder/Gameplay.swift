//
//  Gameplay.swift
//  PeevedPenguins
//
//  Created by Iavor Dekov on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Gameplay: CCNode {
   
    // member variables; code connections
    weak var gamePhysicsNode: CCPhysicsNode!
    weak var catapultArm: CCNode!
    weak var levelNode: CCNode!
    weak var contentNode: CCNode!
    
    // called when CCB file has completed loading
    func didLoadFromCCB() {
        userInteractionEnabled = true
        let level = CCBReader.load("Levels/Level1")
        levelNode.addChild(level)
    }
    
    func back() {
        let mainMenu = CCBReader.loadAsScene("MainScene")
        CCDirector.sharedDirector().presentScene(mainMenu)
    }
    
    func retry() {
        let gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().presentScene(gameplayScene)
    }
    
    // called on every touch in this scene
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        launchPenguin()
    }
    
    func launchPenguin() {
        // loads the Penguin.ccb we have set up in the SpriteBuilder
        let penguin = CCBReader.load("Penguin") as! Penguin
        
        // position the penguin at the bowl of the catapult
        penguin.position = ccpAdd(catapultArm.position, CGPoint(x: 16, y: 50))
        
        // add the penguin to the gamePhysicsNode (because the penguin has physics enabled)
        gamePhysicsNode.addChild(penguin)
        
        // manually create and apply a force to launch the penguin
        let launchDirection = CGPoint(x: 1, y: 0)
        let force = ccpMult(launchDirection, 8000)
        penguin.physicsBody.applyForce(force)
        
        // ensure followed object is in visible area when starting
        position = CGPoint.zeroPoint
        let actionFollow = CCActionFollow(target: penguin, worldBoundary: boundingBox())
        contentNode.runAction(actionFollow)
        
    }
    
}

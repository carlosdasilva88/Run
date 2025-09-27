//
//  main.swift
//  Run
//
//  Created by Carlos Silva on 27/09/25.
//

import Foundation

let scenario = 50
var actionPlayer: Int = 0

class Player {
    var position: Int
    var shape: String
    
    init(position: Int, shape: String) {
        self.position = position
        self.shape = shape
    }
    
    func draw() {
        print(String(repeating: " ", count: position) + self.shape)
    }
    
    func move(position: Int) {
        self.position = position
    }
}

class Runner : Player {
}

class Obstacle : Player {

    func generete() -> (Bool, Int, String) {
        let isGenerated = Bool.random()
        let obstacleOrientation = isGenerated ? Bool.random() ? 1 : -1 : 0
        return (isGenerated, obstacleOrientation, self.shape)
    }
}

struct Scenario {
    func draw(runner: Player, obstacle: (Bool, Int, String)) {
        let (isGenerated, _, shape) = obstacle
        let obstacleShape = isGenerated ? shape : " "
        print(String(repeating: " ", count: runner.position) + runner.shape + " " + obstacleShape)
    }
}

func update(player: Player, obstacleSettings: (Bool, Int, String)) {
    let (generatedAnObstacle, obstacleOrientation, _) = obstacleSettings
    
    if generatedAnObstacle {
        
        repeat {
            print("[1] para pular \n[-1] para se abaixar \n")
            let action = readLine()
            actionPlayer = Int(action ?? "0") ?? 0
        }while !(actionPlayer == 1 || actionPlayer == -1)
                
        checkeCollision(obstacleOrientation, actionPlayer)
    }

    if player.position == scenario {
        player.move(position: 0)
    }
    
    player.move(position: player.position + 1)
}

func checkeCollision(_ obstacleOrientation: Int, _ actionPlayer: Int) {
    if actionPlayer != obstacleOrientation{
        print("\nGAME OVER\n")
        exit(0)
    }
    print("\nOBSTACULO UTRAPASSADO COM SUCESSO\n")
}

func draw(runner: Player, obstacle: (Bool, Int, String)) {
    Scenario().draw(runner: runner, obstacle: obstacle)
}

func run() {
    let player = Runner(position: 0, shape: "*")
    let obstacle = Obstacle(position: 0, shape: "|")
    
    while true {
        let (generatedAnObstacle, obstacleOrientation, shape) = obstacle.generete()
        let obstacleSettings = (generatedAnObstacle, obstacleOrientation, shape)
        update(player: player, obstacleSettings: obstacleSettings)
        draw(runner: player, obstacle: obstacleSettings)
        Thread.sleep(forTimeInterval: 0.1)
    }
}

run()

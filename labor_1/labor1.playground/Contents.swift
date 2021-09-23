import UIKit

class GameCharacter : NSObject {
    var name: String
    var level: Int
    var healthPoint = 100
    
    var isDead: Bool {
        get {
            return healthPoint <= 0
        }
    }
    
    var power: Int {
        return level * 10
    }
    
    init?(name: String, level: Int) {
        if level < 0 || level >= 100 {
            return nil
        }
        
        self.name = name
        self.level = level
        
        super.init()
    }
    
}

let hero1 = GameCharacter(name: "Force Chainer", level: 0)
let hero2 = GameCharacter(name: "Wrap Binder", level: 3)
if hero2 != nil {
    hero2?.level = 10
    print(hero2!.level)
}

if let unwrappedHero = hero2 {
    unwrappedHero.level = 20
}

guard let unwrappedHero = hero2 else { fatalError("Error") }
unwrappedHero.level = 30

class Team {
    private var members = [GameCharacter]()
    
    func add(_ member: GameCharacter) {
        members.append(member)
    }
    
    func printMembers() {
        for member in members {
            print(member.name)
        }
    }
    
    func has(member: GameCharacter) -> Bool {
        return members.contains { $0 == member }
    }
    
}

let heroes = Team()
heroes.add(hero1!)
heroes.add(hero2!)

heroes.printMembers()

if heroes.has(member: hero1!) {
    print("\(hero1!.name) a csapatban van!")
}

class Hero: GameCharacter {
    enum WeaponType {
        case laserCannon
        case spoon
    }
    
    var weapon: WeaponType?
    
    override var power: Int {
        var extraPower = 0
        if let unwrappedWeapon = weapon {
            switch unwrappedWeapon {
            case .laserCannon:
                extraPower = 100
            case .spoon:
                extraPower = 1
            }
        }
        return super.power + extraPower
    }
}

protocol Fightable {
    var isDead: Bool { get }
    var power: Int { get }
    var name: String { get }
    
    func takeDamage(from enemy: Fightable)
    func printHealth()
}

extension GameCharacter: Fightable {
    func takeDamage(from enemy: Fightable) {
        print("\(name) took \(enemy.power) damages from \(enemy.name)")
        let attackRating = Double.random(in: 0...10) / 10
        healthPoint -= Int(Double(enemy.power) * attackRating)
    }
    
    func printHealth() {
        print("\(name): \(healthPoint) ❤️ \n")
    }
}

class Arena {
    var players: [Fightable]
    
    init(with players: [Fightable]) {
        self.players = players
    }
    
    func startBrawl() {
        while players.count > 1 {
            // Keverjük össze a tömb elemeit, hogy összecsapásonként más legyen az első és utolsó elem.
            players.shuffle()
            if let firstPlayer = players.first, let secondPlayer = players.last {
                // Az egyik játékos kapjon ütést a másiktól és írjuk ki az életét utána.
                firstPlayer.takeDamage(from: secondPlayer)
                firstPlayer.printHealth()
                
                // Ha az ütést kapott karakter meghalt, akkor töröljük a listából.
                if firstPlayer.isDead {
                    print("☠️ \(firstPlayer.name) died. ☠️")
                    players.removeFirst()
                }
            }
            sleep(5)
        }
        
        // Ha már csak a győztes szerepel a játékosok között, akkor írjuk ki a nevét.
        if players.count == 1, let winner = players.first {
            print("👑 The winner is \(winner.name)! 👑")
        }
    }
    
}

let arena = Arena(with: [hero1!, hero2!])
arena.startBrawl()

class Monster: Fightable {
    var name: String
    var headCount: Int
    var power: Int {
        return headCount * 20
    }
    
    var isDead: Bool {
        if headCount == 0 {
            return true
        }
        
        return false
    }
    
    init(name: String, headCount: Int) {
        self.name = name
        self.headCount = headCount
    }
    
    func takeDamage(from enemy: Fightable) {
        let chanceOfLosingHead = Double.random(in: 0..<10)
        if chanceOfLosingHead <= 5 {
            headCount -= 1
        }
    }
    
    func printHealth() {
        print("\(name): \(headCount) 🐲 \n")
    }
}

let monster1 = Monster(name: "Sárkány1", headCount: 7)
let monster2 = Monster(name: "Sárkány2", headCount: 2)

let arena2 = Arena(with: [hero1!, hero2!, monster1, monster2])
arena2.startBrawl()


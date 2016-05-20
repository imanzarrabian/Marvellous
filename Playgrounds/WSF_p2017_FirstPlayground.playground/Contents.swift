/*: 
# Swift Basics : WSF P2017 */

import UIKit

var str = "Hello, playground"

var unitializedStr: String
unitializedStr = "Toto"


let strConst = "Hello, playground 2"



/*: **ENUM** */

enum GasValues {
    case Diesel
    case Fuel
    case GPL
}

/*: **CLASS et HÉRITAGE** */

class Vehicule {

    //nombre de roues
    var nbWheels: Int
    
    //couleur
    var color: UIColor?
    
    //vitesse
    var speed = 0.0 //in km/h
    
    //type de carburant
    let gasType = GasValues.Diesel
    
    init(color: UIColor, nbWheels: Int) {
        self.color = color
        self.nbWheels = nbWheels
    }
    
    
    //accelere
    func accelerate(time: Int)  {
        //accelerer pendant un certain temps d'une quantité constante
        for _ in 0 ..< time {
            speed += 0.5
        }
    }
}

class Moto: Vehicule {

    convenience init(color: UIColor) {
        self.init(color: color, nbWheels: 2)
    }
}

class Voiture: Vehicule {
    convenience init(color: UIColor) {
        self.init(color: color, nbWheels: 4)
    }
}


let myFirstMoto = Moto(color:UIColor.redColor())
print(myFirstMoto.nbWheels)



///////////////////////////////////////////////////

let maVoiture = Voiture(color: UIColor.redColor())
maVoiture.accelerate(20)
print(maVoiture.speed)
maVoiture.color = UIColor.greenColor()


let maMoto = Moto(color: UIColor.blueColor())
maMoto.accelerate(10)
print(maMoto.speed)
maMoto.nbWheels


var monAutreVoiture = maVoiture
monAutreVoiture.color = UIColor.blackColor()
maVoiture.color


//////////////////////////////////////////////////

/*: **STRUCT, OPTIONAL et COMPUTED PROPERTIES** */

struct Residence {
    var nbRooms: Int = 0
}

struct Person {
    var firstName = ""
    var birthYear = 1970
    var residence: Residence?
    
    //computed properties
    var age: Int {
        get {
            return 2016 - birthYear
        }
        set(newValue) {
            birthYear = 2016 - newValue
        }
    }
}

var moi = Person()
var maMaison = Residence()
maMaison.nbRooms = 3

moi.residence = maMaison

//: * Forced unwrapping
if moi.residence != nil {
    var anotherResidence = moi.residence!
    let roomsNumber = anotherResidence.nbRooms
    print("nombre de chambre de ma residence : \(roomsNumber)")
}
else {
    print("Je n'ai pas de residence")
}

//: * Optional binding => RECOMMENDÉ
if let newResidence = moi.residence {
    let roomsNumber2 = newResidence.nbRooms
    print(roomsNumber2 + 4)
}
else {
    
}

//: * Optional Chaining
let roomsNumber3 = moi.residence?.nbRooms
print(roomsNumber3! + 4)


let maChaine = "3"
let monEntier = Int(maChaine)


//: * Utilisation computed properties
moi.age = 20
print(moi.birthYear)
moi.birthYear = 1979
print(moi.age)


/*: **STRUCTURES DE DONNÉES DE LA STDLIB** */

//String, Int, Bool, Double, Float
//Array, Dictionary, Tuple

var myGOTArray = ["Jon","Arya","Tyrion"]

//COMPILE AWARNESS
myGOTArray.append("Sansa")
myGOTArray[2]


var myGotWeapons = ["Jon":"Sword",
                    "Arya" : "Wood Stick",
                    "Tyrion" : "His Mind"]

var aString = myGotWeapons["Arya"]
myGotWeapons["Jon"] = "His Mind"

var (first, second, third) = (3, "Trois", 4.0)

print(first)


/*: **HIGH ORDER FUNCTION** */

//:MAP
let a = ["1","2","3","4","5"]

let b = a.map { Int($0)! }
print(b)



let f = b.filter { $0 >= 3 }
print(f)






















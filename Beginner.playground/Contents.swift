//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var myAge : Int = 22

myAge = 21

let myName: String = "Nhu"

let myAgeInTenYears = myAge + 10

let myDetails = "\(myName), \(myAge)"

func getMilk(howManyMilkCartons: Int, howMuchMoneyRobotWasGiven : Int) -> Int {
    print("go to the shops")
    print("buy \(howManyMilkCartons) cartons of milk")
    
    let priceToPay = howManyMilkCartons * 2
    
    print("pay $\(priceToPay)")
    print("come home")
    
    let change = howMuchMoneyRobotWasGiven - priceToPay
    return change;
}

var amountOfChange = getMilk(howManyMilkCartons: 1, howMuchMoneyRobotWasGiven: 10)

print("This is your change: \(amountOfChange)")

func loveCalculator (yourName : String, theirName : String) -> String {
    
    //Generating a random number between 0 and 100
    let loveScore = arc4random_uniform(101)
    
    if loveScore > 80 {
        return "Your love score is \(loveScore). You love each other like Kanye loves Kanye"
    }
    else if loveScore > 40 && loveScore <= 80 {
        return "Your love score is \(loveScore). You go together like coke and mentos"
    }
    else {
        return "Your love score is \(loveScore). No love possible, you'll be forever alone!"
    }
    
}
print(loveCalculator(yourName: "Nhu Luong", theirName: "Travis Carmichael"))

//
//  ViewController.swift
//  Dicee
//
//  Created by Nhu Luong on 12/26/17.
//  Copyright © 2017 Nhu Luong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    @IBOutlet weak var DiceImageView1: UIImageView!
    @IBOutlet weak var DiceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func RowButtonPressed(_ sender: UIButton) {
        updateDiceImage()
    }
    func updateDiceImage(){
        //UInt32 is unsigned -> we need to cast Int
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        DiceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        DiceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
    }
    

}


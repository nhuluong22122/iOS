//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Nhu Luong on 12/27/17.
//  Copyright © 2017 Nhu Luong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var AnswerImageView: UIImageView!
    var randomResult : Int = 0
    let answer = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AskButton(_ sender: UIButton) {
        updateImage()
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateImage()
    }
    
    func updateImage(){
        randomResult = Int(arc4random_uniform(5))
        AnswerImageView.image = UIImage(named: answer[randomResult])
    }

}


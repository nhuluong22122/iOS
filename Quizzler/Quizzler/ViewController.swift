//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        updateUI()
    }
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        }else {
            ProgressHUD.showError("Wrong")
            score -= 1
        }
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber + 1
        
        nextQuestion()
        updateUI()
    }
    func updateUI() {
        scoreLabel.text = "Score: " + String(score)
        progressLabel.text = String(questionNumber) + " / 13"
        //view is the view
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber)
        
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
             questionLabel.text = allQuestions.list[questionNumber].questionText
        }
        else {
            let alert = UIAlertController(title:"Awesome",message: "Finished, do you want to start over?", preferredStyle: .alert)
            //This {( )} is a closure - whenever in a closure needs to add self.
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:
            { (UIAlertAction) in
                
                    self.startOver()
                
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    func startOver() {
        score = 0
        questionNumber = 0
        updateUI()
        nextQuestion()
    }
    
    
}

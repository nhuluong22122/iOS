//
//  ViewController.swift
//  DetectML
//
//  Created by Nhu Luong on 1/9/18.
//  Copyright © 2018 Nhu Luong. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
    }
    @objc func presentExampleController(result : String){
        let alert = UIAlertController(title: "Result", message: result, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let userPickImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = userPickImage
            
            //If this part fails -> do statement in else
            guard let ciimage = CIImage(image: userPickImage) else {
                fatalError("Could not convert UIImage into CIImage.")
            }
            detect(image: ciimage)
          
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    func detect(image: CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading COREML Model Failed.")
        }
        //try? -> won't do anything if model is nil
        let request = VNCoreMLRequest(model:model) {
            (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {
                 fatalError("Model Failed to Process Image.")
            }
            if let firstResult = result.first {
                self.navigationItem.title = "Detected!"
                let displayResult = firstResult.identifier.components(separatedBy: ",")[0]
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1.00);
                print(displayResult)
                self.perform(#selector(self.presentExampleController), with: (result: displayResult), afterDelay: 0)
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
 
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated:  true, completion:  nil)
    }
}


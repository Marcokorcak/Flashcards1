//
//  CreationViewController.swift
//  Flashcars v2
//
//  Created by Marco Korcak on 3/9/21.
//

import UIKit

class CreationViewController: UIViewController {
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        let alert = UIAlertController(title: "Missing text", message: "You need to enter both a question and answer", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty) {
            present(alert, animated: true);
        }
        else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
            
            dismiss(animated: true)
        }
        
    }
    
}

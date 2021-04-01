////
//  ViewController.swift
//  Flashcars v2
//
//  Created by Marco Korcak on 2/23/21.
//

import UIKit

struct Flashcard
{
    
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    var flashcards = [Flashcard]()
    var currentIndex = 0

    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readsavedFlashcard()
        if flashcards.count == 0{
           updateFlashcard(question: "What is the population of Germany?", answer: "8 Million")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
        animateCardIn()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    @IBAction func didTapOnFlashcard( sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard ()
    {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations:{ self.frontLabel.isHidden = true})
    }
    
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = question
        backLabel.text = answer
        flashcards.append(flashcard)
        
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons()
    {
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
        if currentIndex == 0
        {
            prevButton.isEnabled = false;
        }
        else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels()
    {
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        frontLabel.isHidden = false;

    }
    func saveAllFlashcardsToDisk(){
        
        
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return
            ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
        }
    func readsavedFlashcard()
    {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]]
        {
            let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                return Flashcard(question : dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
 
    func animateCardOut()
    {
        UIView.animate(withDuration: 0.3, animations:{ self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: {finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    
    func animateCardIn()
    {
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3){
            self.card.transform = CGAffineTransform.identity
        }
    }
    
}


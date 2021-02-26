//
//  ViewController.swift
//  Flashcars v2
//
//  Created by Marco Korcak on 2/23/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard( sender: Any) {
        frontLabel.isHidden = false
        
    }
    
}


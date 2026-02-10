//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Claude
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // MARK: - Properties
    var responses: [Answer]!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Methods
    func calculatePersonalityResult() {
        // Count frequency of each coding style
        var frequencyOfAnswers: [CodingStyle: Int] = [:]
        let responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            frequencyOfAnswers[response, default: 0] += 1
        }
        
        // Find the most frequent answer
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        
        // Update UI
        resultAnswerLabel.text = "\(mostCommonAnswer.emoji) \(mostCommonAnswer.rawValue)"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    // MARK: - Actions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

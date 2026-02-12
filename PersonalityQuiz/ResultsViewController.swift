//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Updated with Stretch Goal 4 (History)
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    // MARK: - Properties
    var responses: [Answer]!
    var quizType: QuizType = .codingStyle
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true
    }
    
    // MARK: - Methods
    func calculatePersonalityResult() {
        // Determine result based on quiz type
        switch quizType {
        case .codingStyle:
            calculateCodingStyleResult()
        case .animalPersonality:
            calculateAnimalResult()
        case .careerPath:
            calculateCareerResult()
        }
    }
    
    func calculateCodingStyleResult() {
        var frequencyOfAnswers: [CodingStyle: Int] = [:]
        
        for response in responses {
            if let codingStyle = response.type as? CodingStyle {
                frequencyOfAnswers[codingStyle, default: 0] += 1
            }
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        displayResult(mostCommonAnswer)
        
        // Save to history (Stretch Goal 4)
        saveToHistory(
            result: mostCommonAnswer.rawValue,
            emoji: mostCommonAnswer.emoji,
            score: "\(frequencyOfAnswers[mostCommonAnswer]!)/\(responses.count)"
        )
    }
    
    func calculateAnimalResult() {
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        for response in responses {
            if let animalType = response.type as? AnimalType {
                frequencyOfAnswers[animalType, default: 0] += 1
            }
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        displayResult(mostCommonAnswer)
        
        saveToHistory(
            result: mostCommonAnswer.rawValue,
            emoji: mostCommonAnswer.emoji,
            score: "\(frequencyOfAnswers[mostCommonAnswer]!)/\(responses.count)"
        )
    }
    
    func calculateCareerResult() {
        var frequencyOfAnswers: [CareerType: Int] = [:]
        
        for response in responses {
            if let careerType = response.type as? CareerType {
                frequencyOfAnswers[careerType, default: 0] += 1
            }
        }
        
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        displayResult(mostCommonAnswer)
        
        saveToHistory(
            result: mostCommonAnswer.rawValue,
            emoji: mostCommonAnswer.emoji,
            score: "\(frequencyOfAnswers[mostCommonAnswer]!)/\(responses.count)"
        )
    }
    
    func displayResult(_ result: PersonalityType) {
        resultAnswerLabel.text = "\(result.emoji) \(result.rawValue)"
        resultDefinitionLabel.text = result.definition
    }
    
    // MARK: - History Management (Stretch Goal 4)
    func saveToHistory(result: String, emoji: String, score: String) {
        let quizResult = QuizResult(
            quizType: quizType.rawValue,
            result: result,
            emoji: emoji,
            date: Date(),
            score: score
        )
        
        var history = loadHistory()
        history.append(quizResult)
        
        // Save to UserDefaults
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: "quizHistory")
        }
    }
    
    func loadHistory() -> [QuizResult] {
        if let data = UserDefaults.standard.data(forKey: "quizHistory"),
           let decoded = try? JSONDecoder().decode([QuizResult].self, from: data) {
            return decoded
        }
        return []
    }
    
    // MARK: - Actions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

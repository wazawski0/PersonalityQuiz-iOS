//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Updated with ALL Stretch Goals (1-5)
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var questionProgressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Single answer outlets
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    // Multiple answer outlets
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multiLabels: [UILabel]!
    @IBOutlet var multiSwitches: [UISwitch]!
    
    // Ranged answer outlets
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionButton: UIButton!
    
    // Timer outlets (Stretch Goal 5)
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerProgressView: UIProgressView!
    
    // MARK: - Properties
    var selectedQuizType: QuizType = .codingStyle
    var questions: [Question] = []
    var questionIndex = 0
    var answersChosen: [Answer] = []

    // Stretch Goal 2: Randomization
    var originalAnswerMapping: [Int: Answer] = [:]

    // Stretch Goal 5: Timer
    var timer: Timer?
    var timeRemaining = 30
    let timeLimit = 30
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🟢 QuestionVC viewDidLoad")
        print("🟢 selectedQuizType: \(selectedQuizType)")
        setupQuiz()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    deinit {
        stopTimer()
    }
    
    // MARK: - Setup
    func setupQuiz() {
        print("🟢 setupQuiz called")
        print("🟢 Loading questions for: \(selectedQuizType)")
        
        // Load questions for selected quiz type
        questions = QuestionData.questions(for: selectedQuizType)
        
        print("🟢 Loaded \(questions.count) questions")
        if let firstQuestion = questions.first {
            print("🟢 First question: \(firstQuestion.text)")
        }
        
        // Stretch Goal 2: Randomize questions
        questions.shuffle()
        
        // Setup timer UI
        timerProgressView?.progress = 1.0
        timerProgressView?.progressTintColor = .systemGreen
    }
    
    // MARK: - UI Update
    func updateUI() {
        // Hide all answer views initially
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        // Update navigation and progress
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionProgressLabel.text = "Question \(questionIndex + 1) of \(questions.count)"
        questionLabel.text = currentQuestion.text
        
        // Show appropriate answer type
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
        
        // Start timer for this question (Stretch Goal 5)
        startTimer()
    }
    
    // MARK: - Update Answer Views
    
    // Stretch Goal 3: Dynamic answer count
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        questionButton.isHidden = true
        
        // Clear existing buttons
        for view in singleStackView.arrangedSubviews {
            singleStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        // Stretch Goal 2: Randomize answers
        let shuffledAnswers = answers.shuffled()
        originalAnswerMapping.removeAll()
        
        // Stretch Goal 3: Create buttons dynamically based on answer count
        for (index, answer) in shuffledAnswers.enumerated() {
            let button = createAnswerButton(with: answer.text, tag: index)
            singleStackView.addArrangedSubview(button)
            
            // Store original answer for later
            originalAnswerMapping[index] = answer
            
            // Add height constraint
            button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        questionButton.setTitle("Submit Answer", for: .normal)
        questionButton.isHidden = false
        
        // Stretch Goal 2: Randomize answers
        let shuffledAnswers = answers.shuffled()
        originalAnswerMapping.removeAll()
        
        for (index, answer) in shuffledAnswers.enumerated() {
            if index < multiLabels.count {
                multiLabels[index].text = answer.text
                multiLabels[index].isHidden = false
                multiSwitches[index].isHidden = false
                multiSwitches[index].isOn = false
                
                // Store original answer
                originalAnswerMapping[index] = answer
            }
        }
        
        // Hide unused labels/switches if answers < 4
        for i in answers.count..<min(4, multiLabels.count) {
            multiLabels[i].isHidden = true
            multiSwitches[i].isHidden = true
        }
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        questionButton.setTitle("Submit Answer", for: .normal)
        questionButton.isHidden = false
        
        rangedSlider.minimumValue = 0
        rangedSlider.maximumValue = Float(answers.count - 1)
        rangedSlider.value = Float(answers.count - 1) / 2
        
        // Configure labels
        rangedLabels[0].text = answers.first?.text
        rangedLabels[0].numberOfLines = 0
        rangedLabels[0].lineBreakMode = .byWordWrapping
        rangedLabels[0].font = UIFont.systemFont(ofSize: 14)
        
        rangedLabels[1].text = answers.last?.text
        rangedLabels[1].numberOfLines = 0
        rangedLabels[1].lineBreakMode = .byWordWrapping
        rangedLabels[1].font = UIFont.systemFont(ofSize: 14)
        rangedLabels[1].textAlignment = .right
    }
    
    // MARK: - Helper Methods
    func createAnswerButton(with title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.tag = tag
        
        // Styling
        button.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.layer.cornerRadius = 8
        
        // Add action
        button.addTarget(self, action: #selector(dynamicSingleAnswerPressed(_:)), for: .touchUpInside)
        
        return button
    }
    
    func nextQuestion() {
        stopTimer()
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    // MARK: - Timer Methods (Stretch Goal 5)
    func startTimer() {
        // Reset timer
        timeRemaining = timeLimit
        updateTimerDisplay()
        
        // Stop any existing timer
        timer?.invalidate()
        
        // Start new timer
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.timerTick()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func timerTick() {
        timeRemaining -= 1
        updateTimerDisplay()
        
        if timeRemaining <= 0 {
            handleTimeout()
        }
    }
    
    func updateTimerDisplay() {
        timerLabel?.text = "\(timeRemaining)s"
        timerProgressView?.progress = Float(timeRemaining) / Float(timeLimit)
        
        // Change color based on time remaining
        if timeRemaining <= 10 {
            timerLabel?.textColor = .systemRed
            timerProgressView?.progressTintColor = .systemRed
        } else if timeRemaining <= 20 {
            timerLabel?.textColor = .systemOrange
            timerProgressView?.progressTintColor = .systemOrange
        } else {
            timerLabel?.textColor = .label
            timerProgressView?.progressTintColor = .systemGreen
        }
    }
    
    func handleTimeout() {
        stopTimer()
        
        let currentQuestion = questions[questionIndex]
        
        // Auto-select a random answer
        switch currentQuestion.type {
        case .single:
            if let randomAnswer = currentQuestion.answers.randomElement() {
                answersChosen.append(randomAnswer)
            }
        case .multiple:
            // Select 1-2 random answers
            let randomCount = Int.random(in: 1...2)
            let randomAnswers = currentQuestion.answers.shuffled().prefix(randomCount)
            answersChosen.append(contentsOf: randomAnswers)
        case .ranged:
            if let randomAnswer = currentQuestion.answers.randomElement() {
                answersChosen.append(randomAnswer)
            }
        }
        
        // Show alert
        let alert = UIAlertController(
            title: "Time's Up!",
            message: "A random answer was selected for you.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            self?.nextQuestion()
        })
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    
    @objc func dynamicSingleAnswerPressed(_ sender: UIButton) {
        // Get the answer from our mapping
        if let selectedAnswer = originalAnswerMapping[sender.tag] {
            answersChosen.append(selectedAnswer)
        }
        nextQuestion()
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        // This is for the old static button approach
        let currentAnswers = questions[questionIndex].answers
        
        if let index = singleButtons.firstIndex(of: sender), index < currentAnswers.count {
            answersChosen.append(currentAnswers[index])
        }
        
        nextQuestion()
    }
    
    @IBAction func questionButtonPressed(_ sender: UIButton) {
        let currentQuestion = questions[questionIndex]
        
        switch currentQuestion.type {
        case .multiple:
            // Use originalAnswerMapping for randomized answers
            for (index, switchControl) in multiSwitches.enumerated() {
                if switchControl.isOn, let answer = originalAnswerMapping[index] {
                    answersChosen.append(answer)
                }
            }
            
        case .ranged:
            let currentAnswers = currentQuestion.answers
            let index = Int(round(rangedSlider.value))
            if index < currentAnswers.count {
                answersChosen.append(currentAnswers[index])
            }
            
        default:
            break
        }
        
        nextQuestion()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            stopTimer()
            if let resultsVC = segue.destination as? ResultsViewController {
                resultsVC.responses = answersChosen
                resultsVC.quizType = selectedQuizType
            }
        }
    }
}

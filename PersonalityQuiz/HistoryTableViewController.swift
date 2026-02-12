//
//  HistoryTableViewController.swift
//  PersonalityQuiz
//
//  Stretch Goal 4: Quiz History
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    var quizHistory: [QuizResult] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quiz History"
        
        // Add clear button
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Clear All",
            style: .plain,
            target: self,
            action: #selector(clearHistory)
        )
        
        // Setup table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        
        loadHistory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadHistory()
    }
    
    // MARK: - Data Loading
    func loadHistory() {
        if let data = UserDefaults.standard.data(forKey: "quizHistory"),
           let decoded = try? JSONDecoder().decode([QuizResult].self, from: data) {
            // Show most recent first
            quizHistory = decoded.reversed()
        } else {
            quizHistory = []
        }
        
        tableView.reloadData()
        
        // Update clear button state
        navigationItem.rightBarButtonItem?.isEnabled = !quizHistory.isEmpty
    }
    
    @objc func clearHistory() {
        let alert = UIAlertController(
            title: "Clear History",
            message: "Are you sure you want to delete all quiz results?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in
            UserDefaults.standard.removeObject(forKey: "quizHistory")
            self?.loadHistory()
        })
        
        present(alert, animated: true)
    }
    
    // MARK: - Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if quizHistory.isEmpty {
            // Show empty state
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
            emptyLabel.text = "No quiz history yet.\nTake a quiz to see your results here!"
            emptyLabel.textAlignment = .center
            emptyLabel.textColor = .secondaryLabel
            emptyLabel.numberOfLines = 0
            tableView.backgroundView = emptyLabel
            return 0
        } else {
            tableView.backgroundView = nil
            return quizHistory.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        let result = quizHistory[indexPath.row]
        
        // Configure cell
        var config = cell.defaultContentConfiguration()
        config.text = "\(result.emoji) \(result.result)"
        config.secondaryText = "\(result.quizType) • \(result.formattedDate) • Score: \(result.score)"
        config.secondaryTextProperties.font = .systemFont(ofSize: 14)
        config.secondaryTextProperties.color = .secondaryLabel
        
        cell.contentConfiguration = config
        cell.accessoryType = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let result = quizHistory[indexPath.row]
        
        let alert = UIAlertController(
            title: "\(result.emoji) \(result.result)",
            message: "Quiz: \(result.quizType)\nDate: \(result.formattedDate)\nScore: \(result.score)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // Enable swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove from array (convert reversed collection to array)
            var allHistory = Array(quizHistory.reversed())
            allHistory.remove(at: indexPath.row)
            
            // Save back to UserDefaults
            if let encoded = try? JSONEncoder().encode(allHistory) {
                UserDefaults.standard.set(encoded, forKey: "quizHistory")
            }
            
            // Reload
            loadHistory()
        }
    }
}

//
//  ViewController.swift
//  TikoJanikashvili-Lecture14
//
//  Created by Tiko Janikashvili on 23.11.22.
//

import UIKit

class PersonViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var sortByAgeButton: UIButton!
    @IBOutlet private weak var sortByCountryButton: UIButton!
    
    // MARK: - Properties
    private var persons: [Person] = []
    private var sortedPersons: [[Person]] = []
    private var isSortedByAge = false
    private var isSortedByNation = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configurePerson()
    }
    
    private func setupLayout() {
        tableView.register(UINib(nibName: "PersonCell", bundle: nil), forCellReuseIdentifier: "PersonCell")
        tableView.dataSource = self
        tableView.delegate = self
        sortByAgeButton.layer.cornerRadius = 7
        sortByCountryButton.layer.cornerRadius = 7
    }
    
    private func configurePerson() {
        persons = [
            Person(name: "ანა", surname: "ბერიძე", age: 11, nationality: .georgian),
            Person(name: "ლილე", surname: "კალანდაძე", age: 22, nationality: .french),
            Person(name: "საბა", surname: "კოპაძე", age: 15, nationality: .italian),
            Person(name: "ლელა", surname: "მიმინოშვილი", age: 12, nationality: .spanish),
            Person(name: "გიორგი", surname: "ჟღენტი", age: 14, nationality: .italian),
            Person(name: "დათო", surname: "მარგველაშვილი", age: 12, nationality: .georgian),
            Person(name: "გიორგი", surname: "დალაქიშვილი", age: 7, nationality: .spanish),
            Person(name: "მარიკა", surname: "კობახიძე", age: 11, nationality: .french),
            Person(name: "ნინო", surname: "ცინცაძე", age: 33, nationality: .italian),
            Person(name: "დათო", surname: "თაქთაქიშვილი", age: 44, nationality: .spanish),
            Person(name: "ლევანი", surname: "ჯავახიშვილი", age: 55, nationality: .georgian),
            Person(name: "ლუკა", surname: "კოპაძე", age: 66, nationality: .spanish),
            Person(name: "ნინო", surname: "გონგლიაშვილი", age: 55, nationality: .italian),
            Person(name: "ნათია", surname: "გახარია", age: 66, nationality: .french),
            Person(name: "გიორგი", surname: "დალაქიშვილი", age: 55, nationality: .georgian),
            Person(name: "გიორგი", surname: "დალაქიშვილი", age: 55, nationality: .georgian)
        ]
    }
    
    private func sortByNation() {
        sortedPersons.removeAll()
        
        let sorted = Dictionary(grouping: persons) { $0.nationality }
        sorted.forEach { (key: Person.Nationality, value: [Person]) in
            sortedPersons.append(value)
        }
    }
    
    private func sortByAge() {
        sortedPersons.removeAll()
        
        let sorted = Dictionary(grouping: persons) { $0.age > 18 }
        sorted.forEach { (key: Bool, value: [Person]) in
            sortedPersons.append(value)
        }
    }
    
    private func alert(text: String) {
        let attributedString = NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25, weight: .bold),
            NSAttributedString.Key.foregroundColor : UIColor.systemBlue
        ])
        
        let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
        alert.view.layer.borderColor = UIColor.systemBlue.cgColor
        alert.view.layer.borderWidth = 1
        alert.view.layer.cornerRadius = 7
        
        alert.setValue(attributedString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "დახურვა", style: .cancel))
        present(alert, animated: true)
    }
    
    private func numberOfRows(in section: Int) -> Int? {
        let count = sortedPersons.count
        for i in 0..<count {
            if section == i {
                return sortedPersons[i].count
            }
        }
        return nil
    }
    
    private func cellForRow(at indexPath: IndexPath) -> Person? {
        let count = sortedPersons.count
        for i in 0..<count {
            if indexPath.section == i {
                return sortedPersons[i][indexPath.row]
            }
        }
        return nil
    }
    
    private func titleForHeader(in section: Int) -> String? {
        let count = sortedPersons.count
        for i in 0..<count {
            if isSortedByNation {
                return sortedPersons[section][i].nationality.rawValue
            } else if isSortedByAge {
                let title = sortedPersons[section][i].age > 18 ? "სრულწლოვანი" : "არასრულწლოვანი"
                return title
            } else {
                return ""
            }
        }
        return nil
    }
    
    // MARK: - IBActions
    @IBAction func sortByAge(_ sender: UIButton) {
        isSortedByNation = false
        sortByAge()
        isSortedByAge = true
        tableView.reloadData()
    }
    
    @IBAction func sortByCountry(_ sender: UIButton) {
        isSortedByAge = false
        sortByNation()
        isSortedByNation = true
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {

        if isSortedByNation || isSortedByAge {
            return sortedPersons.count
        } else {
            return persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSortedByAge || isSortedByNation {
            return numberOfRows(in: section)!
        } else {
            return persons.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as? PersonCell
        cell?.delegate = self
        
        var person: Person
        
        if isSortedByAge || isSortedByNation {
            person = cellForRow(at: indexPath)!
        } else {
            person = persons[indexPath.row]
        }
        
        cell?.configure(with: person)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isSortedByAge || isSortedByNation {
            return titleForHeader(in: section)
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

extension PersonViewController: PersonCellDelegate {
    func showAge(cell: PersonCell) {
        if let index = tableView.indexPath(for: cell) {
            alert(text: "\(persons[index.row].age) წლის.")
        }
    }
    
    func showName(cell: PersonCell) {
        if let index = tableView.indexPath(for: cell) {
            alert(text: persons[index.row].name)
        }
    }
}

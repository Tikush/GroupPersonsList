//
//  PersonCell.swift
//  TikoJanikashvili-Lecture14
//
//  Created by Tiko Janikashvili on 23.11.22.
//

import UIKit

protocol PersonCellDelegate: AnyObject {
    func showAge(cell: PersonCell)
    func showName(cell: PersonCell)
}

class PersonCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var showAgeButton: UIButton!
    @IBOutlet private weak var showNameButton: UIButton!
    @IBOutlet private weak var nationalityLabel: UILabel!
    
    // MARK: - Properties
    var delegate: PersonCellDelegate!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    private func setupLayout() {
        showAgeButton.layer.cornerRadius = 7
        showNameButton.layer.cornerRadius = 7
    }
    
    func configure(with item: Person) {
        nameLabel.text = item.name
        surnameLabel.text = item.surname
        ageLabel.text = "\(item.age) წლის"
        nationalityLabel.text = item.nationality.rawValue
    }
    
    @IBAction private func onShowAge(_ sender: UIButton) {
        delegate.showAge(cell: self)
    }
    
    @IBAction private func onShowName(_ sender: UIButton) {
        delegate.showName(cell: self)
    }
}

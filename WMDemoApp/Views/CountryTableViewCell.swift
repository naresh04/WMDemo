//
//  CountryTableViewCell.swift
//  WMDemoApp
//
//  Created by naresh chouhan on 4/28/25.
//

import Foundation
import UIKit

final class CountryTableViewCell: UITableViewCell {
    
    static let identifier = "CountryTableViewCell"
    
    private let titleLabel = UILabel()
    private let capitalLabel = UILabel()
    private let codeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        capitalLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        codeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        codeLabel.textAlignment = .right
        
        titleLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.adjustsFontForContentSizeCategory = true
        codeLabel.adjustsFontForContentSizeCategory = true
        
        let topStack = UIStackView(arrangedSubviews: [titleLabel, codeLabel])
        topStack.axis = .horizontal
        topStack.distribution = .fill
        topStack.alignment = .firstBaseline
        
        let fullStack = UIStackView(arrangedSubviews: [topStack, capitalLabel])
        fullStack.axis = .vertical
        fullStack.spacing = 8
        contentView.addSubview(fullStack)
        
        fullStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fullStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            fullStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fullStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            fullStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with country: Country) {
        titleLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
}

//
//  JBDatePickerWeekDaysView.swift
//  JBDatePicker
//
//  Created by Joost van Breukelen on 24-10-16.
//  Copyright © 2016 Joost van Breukelen. All rights reserved.
//

import UIKit

public final class JBDatePickerWeekDaysView: UIStackView {

    // MARK: - Properties
    private weak var datePickerView: JBDatePickerView!
    private var firstWeekDay: JBWeekDay!
    private var weekdayNameSymbols = [String]()
    private var weekdayLabels = [UILabel]()
    private var weekdayLabelTextColor: UIColor!
    
    
    // MARK: - Initialization
    public init(datePickerView: JBDatePickerView) {
        self.datePickerView = datePickerView
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        guard datePickerView != nil else {return}
        
        //stackView setup
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //get preferences
        firstWeekDay = datePickerView.delegate?.firstWeekDay
        
        //setup appearance
        self.weekdayLabelTextColor = datePickerView.delegate?.colorForWeekDaysViewText
        
        //get weekday name symbols
        var cal = Calendar.current
        if let preferredLanguage = Bundle.main.preferredLocalizations.first {
            if datePickerView.delegate?.shouldLocalize == true {
                cal.locale = Locale(identifier: preferredLanguage)
            }
        }
        weekdayNameSymbols = cal.shortWeekdaySymbols
        
        //adjust order of weekDayNameSymbols if needed
        let firstWeekdayIndex = firstWeekDay.rawValue - 1
        if firstWeekdayIndex >= 0 {
            
            //create new array order by slicing according to firstweekday
            let sliceOne = weekdayNameSymbols[firstWeekdayIndex...6]
            let sliceTwo = weekdayNameSymbols[0..<firstWeekdayIndex]
            weekdayNameSymbols = Array(sliceOne + sliceTwo)
        }
        
        //create and place labels. Setup constraints
        for i in 0...6 {
            
            //this containerView is used to prevent visible stretching of the weekDaylabel while turning the device
            let labelContainerView = UIView()
            labelContainerView.backgroundColor = datePickerView.delegate?.colorForWeekDaysViewBackground
            self.addArrangedSubview(labelContainerView)
            
            let weekDayLabel = UILabel()
            weekDayLabel.textAlignment = .center
            weekDayLabel.text = weekdayNameSymbols[i].uppercased()
            weekDayLabel.textColor = weekdayLabelTextColor
            weekDayLabel.translatesAutoresizingMaskIntoConstraints = false
            weekdayLabels.append(weekDayLabel)
            labelContainerView.addSubview(weekDayLabel)
            
            weekDayLabel.centerXAnchor.constraint(equalTo: labelContainerView.centerXAnchor).isActive = true
            weekDayLabel.centerYAnchor.constraint(equalTo: labelContainerView.centerYAnchor).isActive = true

        }
        
    }
    
    
    public override func layoutSubviews() {
        updateLayout()
    }
    
    func updateLayout() {

        //update labelsize
        let sizeOfFont = min(frame.size.width, frame.size.height) / 3
        for (index, label) in weekdayLabels.enumerated() {
            
            let labelText = weekdayNameSymbols[index]
            label.attributedText =  NSMutableAttributedString(string: labelText, attributes:[NSFontAttributeName:UIFont.systemFont(ofSize: sizeOfFont, weight: UIFontWeightRegular)])
        }
    }
    
    


}

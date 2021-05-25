//
//  Extensions.swift
//  
//
//  Created by Kiefer Wiessler on 20/05/2021.
//


import UIKit


public protocol Bindable: AnyObject {
    
    var bindedValue: AnyKeyPath { get }
    
    var bindingEvent: UIControl.Event? { get }
    
    func update(_ value: Any?, animated: Bool)
}


extension UILabel: Bindable {
    
    public var bindedValue: AnyKeyPath { \UILabel.text }
    
    public var bindingEvent: UIControl.Event? { nil }
    
    public func update(_ value: Any?, animated: Bool) {
        self.text = String(value)
    }
    
}


extension UITextField: Bindable {
    
    public var bindedValue: AnyKeyPath { \UITextField.text }
    
    public var bindingEvent: UIControl.Event? { .editingChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        self.text = String(value)
    }
    
}


extension UISlider: Bindable {
    
    public var bindedValue: AnyKeyPath { \UISlider.value }
    
    public var bindingEvent: UIControl.Event? { .valueChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        guard let value = value as? Float else { return }
        self.setValue(value, animated: animated)
    }
    
}


extension UIProgressView: Bindable {
    
    public var bindedValue: AnyKeyPath { \UIProgressView.progress }
    
    public var bindingEvent: UIControl.Event? { nil }
    
    public func update(_ value: Any?, animated: Bool) {
        guard let value = value as? Float else { return }
        self.setProgress(value, animated: animated)
    }
    
}


extension UISwitch: Bindable {
    
    public var bindedValue: AnyKeyPath { \UISwitch.isOn }
    
    public var bindingEvent: UIControl.Event? { .valueChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        guard let value = value as? Bool else { return }
        self.setOn(value, animated: animated)
    }
    
}

extension UITextView: Bindable {
    
    public var bindedValue: AnyKeyPath { \UITextView.text }
    
    public var bindingEvent: UIControl.Event? { .editingChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        self.text = String(value)
    }
    
}

extension UISearchBar: Bindable {
    
    public var bindedValue: AnyKeyPath { \UISearchBar.text }
    
    public var bindingEvent: UIControl.Event? { .editingChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        self.text = String(value)
    }
    
}

extension UISegmentedControl: Bindable {
    
    public var bindedValue: AnyKeyPath { \UISegmentedControl.selectedSegmentIndex }
    
    public var bindingEvent: UIControl.Event? { .valueChanged }
    
    public func update(_ value: Any?, animated: Bool) {
        guard let value = value as? Int else { return }
        self.selectedSegmentIndex = value
    }
    
    
    
    
}



extension String {
    
    public init?(_ value: Any?) {
        if let value = value as? String {
            self = value
        } else if let value = value as? Double {
            self = String(value)
        } else if let value = value as? Int {
            self = String(value)
        } else if let value = value as? Float {
            self = String(value)
        } else if let value = value as? Bool {
            self = value ? "true" : "false"
        } else {
            return nil
        }
    }
    
}



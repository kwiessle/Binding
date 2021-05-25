//
//  Bind.swift
//  
//
//  Created by Kiefer Wiessler on 24/05/2021.
//

import UIKit

class Bind<Model: AnyObject, Value:Equatable>: NSObject {
    
    weak var bindable: Bindable?
    
    weak var target: Binding<Model>?
    
    let modelProperty: WritableKeyPath<Model,Value>
    
    let sourceProperty: AnyKeyPath
    
    var onChange: (()->())?
    
    public init(target: Binding<Model>, source: Bindable, property: WritableKeyPath<Model,Value>, onChange: (()->())? = nil) {
        self.target = target
        self.bindable = source
        self.modelProperty = property
        self.sourceProperty = source.bindedValue
        self.onChange = onChange
        super.init()
        source.update(target.model[keyPath: self.modelProperty], animated: false)
        self.onChange?()
        guard let control = source as? UIControl, let event = source.bindingEvent else { return }
        control.addTarget(self, action: #selector(self.sourceValueDidChanged), for: event)
    }
    
    @objc func sourceValueDidChanged() {
        let value = self.bindable[keyPath: self.sourceProperty] as! Value
        self.target?.set(value, to: self.modelProperty, animated: false)
    }
    
    
    func set(_ value: Value, animated: Bool) {
        self.target?.model[keyPath: self.modelProperty] = value
        self.bindable?.update(value, animated: animated)
        self.onChange?()
    }
    
}

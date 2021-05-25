//
//  Bind.swift
//  
//
//  Created by Kiefer Wiessler on 24/05/2021.
//

import UIKit

class Bind<Model: AnyObject, Value>: NSObject {
    
    unowned var bindable: Bindable
    
    unowned var target: Binding<Model>
    
    let modelProperty: WritableKeyPath<Model,Value>
    
    let sourceProperty: AnyKeyPath
    
    public init(target: Binding<Model>, source: Bindable, property: WritableKeyPath<Model,Value>) {
        self.target = target
        self.bindable = source
        self.modelProperty = property
        self.sourceProperty = source.bindedValue
        super.init()
        self.set(self.target.model[keyPath: property], animated: false)
        guard let control = source as? UIControl, let event = source.bindingEvent else { return }
        control.addTarget(self, action: #selector(self.sourceValueDidChanged), for: event)
    }
    
    @objc func sourceValueDidChanged() {
        let value = self.bindable[keyPath: self.sourceProperty] as! Value
        self.target.model[keyPath: self.modelProperty] = value
        self.target.binds(for: self.modelProperty).forEach { $0.bindable.update(value, animated: false) }
    }
    
    
    func set(_ value: Value, animated: Bool) {
        self.target.model[keyPath: self.modelProperty] = value
        self.bindable.update(value, animated: animated)
    }
}

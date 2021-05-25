//
//  File.swift
//  
//
//  Created by Kiefer Wiessler on 24/05/2021.
//

import UIKit

class PropertyBinding<Model: AnyObject, Value>: NSObject {
    
    
    unowned var bindable: Bindable
    
    unowned var bindings: Binding<Model>
    
    let modelProperty: WritableKeyPath<Model,Value>
    
    let sourceProperty: AnyKeyPath
    
    public init(coordinator: Binding<Model>, source: Bindable, property: WritableKeyPath<Model,Value>) {
        self.bindable = source
        self.bindings = coordinator
        self.modelProperty = property
        self.sourceProperty = source.bindedValue
        super.init()
        self.set(self.bindings.model[keyPath: property], animated: false)
        guard let control = source as? UIControl, let event = source.bindingEvent else { return }
        control.addTarget(self, action: #selector(self.sourceValueDidChanged), for: event)
    }
    
    @objc func sourceValueDidChanged() {
        let value = self.bindable[keyPath: self.sourceProperty] as! Value
        self.self.bindings.model[keyPath: self.modelProperty] = value
        self.bindings.set(value, to: self.modelProperty, animated: false)
    }
    
    
    func set(_ value: Value, animated: Bool) {
        self.bindings.model[keyPath: self.modelProperty] = value
        self.bindable.update(value, animated: animated)
    }
}

//
//  Binding.swift
//
//
//  Created by Kiefer Wiessler on 20/05/2021.
//

import UIKit

public class Binding<Model:AnyObject> {
        
    
    //MARK: - Properties
    
    public var model: Model
    
    private var bindings: [AnyObject] = []
    
    //MARK: - Initializer
    
    public init(_ model: Model) {
        self.model = model
    }
    
    //MARK: Utils
    
    func bindings<Value>(for property: KeyPath<Model,Value>) -> [Bind<Model,Value>] {
        self.bindings.compactMap { $0 as? Bind<Model,Value> }.filter { $0.modelProperty == property }
    }
    
    
    
    
    
    /// Will instanciate and store a `PropertyBinding` between the informed ``property`` and ``source``
    /// - Parameters:
    ///   - property: A writable KeyPath referencing the model's property to bind with designated source
    ///   - source: Basically an object that conforms to 'Bindable' protocol
    ///   - notify: A closure runned on any change of the model's property
    
    public final func plug<Value:Equatable>(_ property: WritableKeyPath<Model,Value>, on source: Bindable, onChange: (()->())? = nil) {
        guard self.bindables(for: property).allSatisfy({ $0 !== source }) else { return }
        let bind = Bind(target: self, source: source, property: property, onChange: onChange)
        self.bindings.append(bind)
    }
    
    
    
    
    
    /// Will set and synchronize the informed `value` to all bindings observing the model's `property`
    /// - Parameters:
    ///   - value: The new value
    ///   - property: A  KeyPath referencing the model's property to update
    
    public final func set<Value:Equatable>(_ value: Value, to property: KeyPath<Model,Value>, animated: Bool = true) {
        self.bindings(for: property).forEach { $0.set(value, animated: animated) }
    }
    
    
    
    
    
    /// Will search all `Bindable` associated with the informed model's `property`
    /// - Parameter property: A KeyPath referencing the model's property eventually binded with a Bindable object
    /// - Returns: An array of all associated  objects binded for a given `property`
    
    public func bindables<Value:Equatable>(for property: KeyPath<Model,Value>) -> [Bindable] {
        self.bindings(for: property).compactMap { $0.bindable }
    }
    
  
}








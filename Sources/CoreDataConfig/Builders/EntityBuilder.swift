//
//  File.swift
//  
//
//  Created by Uncanny Apps on 7/17/20.
//

import Foundation

@_functionBuilder
public struct AttributeBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock(_ items: Attribute...) -> Entity.Attributes {
        items
    }
}

@_functionBuilder
public struct EntityBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock(_ items: Entity...) -> [Entity] {
        items
    }
}

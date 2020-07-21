
import Foundation

@_functionBuilder
public struct AttributeBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock(_ items: Attribute...) -> [Attribute] {
        items
    }
}

@_functionBuilder
public struct EntityBuilder {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    // MARK: - Methods
    
    public static func buildBlock<Wrapper: EntityWrapper>(_ items: Wrapper...) -> [Entity<Wrapper.Identifier>] {
        items.map(\.entity)
    }
    
    public static func buildBlock<W0: EntityWrapper,
                                  W1: EntityWrapper>(_ item0: W0,
                                                     _ item1: W1) -> [Entity<W0.Identifier>] where W0.Identifier == W1.Identifier {
        [item0.entity, item1.entity]
    }
    
    public static func buildBlock<W0: EntityWrapper,
                                  W1: EntityWrapper,
                                  W2: EntityWrapper>(_ item0: W0,
                                                     _ item1: W1,
                                                     _ item2: W2) -> [Entity<W0.Identifier>] where W0.Identifier == W1.Identifier, W0.Identifier == W2.Identifier {
        [item0.entity, item1.entity, item2.entity]
    }
    
    public static func buildBlock<W0: EntityWrapper,
                                  W1: EntityWrapper,
                                  W2: EntityWrapper,
                                  W3: EntityWrapper>(_ item0: W0,
                                                     _ item1: W1,
                                                     _ item2: W2,
                                                     _ item3: W3) -> [Entity<W0.Identifier>] where W0.Identifier == W1.Identifier, W0.Identifier == W2.Identifier, W0.Identifier == W3.Identifier {
        [item0.entity, item1.entity, item2.entity, item3.entity]
    }
    
    public static func buildBlock<W0: EntityWrapper,
                                  W1: EntityWrapper,
                                  W2: EntityWrapper,
                                  W3: EntityWrapper,
                                  W4: EntityWrapper>(_ item0: W0,
                                                     _ item1: W1,
                                                     _ item2: W2,
                                                     _ item3: W3,
                                                     _ item4: W4) -> [Entity<W0.Identifier>] where W0.Identifier == W1.Identifier, W0.Identifier == W2.Identifier, W0.Identifier == W3.Identifier, W0.Identifier == W4.Identifier {
        [item0.entity, item1.entity, item2.entity, item3.entity, item4.entity]
    }
    
    public static func buildBlock<W0: EntityWrapper,
                                  W1: EntityWrapper,
                                  W2: EntityWrapper,
                                  W3: EntityWrapper,
                                  W4: EntityWrapper,
                                  W5: EntityWrapper>(_ item0: W0,
                                                     _ item1: W1,
                                                     _ item2: W2,
                                                     _ item3: W3,
                                                     _ item4: W4,
                                                     _ item5: W5) -> [Entity<W0.Identifier>] where W0.Identifier == W1.Identifier, W0.Identifier == W2.Identifier, W0.Identifier == W3.Identifier, W0.Identifier == W4.Identifier, W0.Identifier == W5.Identifier {
        [item0.entity, item1.entity, item2.entity, item3.entity, item4.entity, item5.entity]
    }
}

public struct TupleEntityWrapper<T> {
    var value: T
}

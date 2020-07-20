
import Foundation
import CoreDataConfig

struct ComicBookStore: Store {
    
    var name: String { "Comics" }
    var model: Model {
        BaseObject {
            Publisher()
            Series()
            Event()
            Box()
            Tag()
            ComicBook()
        }
    }
}

struct BaseObject: EntityWrapper {
    
    var entity: Entity {
        Entity("BaseObject", {
            
            Attribute("id", type: .uuid)
                .isOptional(false)
            
            Attribute("createdAt", type: .date)
                .isOptional(false)
            
            Attribute("modifiedAt", type: .date)
                .isOptional(false)
            
        }, children: children)
        .isAbstract(true)
        .renamingIdentifier("_BaseObject")
    }
    var children: () -> [Entity]
    
    init(@EntityBuilder _ children: @escaping () -> [Entity]) {
        self.children = children
    }
}

struct Publisher: EntityWrapper {
    
    var entity: Entity {
        Entity("Publisher") {
            
            Attribute("name", type: .string)
                .isOptional(false)
            
        } relationships: {
            
            Relationship("series", entity: "Series", inverse: "publisher")
                .type(.toMany)
                .deleteRule(.cascade)
            
            Relationship("events", entity: "Event", inverse: "publisher")
                .type(.toMany)
                .deleteRule(.cascade)
            
        }
        .renamingIdentifier("_Publisher")
    }
}

struct Series: EntityWrapper {
    
    var entity: Entity {
        Entity("Series") {
            
            Attribute("name", type: .string)
                .isOptional(false)
            
        } relationships: {
            
            Relationship("publisher", entity: "Publisher", inverse: "series")
                .type(.toOne)
                .deleteRule(.nullify)
            
            Relationship("comicBooks", entity: "ComicBook", inverse: "series")
                .type(.toMany)
                .deleteRule(.cascade)
            
        }
        .renamingIdentifier("_Series")
    }
}

struct Event: EntityWrapper {
    
    var entity: Entity {
        Entity("Event") {
            
            Attribute("name", type: .string)
                .isOptional(false)
            
        } relationships: {
            
            Relationship("publisher", entity: "Publisher", inverse: "events")
                .type(.toOne)
                .deleteRule(.nullify)
            
            Relationship("comicBooks", entity: "ComicBook", inverse: "event")
                .type(.toMany)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)
            
        }
        .renamingIdentifier("_Event")
    }
}

struct Box: EntityWrapper {
    
    var entity: Entity {
        Entity("Box") {
            
            Attribute("name", type: .string)
                .isOptional(false)
            
        } relationships: {
            
            Relationship("comicBooks", entity: "ComicBook", inverse: "box")
                .type(.toMany)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)
            
        }
        .renamingIdentifier("_Box")
    }
}

struct Tag: EntityWrapper {
    
    var entity: Entity {
        Entity("Tag") {
            
            Attribute("name", type: .string)
                .isOptional(false)
            
        } relationships: {
            
            Relationship("comicBooks", entity: "ComicBook", inverse: "tags")
                .type(.toMany)
                .deleteRule(.nullify)
            
        }
        .renamingIdentifier("_Tag")
    }
}

struct ComicBook: EntityWrapper {
    
    var entity: Entity {
        Entity("ComicBook") {
            
            Attribute("upc", type: .string)
            
            Attribute("price", type: .double)
            
            Attribute("issueNum", type: .int16)
                .isOptional(false)
            
            Attribute("volumeNum", type: .int16)
            
            Attribute("releaseDate", type: .date)
                .isOptional(false)
            
            Attribute("coverImageData", type: .data)
            
        } relationships: {
            
            Relationship("box", entity: "Box", inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)
            
            Relationship("series", entity: "Series", inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)
            
            Relationship("tags", entity: "Tag", inverse: "comicBooks")
                .type(.toMany)
                .deleteRule(.nullify)
            
            Relationship("event", entity: "Event", inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)
            
        }
        .renamingIdentifier("_ComicBook")
    }
}

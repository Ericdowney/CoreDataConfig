
import Foundation
import CoreDataConfig

enum ComicBookIdentifier: String, EntityIdentifiable {
    case baseObject, publisher, series, event, box, tag, comicBook
    
    var name: String {
        switch self {
        case .baseObject: return "BaseObject"
        case .publisher: return "Publisher"
        case .series: return "Series"
        case .event: return "Event"
        case .box: return "Box"
        case .tag: return "Tag"
        case .comicBook: return "ComicBook"
        }
    }
}

struct ComicBookStore: Store {

    var name: String { "Comics" }
    var model: Model<ComicBookIdentifier> {
        Model {
            BaseObject {
                Publisher().eraseToAny()
                Series().eraseToAny()
                Event().eraseToAny()
                Box().eraseToAny()
                Tag().eraseToAny()
                ComicBook().eraseToAny()
            }
        }
    }
}

struct BaseObject: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.baseObject, attributes: {

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
    var children: () -> [Entity<ComicBookIdentifier>]

    init(@EntityBuilder _ children: @escaping () -> [Entity<ComicBookIdentifier>]) {
        self.children = children
    }
}

struct Publisher: EntityWrapper {
    
    var entity: Entity<ComicBookIdentifier> {
        Entity(.publisher) {

            Attribute("name", type: .string)
                .isOptional(false)

        } relationships: {

            Relationship<ComicBookIdentifier>("series", destination: .series, inverse: "publisher")
                .type(.toMany)
                .deleteRule(.cascade)

            Relationship<ComicBookIdentifier>("events", destination: .event, inverse: "publisher")
                .type(.toMany)
                .deleteRule(.cascade)

        }
        .renamingIdentifier("_Publisher")
    }
}

struct Series: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.series) {

            Attribute("name", type: .string)
                .isOptional(false)

        } relationships: {

            Relationship<ComicBookIdentifier>("publisher", destination: .publisher, inverse: "series")
                .type(.toOne)
                .deleteRule(.nullify)

            Relationship<ComicBookIdentifier>("comicBooks", destination: .comicBook, inverse: "series")
                .type(.toMany)
                .deleteRule(.cascade)

        }
        .renamingIdentifier("_Series")
    }
    
    init() {}
}

struct Event: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.event) {

            Attribute("name", type: .string)
                .isOptional(false)

        } relationships: {

            Relationship<ComicBookIdentifier>("publisher", destination: .publisher, inverse: "events")
                .type(.toOne)
                .deleteRule(.nullify)

            Relationship<ComicBookIdentifier>("comicBooks", destination: .comicBook, inverse: "event")
                .type(.toMany)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)

        }
        .renamingIdentifier("_Event")
    }
}

struct Box: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.box) {

            Attribute("name", type: .string)
                .isOptional(false)

        } relationships: {

            Relationship<ComicBookIdentifier>("comicBooks", destination: .comicBook, inverse: "box")
                .type(.toMany)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)

        }
        .renamingIdentifier("_Box")
    }
}

struct Tag: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.tag) {

            Attribute("name", type: .string)
                .isOptional(false)

        } relationships: {

            Relationship<ComicBookIdentifier>("comicBooks", destination: .comicBook, inverse: "tags")
                .type(.toMany)
                .deleteRule(.nullify)

        }
        .renamingIdentifier("_Tag")
    }
}

struct ComicBook: EntityWrapper {

    var entity: Entity<ComicBookIdentifier> {
        Entity(.comicBook) {

            Attribute("upc", type: .string)

            Attribute("price", type: .double)

            Attribute("issueNum", type: .int16)
                .isOptional(false)

            Attribute("volumeNum", type: .int16)

            Attribute("releaseDate", type: .date)
                .isOptional(false)

            Attribute("coverImageData", type: .data)

        } relationships: {

            Relationship<ComicBookIdentifier>("box", destination: .box, inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)
                .arrangement(isOrdered: true)

            Relationship<ComicBookIdentifier>("series", destination: .series, inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)

            Relationship<ComicBookIdentifier>("tags", destination: .tag, inverse: "comicBooks")
                .type(.toMany)
                .deleteRule(.nullify)

            Relationship<ComicBookIdentifier>("event", destination: .event, inverse: "comicBooks")
                .type(.toOne)
                .deleteRule(.nullify)

        }
        .renamingIdentifier("_ComicBook")
    }
}

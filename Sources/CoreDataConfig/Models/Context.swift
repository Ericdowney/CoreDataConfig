
import Foundation

struct ComicBookStore: Store {
    var name: String { "Comics" }
    
    var modelVersions: Content {
        ModelVersion(1, 0, 0) {
            Entity("Object", isAbstract: true) {
                Attribute("id", type: .uuid)
                Attribute("createdAt", type: .date)
                Attribute("modifiedAt", type: .date)
            } children: {
                
                Entity("Publisher") {
                    Attribute("name", type: .string)
                } relationships: {
                    Relationship("series", entity: "Series", type: .toMany)
                        .deleteRule(.cascade)
                    
                    Relationship("events", entity: "Events", type: .toMany)
                        .deleteRule(.cascade)
                }
                
                Entity("Series") {
                    Attribute("name", type: .string)
                } relationships: {
                    Relationship("publisher", entity: "Publisher", type: .toOne)
                        .deleteRule(.nullify)
                    
                    Relationship("comicBooks", entity: "ComicBook", type: .toMany)
                        .deleteRule(.cascade)
                }
                
                Entity("Event") {
                    Attribute("name", type: .string)
                } relationships: {
                    Relationship("publisher", entity: "Publisher", type: .toOne)
                        .deleteRule(.nullify)
                    
                    Relationship("comicBooks", entity: "ComicBook", type: .toMany)
                        .deleteRule(.nullify)
                        .arrangement(isOrdered: true)
                }
                
                Entity("Box") {
                    Attribute("name", type: .string)
                }
                Entity("Tag") {
                    Attribute("name", type: .string)
                }
                Entity("ComicBook") {
                    Attribute("upc", type: .string)
                    Attribute("price", type: .double)
                    Attribute("issueNum", type: .int16)
                    Attribute("volumeNum", type: .int16)
                    Attribute("releaseDate", type: .date)
                    Attribute("coverImageData", type: .data)
                }
                
            }
        }
    }
}

func buildContext() -> some Store {
    ComicBookStore()
}

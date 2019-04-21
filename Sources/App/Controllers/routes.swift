import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let storage = StorageController()
    
    router.get(use: storage.hello)
    
    
    
    router.get("all", use: storage.getAll)
    
    router.get("all", use: storage.getAll)
    
    router.get("allByTitle", String.parameter, use: storage.getAllByTitle)
    
    router.get("lastByTitle", String.parameter, use: storage.getLastByTitle)
    
    router.get("byID", Int.parameter, use: storage.getById)
    
    
    router.post("record", use: storage.create)
    
    router.post("restoreFromJson", use: storage.restoreFromJson)
    
    
    
    router.delete("record", use: storage.delete)
    
    router.delete("byID", Int.parameter, use: storage.deleteById)
    
    router.delete("lastByTitle", String.parameter, use: storage.deleteLastByTitle)
    
    router.delete("deleteAllOlderThatTimestamp", Int.parameter, use: storage.deleteAllOlderThatTimestamp)
    
    router.delete("deleteAllWithTitleOlderThatTimestamp", Int.parameter, String.parameter, use: storage.deleteAllWithTitleOlderThatTimestamp)
}

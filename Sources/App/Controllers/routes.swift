import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let storage = StorageController()
    
    
    router.get("all", use: storage.getAll)
    
    router.get("allByTitle", use: storage.getAllByTitle)
    
    router.get("lastByTitle", use: storage.getLastByTitle)
    
    router.get("byID", use: storage.getById)
    
    
    
    
    
    router.post("newRecord", use: storage.create)
    
    //router.post("restoreFromJson", use: storage.create)
    
   
    router.delete("byID", use: storage.deleteById)
    
    router.delete("lastByTitle", use: storage.deleteLastByTitle)
    
    // Delete by name older that timestamp
    
    // Delete all older that timestamp

    
    
    //==============================

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    // Basic "It works" example
    router.get { req in
        return "It works!!!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
}

import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!!!!!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    
    
    // Get by name last
    
    // Get by name and timestamp
    
    // Get all to table view ?
    
    // Get all to backup ?
    
    
    // Post by name
    
    // Post all to restore backup ?
    
    
    // Delete by name last
    
    // Delete by name and timestamp
    
    // Delete all older that timestamp
    
    
    
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

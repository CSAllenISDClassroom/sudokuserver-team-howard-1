import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    // Set local port
    guard let portString = Environment.get("VAPOR_LOCAL_PORT"),
          let port = Int(portString) else {
        fatalError("Failed to determine VAPOR LOCAL PORT from environment")
    }
    app.http.server.configuration.port = port

<<<<<<< HEAD
    // Set local port
    guard let portString = Environment.get("VAPOR_LOCAL_PORT"),
          let port = Int(portString) else {
        fatalError("Failed to determine VAPOR LOCAL PORT from environment")
    }
    app.http.server.configuration.port = port

=======
>>>>>>> 3bb192a0e27a69e4486037d67250c4c5f46846dd
    // Set local host
    guard let hostname = Environment.get("VAPOR_LOCAL_HOST") else {
        fatalError("Failed to determine VAPOR LOCAL HOST from environment")
    }
    app.http.server.configuration.hostname = hostname
<<<<<<< HEAD
    
    // register routes
=======
 // register routes
>>>>>>> 3bb192a0e27a69e4486037d67250c4c5f46846dd
    try routes(app)
}

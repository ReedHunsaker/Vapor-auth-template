import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Database config
    DatabaseConfig.configurePostgres(app)
    Migrations.addAll(app)
    
    // register routes
    try RouteConfig.setup(app)
    
    // JWT Config
    try await JWTConfig.setup(app)
}

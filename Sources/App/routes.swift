import Vapor

func publicRoutes(_ app: Application) throws {
    app.get { req async in
        "Hello, world!"
    }
}

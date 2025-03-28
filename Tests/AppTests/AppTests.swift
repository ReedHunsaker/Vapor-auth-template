@testable import App
import VaporTesting
import Testing
import FluentPostgresDriver

@Suite("App Tests", .serialized)
struct AppTests {
    @Test("Test Hello World Route")
    func helloWorld() async throws {
        try await TestingApp.withDatabase { app in
            try await app.testing().test(.GET, "", afterResponse: { res async in
                #expect(res.status == .ok)
                #expect(res.body.string == "Hello, world!")
            })
        }
    }
    
    @Test("Create user test")
    func createUserTest() async throws {
        try await TestingApp.withDatabase { app in
            let userCreateRequest = User.Create(email: "test@example.com", password: "asdf1234", confirmPassword: "asdf1234")
            try await app.testing().test(.POST, "user/create", beforeRequest: { req in
                try req.content.encode(userCreateRequest)
            }, afterResponse: { res async in
                #expect(res.status == .accepted)
            })
        }
    }
    
    @Test("Login test")
    func loginTest() async throws {
        try await TestingApp.withDatabase { app in
            let loginRequest: User.Login = User.Login(email: "test@example.com", password: "asdf1234")
            try await createUser(app, email: loginRequest.email, password: loginRequest.password)
            let loginString = String(format: "%@:%@", loginRequest.email, loginRequest.password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            try await app.testing().test(.POST, "login", beforeRequest: { req in
                req.headers.add(name: "Authorization", value: "Basic \(base64LoginString)")
            }, afterResponse: { res async in
                let response = try? res.content.decode(User.LoginResponse.self)
                #expect(response?.user.id != nil)
                if let token = response?.session?.token {
                    #expect(!token.isEmpty)
                } else {
                    Issue.record("Token is empty")
                }
            })
        }
    }
    
    private func createUser(_ app: Application, email: String, password: String) async throws {
        let userCreateRequest = User.Create(email: email, password: password, confirmPassword: password)
        try await app.testing().test(.POST, "user/create", beforeRequest: { req in
            try req.content.encode(userCreateRequest)
        }, afterResponse: { _ async in })
    }
}

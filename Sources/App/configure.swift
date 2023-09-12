import Vapor
import FluentPostgresDriver
import Fluent

// configures your application
public func configure(_ app: Application) async throws {
    guard let host = Environment.get("DATABASE_HOST"),
          let username = Environment.get("DATABASE_USERNAME"),
          let password = Environment.get("DATABASE_PASSWORD")
    else {
        app.shutdown()
        print("Could not load variable environment. Shutting down the app.")
        return
    }

    let configuration = SQLPostgresConfiguration(
        hostname: host,
        username: username,
        password: password,
        tls: .disable
    )
    app.databases.use(.postgres(configuration: configuration, decodingContext: .default), as: .psql)

    app.migrations.add(RoadmapFeature.Create())

    app.logger.logLevel = .debug

    try await app.autoMigrate()

    // register routes
    try routes(app)
}

import Vapor
import FluentPostgresDriver
import Fluent

// configures your application
public func configure(_ app: Application) async throws {
    guard let host = Environment.get("DATABASE_HOST"),
          let username = Environment.get("DATABASE_USERNAME"),
          let password = Environment.get("DATABASE_PASSWORD"),
          let name = Environment.get("DATABASE_NAME")
    else {
        app.shutdown()
        return
    }

    let configuration = SQLPostgresConfiguration(
        hostname: host,
        username: username,
        password: password,
        database: name,
        tls: .disable
    )
    app.databases.use(.postgres(configuration: configuration, decodingContext: .default), as: .psql)

    app.migrations.add(RoadmapFeature.Create())

    app.logger.logLevel = .debug

    try await app.autoMigrate()

    // register routes
    try routes(app)
}

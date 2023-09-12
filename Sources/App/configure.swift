import Vapor
import FluentPostgresDriver
import Fluent

// configures your application
public func configure(_ app: Application) async throws {
    let configuration = SQLPostgresConfiguration(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .disable
    )
    app.databases.use(.postgres(configuration: configuration, decodingContext: .default), as: .psql)

    app.migrations.add(RoadmapFeature.Create())

    app.logger.logLevel = .debug

    try await app.autoMigrate()

    // register routes
    try routes(app)
}

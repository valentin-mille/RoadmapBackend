//
//  23-09-12_RoadmapFeature+Create.swift
//
//
//  Created by Valentin Mille on 9/12/23.
//

import Fluent

extension RoadmapFeature {
    struct Create: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database
                .schema(RoadmapFeature.schema)
                .id()
                .field(RoadmapFeature.Create_20230912.namespace, .string)
                .field(RoadmapFeature.Create_20230912.featureId, .int)
                .field(RoadmapFeature.Create_20230912.vote, .int)
                .create()
        }

        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(RoadmapFeature.schema).delete()
        }

    }
}

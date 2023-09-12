//
//  FeatureVoterController.swift
//
//
//  Created by Valentin Mille on 9/11/23.
//

import Vapor
import Fluent

struct FeatureVoterController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get("get", ":namespace", ":featureId", use: getFeatureCount)
        routes.get("add", ":namespace", ":featureId", ":amount", use: voteFeature)
    }

    func voteFeature(req: Request) async throws -> [String: Int] {
        let amount = try req.parameters.require("amount", as: Int.self)
        let feature = try await fetchFeature(req: req)

        feature.vote += amount

        _ = req.db.transaction { database in
            feature.save(on: database)
        }

        return ["value": feature.vote ]
    }

    func getFeatureCount(req: Request) async throws -> [String: Int] {
        let feature = try await fetchFeature(req: req)
        return [ "value": feature.vote ]
    }

    private func fetchFeature(req: Request) async throws -> RoadmapFeature {
        let namespace = try req.parameters.require("namespace", as: String.self)
        let featureId = try req.parameters.require("featureId", as: Int.self)
        guard let feature = try await RoadmapFeature
            .query(on: req.db)
            .filter(\.$namespace == namespace)
            .filter(\.$featureId == featureId)
            .first()
        else {
            return RoadmapFeature(id: UUID(), namespace: namespace, featureId: featureId, vote: 0)
        }

        return feature
    }
}

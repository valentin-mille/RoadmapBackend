//
//  RoadmapFeature.swift
//
//
//  Created by Valentin Mille on 9/11/23.
//

import Foundation
import Fluent
import Vapor

final class RoadmapFeature: Model {
    /// table or collection name.
    static var schema: String = Create_20230912.schema

    // MARK: - Fields

    @ID(key: .id)
    var id: UUID?

    @Field(key: Create_20230912.namespace)
    var namespace: String

    @Field(key: Create_20230912.featureId)
    var featureId: Int

    @Field(key: Create_20230912.vote)
    var vote: Int

    // MARK: - Init

    /// Create a new, empty FeatureVoter.
    init() {

    }

    /// Create a new FeatureVoter with all properties set.
    init(id: UUID, namespace: String, featureId: Int, vote: Int) {
        self.id = id
        self.namespace = namespace
        self.featureId = featureId
        self.vote = vote
    }
}

// MARK: - Content

extension RoadmapFeature: Content {

}

// MARK: - FieldKeys

extension RoadmapFeature {
    enum Create_20230912 {
        static let schema = "roadmap_features"
        static let namespace: FieldKey = .namespace
        static let featureId: FieldKey = .featureId
        static let vote: FieldKey = .vote
    }
}

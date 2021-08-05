/**
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * Perse SDK Lite iOS
 * More About: https://www.getperse.com/
 * From CyberLabs.AI: https://cyberlabs.ai/
 * Haroldo Teruya @ Cyberlabs AI 2021
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 */

import Foundation

/**
 * Models to wrapper the API Response.
 */

public struct Compare402Response: Decodable {
    public let message: String
}

public struct CompareThreshold: Decodable {
    public let similarity: Float
}

public struct CompareResponse: Decodable {
    public let status: Int
    public let similarity: Float
    public let timeTaken: Float
    public let defaultThreshold: CompareThreshold
}

public struct LandmarksResponse: Decodable {
    public let leftEye: Array<Int>
    public let mouthLeft: Array<Int>
    public let mouthRight: Array<Int>
    public let nose: Array<Int>
    public let rightEye: Array<Int>
}

public struct MetricsResponse: Decodable {
    public let overexposure: Float
    public let sharpness: Float
    public let underexposure: Float
}

public struct FaceResponse: Decodable {
    public let boundingBox: Array<Int>
    public let faceMetrics: MetricsResponse
    public let landmarks: LandmarksResponse
    public let livenessScore: Float
}

public struct DetectThresholds: Decodable {
    public let overexposure: Float
    public let sharpness: Float
    public let underexposure: Float
    public let liveness: Float
}

public struct DetectResponse: Decodable {
    public let totalFaces: Int
    public let faces: Array<FaceResponse>
    public let imageMetrics: MetricsResponse
    public let status: Int
    public let timeTaken: Float
    public let defaultThresholds: DetectThresholds
}

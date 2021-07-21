import Foundation

public struct Compare402Response: Decodable {
    public let message: String
}

public struct CompareThreshold: Decodable {
    public let similarityThreshold: Float
}

public struct CompareResponse: Decodable {
    public let status: Int
    public let similarity: Float
    public let timeTaken: Float
    public let defaultThreshold: CompareThreshold
    public var raw: String?
}

public struct LandmarksResponse: Decodable {
    public let leftEye: Array<Int>
    public let mouthLeft: Array<Int>
    public let mouthRight: Array<Int>
    public let nose: Array<Int>
    public let rightEye: Array<Int>
}

public struct MetricsResponse: Decodable {
    public let overexpose: Float
    public let sharpness: Float
    public let underexpose: Float
}

public struct FaceResponse: Decodable {
    public let boundingBox: Array<Int>
    public let faceMetrics: MetricsResponse
    public let landmarks: LandmarksResponse
    public let livenessScore: Float
}

public struct DetectThresholds: Decodable {
    public let overexposureThreshold: Float
    public let sharpnessThreshold: Float
    public let underexposerThreshold: Float
    public let livenessThreshold: Float
}

public struct DetectResponse: Decodable {
    public let totalFaces: Int
    public let faces: Array<FaceResponse>
    public let imageMetrics: MetricsResponse
    public let status: Int
    public let timeTaken: Float
    public let defaultThresholds: DetectThresholds
    public var raw: String?
}

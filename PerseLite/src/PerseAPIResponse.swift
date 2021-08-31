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

public struct PerseAPIResponse {
    public struct Face {
        public struct Detect: Decodable {
            public let totalFaces: Int
            public let faces: Array<Face>
            public let imageMetrics: Metrics
            public let status: Int
            public let timeTaken: Float
            public let defaultThresholds: DetectThresholds
        }
        
        public struct Landmarks: Decodable {
            public let leftEye: Array<Int>
            public let mouthLeft: Array<Int>
            public let mouthRight: Array<Int>
            public let nose: Array<Int>
            public let rightEye: Array<Int>
        }

        public struct Metrics: Decodable {
            public let overexposure: Float
            public let sharpness: Float
            public let underexposure: Float
        }

        public struct Face: Decodable {
            public let boundingBox: Array<Int>
            public let faceMetrics: Metrics
            public let landmarks: Landmarks
            public let livenessScore: Float
        }

        public struct DetectThresholds: Decodable {
            public let overexposure: Float
            public let sharpness: Float
            public let underexposure: Float
            public let liveness: Float
        }
        
        public struct Compare402: Decodable {
            public let message: String
        }

        public struct CompareThresholds: Decodable {
            public let similarity: Float
        }

        public struct Compare: Decodable {
            public let status: Int
            public let similarity: Float
            public let timeTaken: Float
            public let defaultThresholds: CompareThresholds
        }
        
        public struct Enrollment {
            public struct Create: Decodable {
                public let userToken: String
                public let timeTaken: Float
                public let status: Int
            }
            
            public struct Read: Decodable {
                public let userTokens: Array<String>
                public let totalUsers: Int
                public let timeTaken: Float
                public let status: Int
            }
            
            public struct Update: Decodable {
                public let userToken: String
                public let timeTaken: Float
                public let status: Int
            }
            
            public struct Delete: Decodable {
                public let timeTaken: Float
                public let status: Int
            }
        }
    }
}

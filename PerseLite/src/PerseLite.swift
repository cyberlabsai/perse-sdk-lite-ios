/**
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * Perse SDK Lite iOS
 * More About: https://www.getperse.com/
 * From CyberLabs.AI: https://cyberlabs.ai/
 * Haroldo Teruya @ Cyberlabs AI 2021
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 */

import UIKit

/**
 * This class has the classes responsible to call the API and retrieve the Data.
 */
open class PerseLite {

    public struct Error {
        public static let INVALID_IMAGE_PATH = "INVALID_IMAGE_PATH"
    }

    static var apiKey: String!
    static var url: String = "https://api.getperse.com/v0/"

    public var face = Face()

    public init(apiKey: String) {
        PerseLite.apiKey = apiKey
    }
}

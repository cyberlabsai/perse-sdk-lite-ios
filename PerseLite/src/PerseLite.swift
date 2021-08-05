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
    static var url: String!

    public var face = Face()

    /**
     *  Constructor to initialize the Perse class and Retrofit API instance.
     */
    public init(apiKey: String, baseUrl: String = "https://api.getperse.com/v0/") {
        PerseLite.apiKey = apiKey
        PerseLite.url = baseUrl
    }
}

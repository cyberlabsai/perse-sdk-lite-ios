import UIKit

public class PerseLite {

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

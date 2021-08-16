import Foundation

public enum Environment {
    private static let infoDictionary: [String: Any] = {        
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    public static let apiKey: String = {
        guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
            fatalError("PerseLite API Key not set in plist for this environment")
        }
        return apiKey
    }()
    
    public static let baseUrl: String = {
        guard let apiKey = Environment.infoDictionary["BASE_URL"] as? String else {
            fatalError("PerseLite base url not set in plist for this environment")
        }
        return apiKey
    }()
}

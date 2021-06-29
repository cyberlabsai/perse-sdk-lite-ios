import Foundation

public enum Environment {
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()

  static let url: String = {
    guard let rootURLstring = Environment.infoDictionary["URL"] as? String else {
      fatalError("PerseLite URL not set in plist for this environment")
    }
    guard let url = URL(string: rootURLstring) else {
      fatalError("PerseLite URL is invalid")
    }
    return rootURLstring
  }()

  static let apiKey: String = {
    guard let apiKey = Environment.infoDictionary["API_KEY"] as? String else {
      fatalError("PerseLite API Key not set in plist for this environment")
    }
    return apiKey
  }()
}

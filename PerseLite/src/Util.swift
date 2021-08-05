/**
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * Perse SDK Lite iOS
 * More About: https://www.getperse.com/
 * From CyberLabs.AI: https://cyberlabs.ai/
 * Haroldo Teruya @ Cyberlabs AI 2021
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 */

import Foundation
import Alamofire

extension URL {
    public func name() -> String {
        return self
            .deletingPathExtension()
            .lastPathComponent
            .appending(".")
            .appending(self.pathExtension)                
    }
}

extension Data {
    
    public func detectResponse() throws -> DetectResponse {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: DetectResponse = try decoder.decode(
                DetectResponse.self,
                from: self
            )
            return response
        } catch(let error) {
          throw error
        }
    }
    
    public func compareResponse() throws -> CompareResponse {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: CompareResponse = try decoder.decode(
                CompareResponse.self,
                from: self
            )
            return response
        } catch(let error) {
          throw error
        }
    }
    
    public func compare402Response() throws -> Compare402Response {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: Compare402Response = try decoder.decode(
                Compare402Response.self,
                from: self
            )
            
            return response
        } catch(let error) {
          throw error
        }
    }
}

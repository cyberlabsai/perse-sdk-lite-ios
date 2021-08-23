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
    
    public func detectResponse() throws -> PerseAPIResponse.Face.Detect {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: PerseAPIResponse.Face.Detect = try decoder.decode(
                PerseAPIResponse.Face.Detect.self,
                from: self
            )
            return response
        } catch(let error) {
          throw error
        }
    }
    
    public func compareResponse() throws -> PerseAPIResponse.Face.Compare {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: PerseAPIResponse.Face.Compare = try decoder.decode(
                PerseAPIResponse.Face.Compare.self,
                from: self
            )
            return response
        } catch(let error) {
          throw error
        }
    }
    
    public func compare402Response() throws -> PerseAPIResponse.Face.Compare402 {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
            let response: PerseAPIResponse.Face.Compare402 = try decoder.decode(
                PerseAPIResponse.Face.Compare402.self,
                from: self
            )
            
            return response
        } catch(let error) {
          throw error
        }
    }
}

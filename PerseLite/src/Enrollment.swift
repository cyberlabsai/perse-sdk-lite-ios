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

/**
 * This class has the functions responsible to handle the user registers by face:
 * - Create;
 * - Read;
 * - Update;
 * - Delete;
 */
public class Enrollment {
    
    public func create(
        _ filePath: String,
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Create) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        guard let url = URL(string: filePath) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }

        self.create(
            data,
            onSuccess: onSuccess,
            onError: onError
        )
    }

    public func create(
        _ data: Data,
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Create) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/enrollment")
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "x-api-key" : PerseLite.apiKey,
            "Accept": "application/json"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(
                    data,
                    withName: "image_file",
                    fileName: "image_file",
                    mimeType: "image/jpeg"
                )
            },
            to: to,
            method: .post,
            headers: headers
        ).responseString {
            result in

            guard let uploadResponse: HTTPURLResponse = result.response else {
                return
            }
            
            if uploadResponse.statusCode == 200 {
                do {
                    guard let detectResponse: PerseAPIResponse.Face.Enrollment.Create = try result.data?.createResponse() else {
                        return
                    }
                    onSuccess(detectResponse)
                } catch let error {
                    onError("\(error)", "")
                }
            } else {
                onError("\(uploadResponse.statusCode)", "")
            }
        }
    }
    
    public func update(
        _ filePath: String,
        _ userToken: String,
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Update) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        guard let url = URL(string: filePath) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }

        self.update(
            data,
            userToken,
            onSuccess: onSuccess,
            onError: onError
        )
    }

    public func update(
        _ data: Data,
        _ userToken: String,
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Update) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/enrollment")
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "x-api-key" : PerseLite.apiKey,
            "Accept": "application/json"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(
                    data,
                    withName: "image_file",
                    fileName: "image_file",
                    mimeType: "image/jpeg"
                )
                multipartFormData.append(
                    userToken.data(using: String.Encoding.utf8, allowLossyConversion: false)!,
                    withName: "user_token"
                )
            },
            to: to,
            method: .put,
            headers: headers
        ).responseString {
            result in

            guard let response: HTTPURLResponse = result.response else {
                return
            }
            
            if response.statusCode == 200 {
                do {
                    guard let uploadResponse: PerseAPIResponse.Face.Enrollment.Update = try result.data?.uploadResponse() else {
                        return
                    }
                    onSuccess(uploadResponse)
                } catch let error {
                    onError("\(error)", "")
                }
            } else {
                onError("\(response.statusCode)", "")
            }
        }
    }
    
    public func read(
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Read) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/enrollment/list")
        let headers: HTTPHeaders = [
            "x-api-key" : PerseLite.apiKey,
            "Accept": "application/json"
        ]
        
        AF.request(
            to,
            method: .get,
            headers: headers
        ).responseString {
            result in
            
            guard let response: HTTPURLResponse = result.response else {
                return
            }
                              
            if response.statusCode == 200 {
                do {
                    guard let response: PerseAPIResponse.Face.Enrollment.Read = try result.data?.readResponse() else {
                        return
                    }
                    onSuccess(response)
                } catch let error {
                    onError("\(error)", "")
                }
            } else {
                onError("\(response.statusCode)", "")
            }
        }
    }
    
    public func delete(
        _ userToken: String,
        onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Delete) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/enrollment/\(userToken)")
        let headers: HTTPHeaders = [
            "x-api-key" : PerseLite.apiKey,
            "Accept": "application/json"
        ]
        
        AF.request(
            to,
            method: .delete,
            headers: headers
        ).responseString {
            result in
            
            guard let response: HTTPURLResponse = result.response else {
                return
            }
                              
            if response.statusCode == 200 {
                do {
                    guard let response: PerseAPIResponse.Face.Enrollment.Delete = try result.data?.deleteResponse() else {
                        return
                    }
                    onSuccess(response)
                } catch let error {
                    onError("\(error)", "")
                }
            } else {
                onError("\(response.statusCode)", "")
            }
        }
    }
}

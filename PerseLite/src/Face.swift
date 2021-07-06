import Foundation
import Alamofire

public class Face {

    public func detect(
        _ filePath: String,
        onSuccess: @escaping (DetectResponse) -> Void,
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

        self.detect(data, onSuccess: onSuccess, onError: onError)
    }

    public func detect(
        _ data: Data,
        onSuccess: @escaping (DetectResponse) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/detect")
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
                    guard let detectResponse: DetectResponse = try result.data?.detectResponse() else {
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

    public func compare(
        _ firstFilePath: String,
        _ secondFilePath: String,
        onSuccess: @escaping (CompareResponse) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        guard let firstUrl = URL(string: firstFilePath) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }
        guard let secondUrl = URL(string: secondFilePath) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }
        guard let firstData = try? Data(contentsOf: firstUrl) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }
        guard let secondData = try? Data(contentsOf: secondUrl) else {
            onError(PerseLite.Error.INVALID_IMAGE_PATH, "")
            return
        }

        self.compare(
            firstData,
            secondData,
            onSuccess: onSuccess,
            onError: onError
        )
    }

    public func compare(
        _ firstFile: Data,
        _ secondFile: Data,
        onSuccess: @escaping (CompareResponse) -> Void,
        onError: @escaping (String, String) -> Void
    ) {
        let to = PerseLite.url.appending("face/compare")
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "x-api-key" : PerseLite.apiKey,
            "Accept": "application/json"
        ]

        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(
                    firstFile,
                    withName: "image_file1",
                    fileName: "image_file1",
                    mimeType: "image/jpeg"
                )
                multipartFormData.append(
                    secondFile,
                    withName: "image_file2",
                    fileName: "image_file2",
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

            switch uploadResponse.statusCode {
            case 200:
                do {
                    guard let compareResponse: CompareResponse = try result.data?.compareResponse() else {
                        return
                    }
                    onSuccess(compareResponse)
                } catch let error {
                    onError("\(error)", "")
                }
                return
                    
            case 402:
                do {
                    guard let response: Compare402Response = try result.data?.compare402Response() else {
                        return
                    }
                    onError("\(uploadResponse.statusCode)", response.message)
                } catch let error {
                    onError("\(error)", "")
                }
                return
                
            default: onError("\(uploadResponse.statusCode)", "")
            }
        }
    }

}

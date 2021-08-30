import Foundation
import UIKit

enum FileUtilsError: Error {
    case invalidJPEGData
}

func getTempFilePath(name: String) -> String? {
    guard let fileUrl: URL = Bundle(for: FaceDetectWithFileTests.self)
        .url(
            forResource: name,
            withExtension: "jpeg"
        ) else {
        return nil
    }

    let tempImagePathUrl: URL = FileManager
        .default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
        .appendingPathComponent("perse-lite-demo-\(name).jpg")

    do {
        guard let image = UIImage(contentsOfFile: fileUrl.path) else {
            return nil
        }
        return try save(
            image: image,
            fileUrl: tempImagePathUrl
        )
    } catch {
        return nil
    }
}

func save(image: UIImage, fileUrl: URL) throws -> String {
    guard let data = image.jpegData(compressionQuality: 1) else {
        throw FileUtilsError.invalidJPEGData
    }

    do {
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            try FileManager.default.removeItem(atPath: fileUrl.path)
        }

        try data.write(to: fileUrl)

        return fileUrl.standardizedFileURL.absoluteString
    } catch {
        throw FileUtilsError.invalidJPEGData
    }
}

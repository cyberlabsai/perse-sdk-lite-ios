import Foundation
import UIKit

enum FileUtilsError: Error {
    case invalidJPEGData
}

func getTempfileUrl(_ index: Int = 0) -> URL {
    let tempDirectory = FileManager
        .default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!

    return tempDirectory.appendingPathComponent("\(index)perse-lite-demo.jpg")
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

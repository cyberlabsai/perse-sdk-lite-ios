import Foundation
import UIKit

func getTempData(name: String) -> Data? {
    guard let fileUrl: URL = Bundle(for: FaceDetectWithDataTests.self)
        .url(
            forResource: name,
            withExtension: "jpeg"
        ) else {
        return nil
    }

    guard let image = UIImage(contentsOfFile: fileUrl.path) else {
        return nil
    }

    return image.jpegData(compressionQuality: 1.0)
}

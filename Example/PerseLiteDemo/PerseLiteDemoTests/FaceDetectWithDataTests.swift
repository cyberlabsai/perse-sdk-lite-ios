import XCTest
import PerseLite
import Foundation

class FaceDetectWithDataTests: XCTestCase {

    func test_with_human() {
        detectWithData(
            self,
            imageName: "human",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTAssertEqual(detectResponse.totalFaces, 1)
        } onError: { error in
            XCTFail("Error on detect: \(error)")
        }
    }

    func test_with_non_human() {
        detectWithData(
            self,
            imageName: "dog",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTAssertEqual(detectResponse.totalFaces, 0)
        } onError: { error in
            XCTFail("Error on detect: \(error)")
        }
    }

    func test_with_image_path_invalid() {
        detectWithData(
            self,
            imageName: "test",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTFail("")
        } onError: { error in
            XCTAssertEqual(
                error,
                PerseLite.Error.INVALID_IMAGE_PATH
            )
        }
    }
}

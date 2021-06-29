import XCTest
import PerseLite
import Foundation

class PerseLiteFaceDetectWithFileTests: XCTestCase {

    func testWithHuman() {
        detectWithFile(
            self,
            imageName: "human",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTAssertEqual(detectResponse.totalFaces, 1)
        } onError: { error in
            XCTFail("Error on detect: \(error)")
        }
    }

    func testWithNonHuman() {
        detectWithFile(
            self,
            imageName: "dog",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTAssertEqual(detectResponse.totalFaces, 0)
        } onError: { error in
            XCTFail("Error on detect: \(error)")
        }
    }

    func testWithAPIKeyInvalid() {
        detectWithFile(
            self,
            imageName: "human",
            apiKey: ""
        ) { detectResponse in
            XCTFail("Back-end authorized invalid api token.")
        } onError: { error in
            XCTAssertEqual(error, "403")
        }
    }

    func testWithImagePathInvalid() {
        detectWithFile(
            self,
            imageName: "test",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTFail("")
        } onError: { error in
            XCTAssertEqual(error, PerseLite.Error.INVALID_IMAGE_PATH)
        }
    }
}

import XCTest
import PerseLite
import Foundation

class PerseLiteFaceDetectWithDataTests: XCTestCase {

    func testWithHuman() {
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

    func testWithNonHuman() {
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

    func testWithAPIKeyInvalid() {
        detectWithData(
            self,
            imageName: "human",
            apiKey: ""
        ) { detectResponse in
            XCTFail("Back-end authorized invalid api token.")
        } onError: { error in
            XCTAssertEqual(error, "401")
        }
    }

    func testWithImagePathInvalid() {
        detectWithData(
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

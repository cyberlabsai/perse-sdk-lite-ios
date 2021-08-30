import XCTest
import PerseLite
import Foundation

class FaceCompareWithFileTests: XCTestCase {

    func test_with_same_human() {
        compareWithFile(
            self,
            firstImageName: "human",
            secondImageName: "human1",
            apiKey: Environment.apiKey
        ) { response in
            XCTAssertEqual(response.status, 200)
            XCTAssertGreaterThan(
                response.similarity,
                response.defaultThresholds.similarity
            )
        } onError: { error in
            XCTFail("Error on compare: \(error)")
        }
    }

    func test_with_different_humans() {
        compareWithFile(
            self,
            firstImageName: "human1",
            secondImageName: "human2",
            apiKey: Environment.apiKey
        ) { response in
            XCTAssertEqual(response.status, 200)
            XCTAssertLessThan(
                response.similarity,
                response.defaultThresholds.similarity
            )
        } onError: { error in
            XCTFail("Error on compare: \(error)")
        }
    }

    func test_with_human_and_non_human() {
        compareWithFile(
            self,
            firstImageName: "human",
            secondImageName: "dog",
            apiKey: Environment.apiKey
        ) { response in
            XCTFail("Found invalid face in non human image.")
        } onError: { error in
            XCTAssertEqual(error, "402")
        }
    }

    func test_with_non_human_and_human() {
        compareWithFile(
            self,
            firstImageName: "dog",
            secondImageName: "human",
            apiKey: Environment.apiKey
        ) { response in
            XCTFail("Found invalid face in non human image.")
        } onError: { error in
            XCTAssertEqual(error, "402")
        }
    }

    func test_with_non_human_and_non_human() {
        compareWithFile(
            self,
            firstImageName: "dog",
            secondImageName: "dog",
            apiKey: Environment.apiKey
        ) { response in
            XCTFail("Found invalid face in non human image.")
        } onError: { error in
            XCTAssertEqual(error, "402")
        }
    }

    func test_with_image_paths_invalid() {
        compareWithFile(
            self,
            firstImageName: "test0",
            secondImageName: "test1",
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

    func test_with_non_humans() {
        compareWithFile(
            self,
            firstImageName: "dog",
            secondImageName: "dog",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTFail("")
        } onError: { error in
            XCTAssertEqual(error, "402")
        }
    }

}

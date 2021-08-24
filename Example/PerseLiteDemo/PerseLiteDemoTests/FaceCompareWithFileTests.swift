import XCTest
import PerseLite
import Foundation

class FaceCompareWithFileTests: XCTestCase {

    func testWithSameHuman() {
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

    func testWithDifferentHumans() {
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

    func testWithHumanAndNonHuman() {
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

    func testWithNonHumanAndHuman() {
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

    func testWithNonHumanAndNonHuman() {
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

    func testWithAPIKeyInvalid() {
        compareWithFile(
            self,
            firstImageName: "human",
            secondImageName: "human2",
            apiKey: ""
        ) { detectResponse in
            XCTFail("Back-end authorized invalid api token.")
        } onError: { error in
            XCTAssertEqual(error, "401")
        }
    }

    func testWithImagePathsInvalid() {
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

    func testWithNonHumans() {
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

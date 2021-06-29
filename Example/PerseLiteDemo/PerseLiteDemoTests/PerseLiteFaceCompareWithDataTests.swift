import XCTest
import PerseLite
import Foundation

class PerseLiteFaceCompareWithDataTests: XCTestCase {

    func testWithSameHuman() {
        compareWithData(
            self,
            firstImageName: "human",
            secondImageName: "human1",
            apiKey: Environment.apiKey
        ) { response in
            XCTAssertEqual(response.status, 200)
            XCTAssertGreaterThan(response.similarity, 70.0)
        } onError: { error in
            XCTFail("Error on compare: \(error)")
        }
    }

    func testWithDifferentHumans() {
        compareWithData(
            self,
            firstImageName: "human1",
            secondImageName: "human2",
            apiKey: Environment.apiKey
        ) { response in
            XCTAssertEqual(response.status, 200)
            XCTAssertLessThan(response.similarity, 80.0)
        } onError: { error in
            XCTFail("Error on compare: \(error)")
        }
    }

    func testWithHumanAndNonHuman() {
        compareWithData(
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
        compareWithData(
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
        compareWithData(
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
        compareWithData(
            self,
            firstImageName: "human",
            secondImageName: "human2",
            apiKey: ""
        ) { detectResponse in
            XCTFail("Back-end authorized invalid api token.")
        } onError: { error in
            XCTAssertEqual(error, "403")
        }
    }

    func testWithImagePathsInvalid() {
        compareWithData(
            self,
            firstImageName: "test0",
            secondImageName: "test1",
            apiKey: Environment.apiKey
        ) { detectResponse in
            XCTFail("")
        } onError: { error in
            XCTAssertEqual(error, PerseLite.Error.INVALID_IMAGE_PATH)
        }
    }

    func testWithNonHumans() {
        compareWithData(
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

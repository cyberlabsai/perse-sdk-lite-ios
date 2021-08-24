import XCTest
import PerseLite
import Foundation

class FaceEnrollmentTests: XCTestCase {

    func test_enrollment_face_create_and_delete() {
        var userToken: String? = nil
        
        faceCreate(
            self,
            imageName: "human",
            apiKey: Environment.apiKey
        ) { response in
            userToken = response.userToken
            debugPrint("Created user token: " + userToken!)
        } onError: { error in
            XCTFail("Error on face create: \(error)")
        }
        
        faceRead(
            self,
            apiKey: Environment.apiKey
        ) { response in
            debugPrint("Read user tokens: \(response.totalUsers)")
        } onError: { error in
            XCTFail("Error on face read: \(error)")
        }
        
        faceDelete(
            self,
            userToken: userToken!,
            apiKey: Environment.apiKey
        ) { response in
            debugPrint("Delete status: \(response.status)")
            XCTAssertEqual(response.status, 200)
        } onError: { error in
            XCTFail("Error on face read: \(error)")
        }
    }
}

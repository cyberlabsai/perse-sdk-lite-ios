import XCTest
import PerseLite
import Foundation

public func detectWithFile(
    _ xctest: XCTestCase,
    imageName: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Detect) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face detect in a image.")

    // Create a temp file image path from a resource.
    guard let tempFilePath: String = getTempFilePath(name: imageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }

    // Start the face detect process.
    PerseLite(apiKey: apiKey, baseUrl: Environment.baseUrl)
        .face
        .detect(tempFilePath)
    {
        detectResponse in
        onSuccess(detectResponse)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func detectWithData(
    _ xctest: XCTestCase,
    imageName: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Detect) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face detect in a image.")

    // Get a temp data from a resource.
    guard let data: Data = getTempData(name: imageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }
    
    // Start the face detect process.
    PerseLite(apiKey: apiKey, baseUrl: Environment.baseUrl)
        .face
        .detect(data)
    {
        detectResponse in
        onSuccess(detectResponse)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func compareWithFile(
    _ xctest: XCTestCase,
    firstImageName: String,
    secondImageName: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Compare) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face compare.")

    // Create a temp file image path from a resource.
    guard let firstTempFilePath: String = getTempFilePath(name: firstImageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }

    // Create a temp file image path from a resource.
    guard let secondTempFilePath: String = getTempFilePath(name: secondImageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }

    // Start the face detect process.
    PerseLite(apiKey: apiKey, baseUrl: Environment.baseUrl)
        .face
        .compare(
            firstTempFilePath,
            secondTempFilePath
        ) {
        compareResponse in
        onSuccess(compareResponse)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func compareWithData(
    _ xctest: XCTestCase,
    firstImageName: String,
    secondImageName: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Compare) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face compare.")

    // Get data from file image path from a resource.
    guard let firstData: Data = getTempData(name: firstImageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }

    // Get data from file image path from a resource.
    guard let secondData: Data = getTempData(name: secondImageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }

    // Start the face detect process.
    PerseLite(apiKey: apiKey, baseUrl: Environment.baseUrl)
        .face
        .compare(
            firstData,
            secondData
        ) {
        compareResponse in
        onSuccess(compareResponse)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func faceCreate(
    _ xctest: XCTestCase,
    imageName: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Create) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face create.")

    // Get a temp data from a resource.
    guard let data: Data = getTempData(name: imageName) else {
        onError(PerseLite.Error.INVALID_IMAGE_PATH)
        expectation.fulfill()
        return
    }
    
    // Start the face detect process.
    PerseLite(
        apiKey: apiKey,
        baseUrl: Environment.baseUrl
    )
        .face
        .enrollment
        .create(data)
    {
        response in
        onSuccess(response)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func faceRead(
    _ xctest: XCTestCase,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Read) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face read.")

    // Start the face detect process.
    PerseLite(apiKey: apiKey, baseUrl: Environment.baseUrl)
        .face
        .enrollment
        .read()
    {
        response in
        onSuccess(response)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

public func faceDelete(
    _ xctest: XCTestCase,
    userToken: String,
    apiKey: String,
    onSuccess: @escaping (PerseAPIResponse.Face.Enrollment.Delete) -> Void,
    onError: @escaping (String) -> Void
) {
    let expectation = XCTestExpectation(description: "PerseLite face delete.")
    
    // Start the face detect process.
    PerseLite(
        apiKey: apiKey,
        baseUrl: Environment.baseUrl
    )
        .face
        .enrollment
        .delete(userToken)
    {
        response in
        onSuccess(response)
        expectation.fulfill()
        return
    } onError: {
        status, error in
        onError(status)
        expectation.fulfill()
        return
    }

    // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
    xctest.wait(for: [expectation], timeout: 10.0)
}

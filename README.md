
# Perse SDK Lite iOS
From [CyberLabs.AI](https://cyberlabs.ai/).  
_Ready to go biometric verification for the internet._

The Perse CocoaPods SDK Lite:
* Top notch facial detection model;
* Anti-spoofing;
* Feedback on image quality;
* Compare the similarity between two faces;
* Doesn't store any photos;

<img src="perseLite.gif" width="300" />

For more details, you can see the [Official Perse](https://www.getperse.com/).

> #### Soon voice biometric verification.

## Content of Table

* [About](#about)
* [Get Started](#get-started)
  * [Install](#install)
  * [Get API Key](#get-api-key)
  * [Demo](#demo)
* [Usage](#usage)
  * [Face Detect](#face-detect)
  * [Face Compare](#face-compare)
  * [Camera Integration](#camera-integration)
  * [Running Tests](#running-tests)
* [API](#api)
  * [Methods](#methods)
    * [face.detect](#face.detect)
    * [face.compare](#face.compare)
  * [Responses](#responses)
  * [Errors](#errors)
* [To Contribute and Make It Better](#to-contribute-and-make-it-better)

## About

This SDK provides abstracts the communication with the Perse's API endpoints and also convert the response from json to a pre-defined [responses](#responses).

> #### Want to test the endpoints?
> You can test our endpoints using this [Swagger UI Playground](https://api.getperse.com/swagger/).

> #### Want to test a web live demo?
> You can test our web live demos in the [CyberLabs.AI CodePen](https://codepen.io/cyberlabsai) or in the [Perse Oficial Docs](https://docs.getperse.com/sdk-js/demo.html#authentication-demo
). Do not forget your [API Key](#get-api-key).

> #### Want to try a backend client?
> We have some examples in `Python`, `Go` and `javaScript`.
> You can see documented [here](https://docs.getperse.com/face-api/#introduction).

## Get Started

### Install

1. Create a [Podfile](https://guides.cocoapods.org/using/the-podfile.html). You may need install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#toc_3) in your environment.

2. Add the following line to your `Podfile` file:

```
pod 'PerseLite'
```

3. And run in the project root the following command line:

```
pod install
```

4. Now, you can open and build your project with the extension `.xcworkspace`;

> #### How to create a  Xcode project with CocoaPods?
> To create a Xcode project with CocoaPods you can see in the [Official CocoaPods Guide](https://guides.cocoapods.org/using/using-cocoapods.html#creating-a-new-xcode-project-with-cocoapods).

### API Key

Perse API authenticates your requests using an API Key.  
We are currently in Alpha. So you can get your API Key:
1. Sending an email to [developer@getperse.com](mailto:%20developer@getperse.com);
2. Or in the Perse official site [https://www.getperse.com/](https://www.getperse.com/);

### Demo

We have a [Demo](/Example/PerseLiteDemo)  in this repository for you:
* Feel free to change the Demo code;
* Not forget to get your [API KEY](#api-key);
* To run, the Demo, it is necessary to follow the [Install](#install) steps;

## Usage

### Face Detect

Detect allows you process images with the intent of detecting human faces.

```swift
import PerseLite

func detect(_ file: String) {
    let perseLite = PerseLite(apiKey: "API_KEY")

    perseLite.face.detect(filePath) {
        detectResponse in
        debugPrint(detectResponse)
    } onError: {
        error in
        debugPrint(error)
    }
}
```

### Face Compare

Compare accepts two sources for similarity comparison.

```swift
import PerseLite

func compare(
    _ firstFile: String,
    _ secondFile: String
) {
    let perseLite = PerseLite(apiKey: "API_KEY")

    perseLite.face.compare(
        firstFilePath,
        secondFilePath
    ) {
        compareResponse in
        debugPrint(compareResponse)
    } onError: {
        error in        
        debugPrint(error)
    }
}
```

### Camera Integration

Here we have a example in code how to detect a face from a camera. See the complete code in the [Demo](/Example/PerseLiteDemo) application.  
Just follow the Installation in the [`Yoonit Camera`](https://github.com/Yoonit-Labs/ios-yoonit-camera).

```swift
import UIKit
import PerseLite
import YoonitCamera

class PerseLiteCameraViewController:
    UIViewController,
    CameraEventListenerDelegate
{
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cameraView.cameraEventListener = self
        self.cameraView.startPreview()
        self.cameraView.setSaveImageCaptured(true)
        self.cameraView.setTimeBetweenImages(300)
        self.cameraView.startCaptureType("frame")
    }

    func onImageCaptured(
        _ type: String,
        _ count: Int,
        _ total: Int,
        _ imagePath: String,
        _ darkness: NSNumber?,
        _ lightness: NSNumber?,
        _ sharpness: NSNumber?
    ) {
        self.perseLite.face.detect(imagePath) {
            detectResponse in
            debugPrint(detectResponse)                        
        } onError: {
            error in
            debugPrint(error)
        }
    }

    ...
}
```

### Running Tests

Important:
* Need a [API KEY](#api-key);
* Need the [XCode IDE](https://developer.apple.com/xcode/);

You access it by clicking its icon in the navigator selector bar, located between the issue navigator and the debug navigator. When you have a project with a suite of tests defined, you see a navigator view similar to the one shown here.

<img src="https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/Art/twx-qs-1_2x.png" width="236" height="402" />

## API

This section describes the Perse SDK Lite iOS API's, [methods](#methods), your [responses](#responses) and possible [errors](#errors).

### Methods

The Perse is in `alpha` version and for now, only the `Face` module is available.

#### face.detect

* Has the intent of detecting any number of human faces;
* Can use this resource to evaluate the overall quality of the image;
* The input can be the image file path or his [Data](https://developer.apple.com/documentation/foundation/data);
* The `onSuccess` return type is [DetectResponse](#detectresponse) struct;
* The `onError` return type can see in the [Errors](#errors);

```swift
func detect(
    _ filePath: String,
    onSuccess: @escaping (DetectResponse) -> Void,
    onError: @escaping (String, String) -> Void
)
```

```swift
func detect(
    _ data: Data,
    onSuccess: @escaping (DetectResponse) -> Void,
    onError: @escaping (String, String) -> Void
)
```

#### face.compare

* Accepts two sources for similarity comparison;
* The inputs can be the image file paths or his [Data's](https://developer.apple.com/documentation/foundation/data);
* The `onSuccess` return type is [CompareResponse](#compareresponse) struct;
* The `onError` return type can see in the [Errors](#errors);

```swift
func compare(
    _ firstFilePath: String,
    _ secondFilePath: String,
    onSuccess: @escaping (CompareResponse) -> Void,
    onError: @escaping (String, String) -> Void
)
```

```swift
func compare(
    _ firstFile: Data,
    _ secondFile: Data,
    onSuccess: @escaping (CompareResponse) -> Void,
    onError: @escaping (String, String) -> Void
)
```

> #### Tip
> We recommend considering a match when similarity is above `71`.

### Responses

#### CompareResponse

| Attribute  | Type            | Description
| -          | -               | -
| similarity | `Float`         | Similarity between faces. Closer to `1` is better.
| imageTokens | `Array<String>` | The image tokens array.
| timeTaken  | `Float`         | Time taken to analyze the image.

#### DetectResponse

| Attribute    | Type                                | Description
| -            | -                                   | -
| totalFaces   | `Int`                               | Total of faces in the image.
| faces        | `Array<FaceResponse>`               | Array of [FaceResponse](#faceresponse).
| imageMetrics | [MetricsResponse](#metricsresponse) | Metrics of the detected image.
| imageToken   | `String`                            | The image token.
| timeTaken    | `Float`                             | Time taken to analyze the image.

#### FaceResponse

| Attribute   | Type                                    | Description
| -           | -                                       | -
| landmarks   | [LandmarksResponse](#landmarksresponse) |  Detected face landmarks.
| confidence  | `Int`                                     | Confidence that the face is a real face.
| boundingBox | `Array<Int>`                            | Array with the four values of the face bounding box. The coordinates `x`, `y` and the dimension `width` and `height` respectively.
| faceMetrics | [MetricsResponse](#metricsresponse)     | Metrics of the detecting face.
| livenessScore | `Long`                                  | Confidence that a detected face is from a live person (1 means higher confidence).

#### MetricsResponse

| Attribute   | Type    | Description
| -           | -       | -
| underexpose | `Float` | Indicates loss of shadow detail. Closer to `0` is better.
| overexpose  | `Float` | Indicates loss of highlight detail. Closer to `0` is better.
| sharpness   | `Float` | Indicates intensity of motion blur. Closer to `1` is better.

#### LandmarksResponse

| Attribute  | Type         | Description
| -          | -            | -
| rightEye   | `Array<Int>` | Right eye landmarks.
| leftEye    | `Array<Int>` | Left eye landmarks.
| nose       | `Array<Int>` | Nose landmarks.
| mouthRight | `Array<Int>` | Right side of mouth landmarks.
| mouthLeft  | `Array<Int>` | Left side of mouth landmarks.

### Errors

The `onError`:
* First parameter is the `Error Code`;
* Second parameter is a raw text message;

| Error Code | Description
| -          | -
| 400        | The request was unacceptable, often due to missing a required parameter.
| 401        | API key is missing or invalid.
| 402        | The parameters were valid but the request failed.
| 415        | The content type or encoding is not valid.

## To Contribute and Make It Better

Clone the repo, change what you want and send PR.  
For commit messages we use <a href="https://www.conventionalcommits.org/">Conventional Commits</a>.

Contributions are always welcome!

---

Made with ❤  by the [**Cyberlabs AI**](https://cyberlabs.ai/)

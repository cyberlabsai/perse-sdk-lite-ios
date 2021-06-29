import UIKit
import PerseLite
import YoonitCamera

class PerseLiteCameraViewController:
    UIViewController,
    UINavigationControllerDelegate,
    CameraEventListenerDelegate
{
    @IBOutlet var cameraView: CameraView!
    @IBOutlet var faceImageView: UIImageView!

    @IBOutlet var leftEyeLabel: UILabel!
    @IBOutlet var leftEyeIcon: UIImageView!

    @IBOutlet var rightEyeLabel: UILabel!
    @IBOutlet var rightEyeIcon: UIImageView!

    @IBOutlet var smilingLabel: UILabel!
    @IBOutlet var smillingIcon: UIImageView!

    @IBOutlet var horizontalMovementLabel: UILabel!
    @IBOutlet var verticalMovementLabel: UILabel!
    @IBOutlet var tiltMovementLabel: UILabel!

    @IBOutlet var faceUnderexposeLabel: UILabel!
    @IBOutlet var faceUnderexposeIcon: UIImageView!

    @IBOutlet var faceSharpnessLabel: UILabel!
    @IBOutlet var faceSharpnessIcon: UIImageView!

    @IBOutlet var imageUnderexposeLabel: UILabel!
    @IBOutlet var imageUnderexposeIcon: UIImageView!

    @IBOutlet var imageSharpnessLabel: UILabel!
    @IBOutlet var imageSharpnessIcon: UIImageView!

    let perseLite = PerseLite(apiKey: Environment.apiKey)
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.reset()

        self.cameraView.cameraEventListener = self
        self.cameraView.startPreview()
        self.cameraView.setSaveImageCaptured(true)
        self.cameraView.setDetectionBox(true)
        self.cameraView.setFaceContours(true)
        self.cameraView.setTimeBetweenImages(1000)
        self.cameraView.startCaptureType("face")
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
        let subpath = imagePath
            .substring(
                from: imagePath.index(
                    imagePath.startIndex,
                    offsetBy: 7
                )
            )
        let image = UIImage(contentsOfFile: subpath)
        self.faceImageView.image = image

        self.perseLite.face.detect(imagePath) {
            detectResponse in

            if detectResponse.totalFaces == 0 {
                self.reset()
                return
            }

            let face: FaceResponse = detectResponse.faces[0]

            self.setSpoofingValidation(valid: face.livenessScore >= 0.7)
            self.handleDisplayProbability(
                label: self.faceUnderexposeLabel,
                icon: self.faceUnderexposeIcon,
                validation: face.faceMetrics.underexpose > 0.7,
                value: face.faceMetrics.underexpose
            )
            self.handleDisplayProbability(
                label: self.faceSharpnessLabel,
                icon: self.faceSharpnessIcon,
                validation: face.faceMetrics.sharpness < 0.07,
                value: face.faceMetrics.sharpness
            )
            self.handleDisplayProbability(
                label: self.imageUnderexposeLabel,
                icon: self.imageUnderexposeIcon,
                validation: detectResponse.imageMetrics.underexpose > 0.7,
                value: detectResponse.imageMetrics.underexpose
            )
            self.handleDisplayProbability(
                label: self.imageSharpnessLabel,
                icon: self.imageSharpnessIcon,
                validation: detectResponse.imageMetrics.sharpness < 0.07,
                value: detectResponse.imageMetrics.sharpness
            )
        } onError: {
            error in
            debugPrint(error)
            self.reset()
        }
    }

    func setSpoofingValidation(valid: Bool) {
        valid
            ? self.cameraView.setDetectionBoxColor(
                1,
                0.1882352941,
                0.8196078431,
                0.3450980392
            )
            : self.cameraView.setDetectionBoxColor(1.0, 1, 0, 0)
        valid
            ? self.cameraView.setFaceContoursColor(
                1,
                0.1882352941,
                0.8196078431,
                0.3450980392
            )
            : self.cameraView.setFaceContoursColor(1.0, 1, 0, 0)
    }

    func onFaceDetected(
        _ x: Int,
        _ y: Int,
        _ width: Int,
        _ height: Int,
        _ leftEyeOpenProbability: NSNumber?,
        _ rightEyeOpenProbability: NSNumber?,
        _ smilingProbability: NSNumber?,
        _ headEulerAngleX: NSNumber?,
        _ headEulerAngleY: NSNumber?,
        _ headEulerAngleZ: NSNumber?
    ) {
        self.handleDisplayProbability(
            label: self.leftEyeLabel,
            icon: self.leftEyeIcon,
            value: leftEyeOpenProbability as? Float,
            validText: "Open",
            invalidText: "Close"
        )
        self.handleDisplayProbability(
            label: self.rightEyeLabel,
            icon: self.rightEyeIcon,
            value: rightEyeOpenProbability as? Float,
            validText: "Open",
            invalidText: "Close"
        )
        self.handleDisplayProbability(
            label: self.smilingLabel,
            icon: self.smillingIcon,
            value: smilingProbability as? Float,
            validText: "Smiling",
            invalidText: "Not Smiling"
        )
        if let angle = headEulerAngleX as? Float {
            var text = ""
            if angle < -36 {
                text = "Super Down"
            } else if -36 < angle && angle < -12 {
                text = "Down"
            } else if -12 < angle && angle < 12 {
                text = "Frontal"
            } else if 12 < angle && angle < 36 {
                text = "Up"
            } else if 36 < angle {
                text = "Super Up"
            }
            self.verticalMovementLabel.text = text
        }
        if let angle = headEulerAngleY as? Float {
            var text = ""
            if angle < -36 {
                text = "Super Left"
            } else if -36 < angle && angle < -12 {
                text = "Left"
            } else if -12 < angle && angle < 12 {
                text = "Frontal"
            } else if 12 < angle && angle < 36 {
                text = "Right"
            } else if 36 < angle {
                text = "Super Right"
            }
            self.horizontalMovementLabel.text = text
        }
        if let angle = headEulerAngleZ as? Float {
            var text = ""
            if angle < -36 {
                text = "Super Right"
            } else if -36 < angle && angle < -12 {
                text = "Right"
            } else if -12 < angle && angle < 12 {
                text = "Frontal"
            } else if 12 < angle && angle < 36 {
                text = "Left"
            } else if 36 < angle {
                text = "Super Left"
            }
            self.tiltMovementLabel.text = text
        }
    }

    func onFaceUndetected() {
        self.reset()
    }

    func onEndCapture() {}

    func onError(_ error: String) {}

    func onMessage(_ message: String) {}

    func onPermissionDenied() {}

    func onQRCodeScanned(_ content: String) {}

    func reset() {
        self.faceImageView.image = nil

        self.leftEyeLabel.text = "-"
        self.handleResetIcon(icon: self.leftEyeIcon)
        self.rightEyeLabel.text = "-"
        self.handleResetIcon(icon: self.rightEyeIcon)
        self.smilingLabel.text = "-"
        self.handleResetIcon(icon: self.smillingIcon)
        self.horizontalMovementLabel.text = "-"
        self.verticalMovementLabel.text = "-"
        self.tiltMovementLabel.text = "-"
        self.faceUnderexposeLabel.text = "-"
        self.handleResetIcon(icon: self.faceUnderexposeIcon)
        self.faceSharpnessLabel.text = "-"
        self.handleResetIcon(icon: self.faceSharpnessIcon)
        self.imageUnderexposeLabel.text = "-"
        self.handleResetIcon(icon: self.imageUnderexposeIcon)
        self.imageSharpnessLabel.text = "-"
        self.handleResetIcon(icon: self.imageSharpnessIcon)
        self.cameraView.setDetectionBoxColor(0, 1, 1, 1)
        self.cameraView.setFaceContoursColor(0, 1, 1, 1)
    }

    func handleResetIcon(icon: UIImageView) {
        icon.image = UIImage(systemName: "minus.circle.fill")
        icon.tintColor = UIColor.gray
    }

    func handleDisplayProbability(
        label: UILabel,
        icon: UIImageView,
        value: Float?,
        validText: String,
        invalidText: String
    ) {
        if let value: Float = value {
            let valid = value > 0.8

            label.text = value.toLabel()
            icon.image = valid
                ? UIImage(systemName: "checkmark.circle.fill")
                : UIImage(systemName: "multiply.circle.fill")
            icon.tintColor = valid
                ? UIColor.systemGreen
                : UIColor.systemRed
        }
    }

    func handleDisplayProbability(
        label: UILabel,
        icon: UIImageView,
        validation: Bool,
        value: Float?
    ) {
        if let value: Float = value {
            label.text = value.description
            icon.image = validation
                ? UIImage(systemName: "checkmark.circle.fill")
                : UIImage(systemName: "multiply.circle.fill")
            icon.tintColor = validation
                ? UIColor.systemGreen
                : UIColor.systemRed
        }
    }

    func flipImageLeftRight(_ image: UIImage) -> UIImage? {

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)

        let context = UIGraphicsGetCurrentContext()!

        context.translateBy(x: image.size.width, y: image.size.height)
        context.scaleBy(x: -image.scale, y: -image.scale)
        context.draw(image.cgImage!, in: CGRect(origin:CGPoint.zero, size: image.size))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return newImage
    }
}

class InsetLabel: UILabel {
    var textEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4) {
        didSet { invalidateIntrinsicContentSize() }
    }

    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
}

extension Float {
    func toLabel() -> String {
        return "\(String(format: "%.2f", self * 100))%"
    }

    func toText() -> String {
        return "\(String(format: "%.2f", self))"
    }
}

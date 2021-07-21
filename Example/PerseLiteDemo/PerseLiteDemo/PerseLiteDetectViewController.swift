import UIKit
import PerseLite

class PerseLiteDetectViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource
{
    let perseLite = PerseLite(apiKey: Environment.apiKey)
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!

    private var tablecells = Array<TableCell>()
    private let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: self.cellReuseIdentifier
        )
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return self.tablecells.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        var cell: UITableViewCell!

        if self.tablecells[indexPath.row].value.isEmpty {
            cell = UITableViewCell(
                style: .default,
                reuseIdentifier: self.cellReuseIdentifier
            )
            cell.backgroundColor = UIColor.lightGray
            cell.textLabel?.textColor = UIColor.white
        } else {
            cell = UITableViewCell(
                style: .value1,
                reuseIdentifier: self.cellReuseIdentifier
            )
            cell.textLabel?.textColor = UIColor.darkGray
            cell.detailTextLabel?.text = self.tablecells[indexPath.row].value
            cell.detailTextLabel?.textColor = UIColor.black
        }

        cell.textLabel?.text = self.tablecells[indexPath.row].label

        return cell
    }

    @IBAction func getImage() {
        let isAvailable = UIImagePickerController
            .isSourceTypeAvailable(.photoLibrary)
        if isAvailable {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary

            self.present(
                imagePicker,
                animated: true,
                completion: nil
            )
        }
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true, completion: nil)

        let infoKeyImage = UIImagePickerController
            .InfoKey
            .originalImage
        let image = info[infoKeyImage] as! UIImage
        let fileUrl: URL = getTempfileUrl()
        let filePath = try! save(
            image: image,
            fileUrl: fileUrl
        )

        DispatchQueue.main.async {
            self.imageView.image = image
            self.detect(filePath)
        }
    }

    func detect(_ filePath: String) {
        self.perseLite.face.detect(filePath) {
            detectResponse in

            self.tablecells.removeAll()

            self.tablecells.append(TableCell(
                "Detected faces",
                detectResponse.totalFaces
            ))

            guard let faces = detectResponse.faces as Array<FaceResponse>? else {
                return
            }
            
            var i = 0
            for face in faces {
                i = i + 1
                self.tablecells.append(TableCell("Face \(i)"))
                self.tablecells.append(TableCell(
                    "Liveness score",
                    face.livenessScore
                ))

                let boundingBox = face.boundingBox
                if !boundingBox.isEmpty {
                    self.tablecells.append(TableCell(
                        "Bounding box",
                        boundingBox.description
                    ))
                }
                self.tablecells.append(TableCell("Face Metrics \(i)"))
                self.tablecells.append(TableCell(
                    "Overexpose",
                    face.faceMetrics.overexpose
                ))
                self.tablecells.append(TableCell(
                    "Underexpose",
                    face.faceMetrics.underexpose
                ))
                self.tablecells.append(TableCell(
                    "Sharpness",
                    face.faceMetrics.sharpness
                ))
            }
            self.tablecells.append(TableCell("Image Metrics"))
            self.tablecells.append(TableCell(
                "Overexpose",
                detectResponse.imageMetrics.overexpose
            ))
            self.tablecells.append(TableCell(
                "Underexpose",
                detectResponse.imageMetrics.underexpose
            ))
            self.tablecells.append(TableCell(
                "Sharpness",
                detectResponse.imageMetrics.sharpness
            ))

            self.tableView.reloadData()
        } onError: {
            status, error in

            debugPrint(error)
        }
    }

}

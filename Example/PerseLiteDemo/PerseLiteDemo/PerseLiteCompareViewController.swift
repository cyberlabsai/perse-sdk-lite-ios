import UIKit
import PerseLite

class PerseLiteCompareViewController:
    UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate,
    UITableViewDelegate,
    UITableViewDataSource
{
    let perseLite = PerseLite(apiKey: Environment.apiKey)
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet var tableView: UITableView!
    private var tablecells = Array<TableCell>()
    private let cellReuseIdentifier = "cell"
    var imageIndex: Int = 0
    var firstFilePath: String?
    var secondFilePath: String?

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

        let cell = UITableViewCell(
            style: .value1,
            reuseIdentifier: self.cellReuseIdentifier
        )

        cell.textLabel?.text = self.tablecells[indexPath.row].label
        cell.textLabel?.textColor = UIColor.darkGray
        cell.detailTextLabel?.text = self.tablecells[indexPath.row].value
        cell.detailTextLabel?.textColor = UIColor.black

        return cell
    }

    @IBAction func getFirstImage() {
        self.imageIndex = 0
        self.getImage()
    }

    @IBAction func getSecondImage() {
        self.imageIndex = 1
        self.getImage()
    }

    func getImage() {
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
        let fileUrl: URL = getTempfileUrl(self.imageIndex)

        if self.imageIndex == 0 {
            self.firstFilePath = try! save(
                image: image,
                fileUrl: fileUrl
            )
            self.firstImageView.image = image
        } else {
            self.secondFilePath = try! save(
                image: image,
                fileUrl: fileUrl
            )
            self.secondImageView.image = image
        }
    }

    @IBAction func compare() {
        self.perseLite.face.compare(
            self.firstFilePath!,
            self.secondFilePath!
        ) {
            compareResponse in

            self.tablecells.removeAll()
            self.tablecells.append(TableCell(
                "Similarity",
                compareResponse.similarity
            ))
            var i = 0
            for imageToken in compareResponse.imageTokens {
                i = i + 1
                self.tablecells.append(TableCell(
                    "Image Token \(i)",
                    imageToken
                ))
            }
            self.tablecells.append(TableCell(
                "Time Taken",
                compareResponse.timeTaken
            ))
            self.tableView.reloadData()
        } onError: {
            error in

            debugPrint(error)
        }
    }
}

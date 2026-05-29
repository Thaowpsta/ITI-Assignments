//
//  AddProductViewController.swift
//  MovieList
//
//  Created by Thaowpsta Saiid on 03/05/2026.
//

import Foundation
import UIKit

protocol AddProductDelegate: AnyObject {
    func addProduct(product: Product)
}

class AddProductViewController: UIViewController,
    UIImagePickerControllerDelegate & UINavigationControllerDelegate
{

    weak var delegate: AddProductDelegate?

    let titleTextField = UITextField()
    let descTextField = UITextField()
    let categoryTextField = UITextField()
    let priceTextField = UITextField()
    let ratingTextField = UITextField()
    let productImageView = UIImageView()
    let selectImageButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "Add New Product"

        self.title = NSLocalizedString("Add New Product", comment: "")

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Done", comment: ""),
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )

        setupUI()
    }

    func setupUI() {
        // 1. Configure the image view so it looks nice
        productImageView.contentMode = .scaleAspectFill
        productImageView.backgroundColor = .systemGray5
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 8

        // 2. Configure the button and link it to your pickImage method
        selectImageButton.setTitle(
            NSLocalizedString("Select Product Image", comment: ""),
            for: .normal
        )
        selectImageButton.addTarget(
            self,
            action: #selector(pickImage),
            for: .touchUpInside
        )

        // 3. Add the image view and button to the top of the stack view
        let stackView = UIStackView(arrangedSubviews: [
            productImageView,
            selectImageButton,
            createTextField(
                textField: titleTextField,
                placeholder: NSLocalizedString("Product Title", comment: "")
            ),
            createTextField(
                textField: descTextField,
                placeholder: NSLocalizedString("Description", comment: "")
            ),
            createTextField(
                textField: categoryTextField,
                placeholder: NSLocalizedString("Category", comment: "")
            ),
            createTextField(
                textField: priceTextField,
                placeholder: NSLocalizedString(
                    "Price",
                    comment: ""
                ),
                keyboardType: .decimalPad
            ),
            createTextField(
                textField: ratingTextField,
                placeholder: NSLocalizedString(
                    "Rating",
                    comment: ""
                ),
                keyboardType: .decimalPad
            ),
        ])

        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            productImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }

    func createTextField(
        textField: UITextField,
        placeholder: String,
        keyboardType: UIKeyboardType = .default
    ) -> UITextField {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = keyboardType
        return textField
    }

    @objc func pickImage() {
        let imgPicker = UIImagePickerController()
        imgPicker.delegate = self

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: nil)
        } else {
            print("Photo library is not available")
        }
    }

    //    @IBAction func selectImageTapped(_ sender: UIButton) {
    //            let imgPicker = UIImagePickerController()
    //            imgPicker.delegate = self
    //
    //            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
    //                imgPicker.sourceType = .photoLibrary
    //                imgPicker.allowsEditing = true
    //                self.present(imgPicker, animated: true, completion: nil)
    //            } else {
    //                print("Photo library is not available")
    //            }
    //        }

    @objc func doneTapped() {
        var localImageName: String? = nil
        
        let title = titleTextField.text ?? "Unknown Product"
        let desc = descTextField.text ?? ""
        let category = categoryTextField.text ?? "Misc"
        let price = Double(priceTextField.text ?? "0.0") ?? 0.0
        let rating = Float(ratingTextField.text ?? "0.0") ?? 0.0

        if let selectedImage = self.productImageView.image {
                localImageName = saveImageLocally(image: selectedImage)
            }
        
        let newProduct = Product(
            title: title,
            description: desc,
            category: category,
            price: price,
            rating: rating,
            thumbnail: localImageName
        )

        delegate?.addProduct(product: newProduct)

        navigationController?.popViewController(animated: true)
    }

    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:
            Any]
    ) {

        if let editedImage = info[.editedImage] as? UIImage {
            productImageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            productImageView.image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

func saveImageLocally(image: UIImage) -> String? {
    guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
    
    let fileName = UUID().uuidString + ".jpg"
    
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    do {
        try data.write(to: fileURL)
        return fileName
    } catch {
        print("Error saving image: \(error)")
        return nil
    }
}

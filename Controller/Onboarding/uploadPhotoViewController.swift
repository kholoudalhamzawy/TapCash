import UIKit
import Vision
import PhotosUI
import Combine

class uploadPhotoViewController: UIViewController{
    
    private let viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        view.addSubview(ImageView)
        view.addSubview(uploadLbl)
        view.addSubview(submitBtn)

        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToUpload))) //adding an action for a view like a button
        configureConstraints()
        
    }
    
 
    //detect is the function to classify the image
    func detect(image: CIImage){
       
            guard let model = try? VNCoreMLModel(for: MyIDImageClassifier().model) else{
          
                fatalError("Loading CoreML Model Failed")
                
            }
       
        let request = VNCoreMLRequest(model: model){ (request, error) in
                
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            print(results)
          
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }catch {
            print(error)
        }
    }

        private let ImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(systemName: "tray.and.arrow.up")
            imageView.tintColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        private let uploadLbl: UILabel = {
            var view = UILabel()
            view.font = UIFont(name: "Poppins-Medium", size: 18)
            view.textAlignment = .center
            view.textColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            view.text = "Upload your id image from your gallery..."
            view.numberOfLines = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private let submitBtn: UIButton = {
            let btn = UIButton()
            btn.layer.cornerRadius = 21
            btn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 16)
            btn.titleLabel?.textAlignment = .center
            btn.layer.borderColor = #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1)
            btn.setTitleColor( #colorLiteral(red: 0.4, green: 0, blue: 0.6, alpha: 1), for: .normal)
            btn.layer.borderWidth = 0.5
            btn.setTitle("Uploud Image", for: .normal)
            btn.addTarget(self, action: #selector(didTapToUpload), for: .touchUpInside)
            btn.translatesAutoresizingMaskIntoConstraints = false
            return btn
        }()
      
    
        @objc private func didTapToUpload() {
            var configuration = PHPickerConfiguration()
            configuration.filter = .images //accepts only images
            configuration.selectionLimit = 1 //aceepts one image
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
        }
            

        private func configureConstraints() {
            
            let ImageViewConstraints = [
                ImageView.widthAnchor.constraint(equalToConstant: 100),
                ImageView.heightAnchor.constraint(equalToConstant: 100),
                ImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 230),
                ImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

            ]
            let uploadLabelConstraints = [
                uploadLbl.widthAnchor.constraint(equalToConstant: 330),
                uploadLbl.heightAnchor.constraint(equalToConstant: 70),
                uploadLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                uploadLbl.topAnchor.constraint(equalTo: ImageView.bottomAnchor, constant: 20)
            ]
            let submitBtnConstraints = [
                submitBtn.widthAnchor.constraint(equalToConstant: 177),
                submitBtn.heightAnchor.constraint(equalToConstant: 40),
                submitBtn.topAnchor.constraint(equalTo: uploadLbl.bottomAnchor, constant: 60),
                submitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
             
            ]
           
            NSLayoutConstraint.activate(ImageViewConstraints)
            NSLayoutConstraint.activate(uploadLabelConstraints)
            NSLayoutConstraint.activate(submitBtnConstraints)

        }

        }


        extension uploadPhotoViewController: PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            picker.dismiss(animated: true) //to eelect the image and dismiss the gallery picked from
            
            for result in results { //although we specified the results to be one image but it returns an array so we iterate throw it
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self?.ImageView.image = image
                            
                            guard let ciimage = CIImage(image: image) else {
                                fatalError("Could not convert UIImage into CIImage")

                            }
                            self?.detect(image: ciimage)
                            self?.viewModel.idImage = image
                            guard let vc = self?.navigationController?.viewControllers.first as? logInViewController else {return}
                            vc.dismiss(animated: true)
                        
                        }
                    }
                }
            }
        
        }


        }


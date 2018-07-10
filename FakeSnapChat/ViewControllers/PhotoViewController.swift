//
//  PhotoViewController.swift
//  FakeSnapChat
//
//  Created by Michael Zhou on 2018-07-06.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit
import Firebase


class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var snapImage: UIImageView!
    @IBOutlet weak var imageDescTextBox: UITextField!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        snapImage.image = image
        snapImage.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        print("Tapped next")
        nextButton.isEnabled = false
        let imgFolder = Storage.storage().reference().child("images")
        let imgData = UIImageJPEGRepresentation(snapImage.image!, 0.1)!
        imgFolder.child("\(NSUUID().uuidString).png").putData(imgData, metadata: nil) { (metadata, error) in
            print("Attempting to upload..")
            self.nextButton.setTitle("Uploading", for: .normal)
            if error != nil {
                print("Error!")
            } else {
                print("Success!")
                self.performSegue(withIdentifier: "selectUsersSegue", sender: nil)
            }
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .savedPhotosAlbum
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

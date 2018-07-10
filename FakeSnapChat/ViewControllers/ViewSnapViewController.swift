//
//  ViewSnapViewController.swift
//  FakeSnapChat
//
//  Created by Michael Zhou on 2018-07-10.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var snapLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snapLabel.text = snap.description
        imageView.sd_setImage(with: URL(string: snap.imageURL), placeholderImage: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

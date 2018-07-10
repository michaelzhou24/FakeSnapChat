//
//  SnapsViewController.swift
//  FakeSnapChat
//
//  Created by Michael Zhou on 2018-07-06.
//  Copyright © 2018 Michael Zhou. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded) { (snapshot) in
            print(snapshot)
            let snap = Snap()
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.description = (snapshot.value as! NSDictionary)["description"] as! String
            snap.key = snapshot.key
            self.snaps.append(snap)
            self.tableView.reloadData()
        }
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved) { (snapshot) in
            print(snapshot)
            let snap = Snap()
            snap.from = (snapshot.value as! NSDictionary)["from"] as! String
            snap.imageURL = (snapshot.value as! NSDictionary)["imageURL"] as! String
            snap.description = (snapshot.value as! NSDictionary)["description"] as! String
            snap.key = snapshot.key
            for i in 0...self.snaps.count - 1 {
                if self.snaps[i].key == snap.key {
                    self.snaps.remove(at: i)
                }
            }
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
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

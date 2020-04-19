//
//  UserUpdateUViewController.swift
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-30.
//  Copyright © 2020 Sherwin. All rights reserved.
//

import UIKit

class UserUpdateUViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    
    
    @IBOutlet weak var tfAge: UITextField!
    
    
    @IBOutlet weak var imagesPopulate: UIImageView!
    @IBOutlet weak var segmentedAvatar: UISegmentedControl!
    
    
    @IBOutlet weak var avatarPicked: UILabel!
    
    @IBOutlet weak var AvatarImage: UIImageView!
    
    var ImagesPopulated = ["car.png","bus.png","aircraft.jpg"]

    @IBAction func selectedImage(_ sender: UISegmentedControl) {
        let selctedValue = segmentedAvatar.selectedSegmentIndex
        
        if(selctedValue == 0)
        {
            avatarPicked.text = "Image Chosen is car";
            loadImages(position: selctedValue)
        }
        else if(selctedValue == 1)
        {
            avatarPicked.text = "Image Chosen is Bus";
            loadImages(position: selctedValue)
        }
        else if(selctedValue == 2)
        {
            avatarPicked.text = "Image Chosen is Plane";
            loadImages(position: selctedValue)
        }
        

    }
    
    func loadImages(position:Int)
    {
        let loadinImages = UIImage(named: ImagesPopulated[position])
        imagesPopulate.image = loadinImages
    }


     var foundUser : UsersClass?
    
    
    
    @IBAction func findUser(_ sender: UIButton) {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    

        
        if tfName.text == nil || tfName.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please do not leave the name field blank", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController,animated: true)
        } else {
            foundUser = mainDelegate.getUserByName(name: tfName.text!)
            
            if foundUser == nil {
                
                let alertController = UIAlertController(title: "Error", message: "User cannot be found", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController,animated: true)
                
                
            }else
            {
                
                let alertController = UIAlertController(title: "Confirmation", message: "User Has been Found Please continue", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController,animated: true)
                
                
            }
          
        }
        
        
    }
    
    
    
    @IBAction func updateUser(_ sender: Any) {
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
     
      
            
  
            
            if tfAge.text == nil || tfAge.text == "" {
                let alertController = UIAlertController(title: "Error", message: "Do not leave age field balnk", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController,animated: true)
            } else {
                let returnCode = mainDelegate.updateUserDetails(usersl: foundUser!, Avatar: avatarPicked.text!, Age: Int(tfAge.text!)!)
                
                var returnMessage = "User Detals Have been updated Successfully"
                if returnCode == false {
                    returnMessage = "Error Changing user Details"
                }
                
                let alertController = UIAlertController(title: "Success", message: returnMessage, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                present(alertController,animated: true)
                
            }
        }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

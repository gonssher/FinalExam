//
//  PickerViewController.swift
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-30.
//  Copyright © 2020 Sherwin. All rights reserved.
//

import UIKit

class PickerViewController:UIViewController,UIPickerViewDelegate,UIPickerViewDataSource  {
    
    
    @IBOutlet weak var tfname: UITextField!
    
    
    @IBOutlet weak var tfAge: UITextField!
    
    @IBOutlet weak var avatarSegment: UISegmentedControl!

    @IBOutlet weak var avatarPicked: UILabel!
    
    @IBOutlet weak var loadImages: UIImageView!

    var ImagesPopulate = ["car.png","bus.png","aircraft.jpg"]

    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func loadImages(position:Int)
    {
        let loadinImages = UIImage(named: ImagesPopulate[position])
        loadImages.image = loadinImages
    }
    
    @IBAction func avatarImagesValueChanged(_ sender: Any) {
        
        let selctedValue = avatarSegment.selectedSegmentIndex

        if(selctedValue == 0)
        {
            avatarPicked.isHidden = false;
            avatarPicked.text = "Image Chosen is car";
                 loadImages(position: selctedValue)
        }
        else if(selctedValue == 1)
        {
             avatarPicked.isHidden = false;
            avatarPicked.text = "Image Chosen is Bus";
                 loadImages(position: selctedValue)
        }
        else if(selctedValue == 2)
        {
             avatarPicked.isHidden = false;
            avatarPicked.text = "Image Chosen is Plane";
                 loadImages(position: selctedValue)
        }
        

    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         mainDelegate.readDataFromDatabase()
        return mainDelegate.user.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return mainDelegate.user[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let alertController = UIAlertController(title: mainDelegate.user[row].name, message: mainDelegate.user[row].avatar, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        present (alertController, animated: true)
    }
    
    
    @IBAction func InsertData(_ sender: UIButton) {

        let user : UsersClass = UsersClass(0, name: tfname.text! , age: Int32(tfAge.text!)!, avatar: avatarPicked.text!)
        
        
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate

        
        if (tfname.text!.isEmpty || tfAge.text!.isEmpty || avatarPicked.text!.isEmpty)
        {
            let alertController = UIAlertController(title: "Error", message: "Please don not leave any field blank", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController,animated: true)
            
        }
    
        else{
            let returnCode = mainDelegate.signUp(user: user)
            
            var returnMsg : String = "\(tfname.text!) has successfully been Registered"
            
            
            if returnCode == false
            {
                returnMsg = "Person Add Failed"
            }
            
            let alertController = UIAlertController(title: "Success", message: returnMsg, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "ok", style: .default)  { (_)-> Void in   self.performSegue(withIdentifier: "RegisterdtoHomePageSegue", sender: self) }
            alertController.addAction(cancelAction)
            present(alertController,animated: true)
             mainDelegate.readDataFromDatabase()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         avatarPicked.isHidden = true;
  let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        mainDelegate.readDataFromDatabase()
        
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

//
//  TableViewController.swift
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-30.
//  Copyright © 2020 Sherwin. All rights reserved.
//

import UIKit

class TableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
 

func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    
   
       return true
    }
 
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == UITableViewCell.EditingStyle.delete{

            tableView.reloadData()

            let alert = UIAlertController(title: "Confirmation", message: "Do you want to delete the following user \(mainDelegate.user[indexPath.row].name)?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let confimation = UIAlertAction(title: "Confirm", style: .default) {
                (action) in
                var context = self.mainDelegate.deleteUserFromTable(id: Int(self.mainDelegate.user[indexPath.row].id))
                if context == true{
                    self.mainDelegate.readDataFromDatabase()
                tableView.reloadData()
            }
            else
            {
                print("error")
                
            }
            }

            alert.addAction(cancelAction)
            alert.addAction(confimation)
            self.present(alert, animated: true)

        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.user.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default,reuseIdentifier : "cell")
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.user[rowNum].name
        tableCell.secondaryLabel.text = mainDelegate.user[rowNum].avatar
        
        if mainDelegate.user[rowNum].avatar == "Image Chosen is car" {
            tableCell.teamImageView.image = UIImage.init(named: "car.png")
        }
        else if mainDelegate.user[rowNum].avatar == "Image Chosen is Plane"
        {
            tableCell.teamImageView.image = UIImage(named: "aircraft.jpg")
        }
        else if  mainDelegate.user[rowNum].avatar == "Image Chosen is Bus"
        {
            tableCell.teamImageView.image = UIImage(named: "bus.png")
        }
        tableCell.accessoryType = .disclosureIndicator
        
        return tableCell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNum = indexPath.row
        let alertController = UIAlertController(title: mainDelegate.user[rowNum].name, message: mainDelegate.user[rowNum].avatar, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        
        alertController.addAction(cancelAction)
        present(alertController,animated:true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.readDataFromDatabase()
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

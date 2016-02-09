//
//  DetailViewController.swift
//  SortList
//
//  Created by mc373 on 08.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

class DetailViewControllerOLD: UIViewController {

    @IBOutlet weak var NewItemAddLabel: UITextField!
    
    var labelText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "doneSegue" {
            labelText = NewItemAddLabel.text!
        }
    }
    

}

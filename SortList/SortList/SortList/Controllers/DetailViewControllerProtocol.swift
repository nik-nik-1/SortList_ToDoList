//
//  DetailViewControllerProtocol.swift
//  SortList
//
//  Created by mc373 on 09.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
    func ereseuserEnterInformation()
}

class DetailViewControllerProtocol: UIViewController {

    var receivedString: String = ""
    
    weak var detailDelegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var detailViewTextInputEdit: UITextField!
    
    @IBAction func detailViewDoneButton(sender: AnyObject) {
    
        // call this method on whichever class implements our delegate protocol
        detailDelegate?.userDidEnterInformation(detailViewTextInputEdit.text!)
        
        // go back to the previous view controller
        self.navigationController?.popViewControllerAnimated(true)
    
    }
    
    @IBAction func detailViewCancelButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
        detailDelegate?.ereseuserEnterInformation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailViewTextInputEdit.text = receivedString
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
        
        //if segue.identifier == "showDetailViewController" {
        //    let sourceViewController = segue.sourceViewController as! ToDoListViewController
        //    self.detailDelegate = sourceViewController
       // }
    }
}

//
//  DetailViewControllerProtocol.swift
//  SortList
//
//  Created by mc373 on 09.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    //need to reWrite -> need some Like Structure, which content Cell and Identifier , ...
    func userDidEnterInformation(info: String)
    func ereseuserEnterInformation()
}

class DetailViewControllerProtocol: UIViewController {
    
    //var receivedString: String = ""
    var receivedCell: ToDoItem?
    
    weak var detailDelegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var dateTimeCreateDetail: UILabel!
    @IBOutlet weak var dateTimeLiveDetail: UILabel!
    @IBOutlet weak var detailViewTextInputEdit: UITextField!
    
    @IBAction func buttonColorOfItem(sender: AnyObject) {
        
    }
    @IBOutlet weak var buttonColorOfItemOutlet: UIButton!
    
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
        //  detailViewTextInputEdit.text = receivedString
        detailViewTextInputEdit.text            = getTitleValueFromreceivedCell()
        dateTimeCreateDetail.text               = getTitleValueFromreceivedCellTimeDate()
        dateTimeLiveDetail.text                 = CalculateUsedTimeFronDate1ToDate2()
        buttonColorOfItemOutlet.backgroundColor = getColorOfItemsFromreceivedCell()
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
    
    //MARK: function for delegate work's fine
    func getTitleValueFromreceivedCell () -> String {
        return receivedCell != nil ? ((receivedCell?.item)! as String) : ""//String(receivedCell?.item)
    }
    
    func getTitleValueFromreceivedCellTimeDate () -> String {
        guard receivedCell != nil else {
            return ""
        }
        
        let dateTimeStr = Date.parseForDetailTableView((receivedCell?.dateTimeCreate)!)
        return dateTimeStr as String
    }
    
    func CalculateUsedTimeFronDate1ToDate2 () -> String {
        guard receivedCell != nil else {
            return ""
        }
        
        return Date.CalculateUsedTime((receivedCell?.dateTimeCreate)!)
    }
    
    func getColorOfItemsFromreceivedCell() -> UIColor {
        guard receivedCell != nil else {
            return ColorMode.getDefaultColorForItem()
        }
        
        return receivedCell!.colorItem
    }
    
    
    //    func getTitleValueFromreceivedCell (info: String?=nil) -> String {
    //
    //        guard info != nil else {
    //            return ""
    //        }
    //
    //
    //        return receivedCell != nil ? ((receivedCell?.[info])! as String) : ""//String(receivedCell?.item)
    //    }
    
}

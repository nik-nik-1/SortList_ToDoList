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

class DetailViewControllerProtocol: UIViewController, UIPopoverPresentationControllerDelegate, ColorPickerDelegate {
    
    //var receivedString: String = ""
    var receivedCell: ToDoItem?
    
    weak var detailDelegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var dateTimeCreateDetail: UILabel!
    @IBOutlet weak var dateTimeLiveDetail: UILabel!
    @IBOutlet weak var detailViewTextInputEdit: UITextField!
    
    @IBAction func buttonColorOfItem(sender: AnyObject) {
        self.showColorPicker()
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
    
    
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // class varible maintain selected color value
    var selectedColor: UIColor = UIColor.blueColor()
    var selectedColorHex: String = "0000FF"
    
    
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
            return ColorMode.init().getDefaultColorForItem()
        }
        
        return receivedCell!.colorItem
    }
    
    // MARK: Popover delegate functions
    // Override iPhone behavior that presents a popover as fullscreen.
    // i.e. now it shows same popover box within on iPhone & iPad
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // show popover box for iPhone and iPad both
        return UIModalPresentationStyle.None
    }
    
    // MARK: Color picker delegate functions
    // called by color picker after color selected.
    func colorPickerDidColorSelected(selectedUIColor selectedUIColor: UIColor, selectedHexColor: String) {
        
        // update color value within class variable
        self.selectedColor    = selectedUIColor
        self.selectedColorHex = selectedHexColor
        
        // set preview background to selected color
        //self.colorPreview.backgroundColor = selectedUIColor
       buttonColorOfItemOutlet.backgroundColor = selectedUIColor
        
       //TEST COLOR 
        
        //let ColorBarTrans = UIColor.colorWithAlphaComponent(selectedUIColor)(0.2) //not works!
        self.navigationController?.navigationBar.barTintColor = selectedUIColor
        self.navigationController?.navigationBar.alpha = 0.2
//        self.navigationController?.navigationBar.translucent = true
        
//        navigationController.navigationBar.titleTextAttributes = [UITextAttributeTextColor: UIColor.orangeColor()]
//        tabBarController.tabBar.barTintColor = UIColor.brownColor()
//        tabBarController.tabBar.tintColor = UIColor.yellowColor()
    }
    
    // show color picker from UIButton
    private func showColorPicker(){
        
        // initialise color picker view controller
        let colorPickerVc = storyboard?.instantiateViewControllerWithIdentifier("sbColorPicker") as! ColorPickerViewController
        
        // set modal presentation style
        colorPickerVc.modalPresentationStyle = .Popover
        
        // set max. size
        colorPickerVc.preferredContentSize = CGSizeMake(302, 302)
        
        // set color picker deleagate to current view controller
        // must write delegate method to handle selected color
        colorPickerVc.colorPickerDelegate = self
        
        // show popover
        if let popoverController = colorPickerVc.popoverPresentationController {
            
            // set source view
            popoverController.sourceView = self.view
            
            // show popover form button
            popoverController.sourceRect = self.buttonColorOfItemOutlet.frame
            
            // show popover arrow at feasible direction
            popoverController.permittedArrowDirections = UIPopoverArrowDirection.Any
            
            // set popover delegate self
            popoverController.delegate = self
        }
        
        //show color popover
        presentViewController(colorPickerVc, animated: true, completion: nil)
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

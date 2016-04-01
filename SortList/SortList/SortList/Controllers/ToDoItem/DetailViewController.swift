//
//  DetailViewController.swift
//  SortList
//
//  Created by mc373 on 09.02.16.
//  Copyright © 2016 Local. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    //need to reWrite -> need some Like Structure, which content Cell and Identifier , ...
//    func userDidEnterInformation(info: String)
    func ereseuserEnterInformation()
}

class DetailViewController: UIViewController, UIPopoverPresentationControllerDelegate, ColorPickerDelegate, UITextViewDelegate {
    
    //var receivedString: String = ""
    var receivedCell: ToDoItem?
    
    weak var detailDelegate: DataEnteredDelegate? = nil
    
    @IBOutlet weak var dateTimeCreateDetail: UILabel!
    @IBOutlet weak var dateTimeLiveDetail: UILabel!
//    @IBOutlet weak var detailViewTextInputEdit: UITextField!
    @IBOutlet weak var buttonColorOfItemOutlet: UIButton!
    @IBOutlet weak var detailViewTextInputEdit: UITextView!
    
    @IBAction func buttonColorOfItem(sender: AnyObject) {
        self.showColorPicker()
        
    }
    @IBAction func detailViewDoneButton(sender: AnyObject) {
        // call this method on whichever class implements our delegate protocol
        
        let moc = CoreDataUtil.getManagedObjectContext(ToDoItem.getEntityNameOfObject())
        
        if receivedCell == nil {
            //new value
            ToDoItem.insertToDoItemWithItem(detailViewTextInputEdit.text, checked: false, createdDate: NSDate.getCurrentDate(), colorItem: selectedColor, context: moc)
            
        } else {
            ToDoItem.rewriteToDoItemWithParameters(&receivedCell, item: detailViewTextInputEdit.text, checked: nil, colorItem: selectedColor)
        }
        
        CoreDataUtil.saveContext(moc)
        
//        detailDelegate?.userDidEnterInformation(detailViewTextInputEdit.text!)
        
        // go back to the previous view controller
        self.navigationController?.popViewControllerAnimated(true)
        detailDelegate?.ereseuserEnterInformation()
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
        
        self.detailViewTextInputEdit.delegate = self
        
        // Do any additional setup after loading the view.
        detailViewTextInputEdit.text            = getTitleValueFromreceivedCell()
        dateTimeCreateDetail.text               = getTitleValueFromreceivedCellTimeDate()
        dateTimeLiveDetail.text                 = CalculateUsedTimeFronDate1ToDate2()
        
        let buttonColor: UIColor = getColorOfItemsFromreceivedCell()
//        buttonColorOfItemOutlet.backgroundColor = buttonColor
//        buttonColorOfItemOutlet.layer.borderColor = buttonColor.CGColor
        
        let hexColor = ColorPickerViewController.getHexString(buttonColor, includeAlpha: false)
        colorPickerDidColorSelected(selectedUIColor: buttonColor, selectedHexColor: hexColor)
        
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
        
        let dateTimeStr = NSDate.parseForDetailTableView((receivedCell?.dateTimeCreate)!)
        return dateTimeStr as String
    }
    
    
    func CalculateUsedTimeFronDate1ToDate2 () -> String {
        guard receivedCell != nil else {
            return ""
        }
        
        return NSDate.CalculateUsedTime((receivedCell?.dateTimeCreate)!)
    }
    
    func getColorOfItemsFromreceivedCell() -> UIColor {
        guard receivedCell != nil && receivedCell!.colorItem != nil else {
            return ToDoItem.getDefaultColorFortem()//UIColor.whiteColor()//ColorMode.init().getDefaultColorForItem()
        }
        
        
        
        return receivedCell!.colorItem as! UIColor
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
        
        let temStructOfColor = ColorPickerViewController.getRigthParametersOfColorForDrawing(selectedUIColor)
        
        let сolorBarTrans = temStructOfColor.сolor04a
        
//        self.view.backgroundColor = сolorBarTrans
        
        self.navigationController?.navigationBar.barTintColor = сolorBarTrans
        
        buttonColorOfItemOutlet.backgroundColor     = сolorBarTrans
        buttonColorOfItemOutlet.layer.borderColor   = selectedUIColor.CGColor
        
        detailViewTextInputEdit.backgroundColor     = temStructOfColor.сolor02a
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
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        detailViewTextInputEdit.resignFirstResponder()
        return true;
    }
    
}

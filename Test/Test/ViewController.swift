//
//  ViewController.swift
//  Test
//
//  Created by 訪客使用者 on 2020/5/4.
//  Copyright © 2020 訪客使用者. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var list = ["Read","Write","Listen","Speak","Think"]
    var list2:[String]=["USA","Taiwan","China"]
    var i:Int=0
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  (section){
        case 0: return list.count
        break
        case 1: return list2.count
        default: return 0;
            
        }
    }
    
    // title of sections
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch(section){
        case 0: return "ability"
         
        case 1: return "country"
        default:
            return ""
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func AddClicked(_ sender: Any) {
        list2+=[String(format: "%2d", i )]
        i+=1;
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 顯示什麼
        let cellid = "Cell" // Cell ID
        // ask for Memory
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        switch (indexPath.section){
        case 0:  cell.textLabel?.text = list[indexPath.row]
        break
        case 1: cell.textLabel?.text = list2[indexPath.row]
        break
        default: cell.textLabel?.text = ""
        }
        
        
        switch (indexPath.row) {
            case 0: cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                break
            case 1: cell.accessoryType = .detailDisclosureButton
                break
            case 2: cell.accessoryType = .detailButton
                break
            case 3: cell.accessoryType = .checkmark
                break
            default: cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    // default is false
    override var prefersStatusBarHidden: Bool{
        return false
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }

    // delete data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            // delete
            switch(indexPath.section){
            case 0: list.remove(at:indexPath.row)
            break
            case 1: list.remove (at:indexPath.row)
            break
            default:break
            }
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
 // get what user choise
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 先讓target 得知選到哪個陣列
        var target:[String]=[]
        switch(indexPath.section){
        case 0: target=list
        case 1: target=list2
        default:break
        }
        print("user select section:\(indexPath.section) row: \(indexPath.row) value: \(target[indexPath.row])")
        
        
        // AlertController
        /*
         handler: 觸發事件
         */
        let alter = UIAlertController(title: "Alter", message: target[indexPath.row], preferredStyle: .alert)
        alter.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default,handler:nil))
        
        /*
         completion: 顯示出來要做什麼
         */
        self.present(alter,animated: true,completion: nil)
    }
    
    
    
    // sender belong UIBarButtonItem
    @IBAction func EditData(_ sender: UIBarButtonItem) {
        
        /*
            如果目前處於編輯模式 按一下應脫離編輯模式
         */
        if self.tableView.isEditing{
            sender.title = "Edit"
            self.tableView.isEditing=false
        }else{
            sender.title = "Done"
            self.tableView.isEditing=true
        }
    }
    
    
    // 更改順序
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // 使其有權限更改
        return true
    }
    //
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
       // ex 不允許 section1 move to section2,  if allow 要去做事件
        if sourceIndexPath.section != proposedDestinationIndexPath.section{
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tagetArray:[String]=[]

        // 由於不允許section1 move to section2
        switch sourceIndexPath.section{
        case 0: tagetArray=list
        case 1: tagetArray=list2
        default: break
        }
        
        tagetArray.swapAt(sourceIndexPath.row,destinationIndexPath.row)
        
    }
}


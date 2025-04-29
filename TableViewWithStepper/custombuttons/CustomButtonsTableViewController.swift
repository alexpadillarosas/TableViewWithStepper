//
//  CustomButtonsTableViewController.swift
//  TableViewWithStepper
//
//  Created by alex on 28/4/2025.
//

import UIKit

class CustomButtonsTableViewController: UITableViewController {

    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        products.append(Product(name: "Cavendish Banana", pricePerKilogram: 4.99, weight: Measurement(value: 0, unit: UnitMass.kilograms), emoji: "🍌"))
        products.append(Product(name: "Watermelon", pricePerKilogram: 2.56, weight: Measurement(value: 0, unit: UnitMass.kilograms), emoji: "🍉"))
        products.append(Product(name: "Strawberry", pricePerKilogram: 4.99, weight: Measurement(value: 0, unit: UnitMass.kilograms), emoji: "🍓"))
        products.append(Product(name: "Grapes", pricePerKilogram: 3.99, weight: Measurement(value: 0, unit: UnitMass.kilograms), emoji: "🍇"))
        products.append(Product(name: "Appple", pricePerKilogram: 3.99, weight: Measurement(value: 0, unit: UnitMass.kilograms), emoji: "🍏"))
        products.append(Product(name: "Flashlight", pricePerUnit: 2, count: 0, emoji: "🔦"))
        products.append(Product(name: "Blue Cap", pricePerUnit: 6.50, count: 0, emoji: "🧢"))

        for product in products {
            print(product.shortDescription())
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath) as! CustomButtonsTableViewCell

        // Configure the cell...
        let product = products[indexPath.row]
        
        cell.productImageView.image = product.emoji.emojiToImage()
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = product.priceDescription()
        cell.productUnitLabel.text = product.measurementUnitLabel()

        cell.increaseQtyButton.tag = indexPath.row
        cell.decreaseQtyButton.tag = indexPath.row
        
        switch product.saleType {
        case .byUnit:
            cell.productQuantityLabel.text = "0"
        case .byWeight:
            cell.productQuantityLabel.text = "0.0"
        }
        
        cell.increaseQtyButton.addTarget(self, action: #selector(increaseQtyDidPress(sender:)), for: UIControl.Event.touchUpInside)
        
        cell.decreaseQtyButton.addTarget(self, action: #selector(decreaseQtyDidPress(sender:)), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    @objc func increaseQtyDidPress(sender: UIButton){
        //recover the stored row in the button's tag property
        let row = sender.tag
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomButtonsTableViewCell {
            
            
            switch cell.productUnitLabel.text?.uppercased() {
            case "UNIT":
                //If it is a product sold by units, then the quantity is an integer
                var quantity = Int(cell.productQuantityLabel.text ?? "0") ?? 0
                quantity += 1
                cell.productQuantityLabel.text = "\(quantity)"
            case "KG":
                //If it is a product sold by Kilograms, then the quantity is double
                var quantity = Double(cell.productQuantityLabel.text ?? "0.0") ?? 0.0
                quantity += 1
                cell.productQuantityLabel.text = "\(quantity)"
            default:
                var quantity = Int(cell.productQuantityLabel.text ?? "0") ?? 0
                quantity += 1
                cell.productQuantityLabel.text = "\(quantity)"
            }
            
        }
        
    }
    
    @objc func decreaseQtyDidPress(sender: UIButton){
        
        let row = sender.tag
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CustomButtonsTableViewCell {
            
            

            switch cell.productUnitLabel.text?.uppercased() {
            case "UNIT":
                let quantity = Int(cell.productQuantityLabel.text!)
                
                //check quantity has a value, and the value is greater than zero
                guard var quantity = quantity, quantity > 0 else{
                    return
                }
                quantity -= 1
                cell.productQuantityLabel.text = "\(quantity)"
            case "KG":
                let quantity = Double(cell.productQuantityLabel.text!)
                
                //check quantity has a value, and the value is greater than zero
                guard var quantity = quantity, quantity > 0 else{
                    return
                }
                quantity -= 1
                cell.productQuantityLabel.text = "\(quantity)"
            default:
                let quantity = Int(cell.productQuantityLabel.text!)
                
                //check quantity has a value, and the value is greater than zero
                guard var quantity = quantity, quantity > 0 else{
                    return
                }
                quantity -= 1
                cell.productQuantityLabel.text = "\(quantity)"
            }
            
        }
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

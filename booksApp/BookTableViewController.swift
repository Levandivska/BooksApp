//
//  BookTableViewController.swift
//  booksApp
//
//  Created by оля on 04.10.2020.
//  Copyright © 2020 Olya. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {

    var book1 = book("Name", "Author", "Image")
    var book2 = book("Name", "Author", "Image")

    var books: [book] = [book("Name", "Author", "Image"), book("Name", "Author", "Image")]
    
    enum TableSection: Int {
      case action = 0, discovery, popular, recomended, total
        
    }
    
     let SectionHeaderHeight: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return books.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
//        cell.backgroundColor = .black
//
//        return cell
//    }
    

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



extension BookTableViewController{

  // As long as `total` is the last case in our TableSection enum,
  // this method will always be dynamically correct no mater how many table sections we add or remove.
    override func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Using Swift's optional lookup we first check if there is a valid section of table.
    // Then we check that for the section there is data that goes with.
    if let tableSection = TableSection(rawValue: section), let movieData = data[tableSection] {
      return movieData.count
    }
    return 0
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    // If we wanted to always show a section header regardless of whether or not there were rows in it,
    // then uncomment this line below:
    //return SectionHeaderHeight
    // First check if there is a valid section of table.
    // Then we check that for the section there is more than 1 row.
    if let tableSection = TableSection(rawValue: section), let movieData = books[tableSection], movieData.count > 0 {
      return SectionHeaderHeight
    }
    return 0
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
    view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
    let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
    label.font = UIFont.boldSystemFont(ofSize: 15)
    label.textColor = UIColor.black
    if let tableSection = TableSection(rawValue: section) {
      switch tableSection {
      case .action:
        label.text = "Action"
      case .comedy:
        label.text = "Comedy"
      case .drama:
        label.text = "Drama"
      case .indie:
        label.text = "Indie"
      default:
        label.text = ""
      }
    }
    view.addSubview(label)
    return view
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    // Similar to above, first check if there is a valid section of table.
    // Then we check that for the section there is a row.
    if let tableSection = TableSection(rawValue: indexPath.section), let movie = data[tableSection]?[indexPath.row] {
      if let titleLabel = cell.viewWithTag(10) as? UILabel {
        titleLabel.text = movie["title"]
      }
      if let subtitleLabel = cell.viewWithTag(20) as? UILabel {
        subtitleLabel.text = movie["cast"]
      }
    }
    return cell
  }

}

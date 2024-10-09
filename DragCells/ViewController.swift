//
//  ViewController.swift
//  DragCells
//
//  Created by Priyanka on 09/10/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var arrTitle = ["A","B","C","D","E","F","G","H","I","J"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    private func registerTableView() {
        tblView.dragInteractionEnabled = true
        tblView.delegate = self
        tblView.dataSource = self
        tblView.dragDelegate = self
        tblView.register(UINib(nibName: "DragCell", bundle: nil), forCellReuseIdentifier: "DragCell")
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DragCell") as? DragCell else { return UITableViewCell() }
        cell.lblTitle.text = arrTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(50)
    }
}

extension ViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: any UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = arrTitle[indexPath.row]
        return [ dragItem ]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = arrTitle.remove(at: sourceIndexPath.row)
        arrTitle.insert(mover, at: destinationIndexPath.row)
    }
}

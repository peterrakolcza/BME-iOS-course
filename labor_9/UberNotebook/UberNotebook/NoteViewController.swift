//
//  NoteViewController.swift
//  UberNotebook
//
//  Created by Rakolcza Peter on 2021. 11. 18..
//

import UIKit
import CoreData

class NoteViewController: UITableViewController {
    
    var notebook: Notebook!
    private var fetchedResultsController: NSFetchedResultsController<Note>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = notebook.title
        let managedObjectContext = AppDelegate.managedContext
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        // szűrés azon Note-okra, melyek a kiválasztott Notebookhoz tartoznak
        let predicate = NSPredicate(format: "%K == %@", #keyPath(Note.notebook), notebook)
        fetchRequest.predicate = predicate
        // rendezés creationDate szerint csökkenő sorrendben
        let sortDescriptor = NSSortDescriptor(key: #keyPath(Note.creationDate), ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        // egyszerre max 30 Note lekérdezése
        fetchRequest.fetchBatchSize = 30
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("\(error.userInfo)")
        }
        
        fetchedResultsController.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        configure(cell: cell, at: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo = fetchedResultsController.sections?[section] else
        {
            return 0
            
        }
        return sectionInfo.numberOfObjects
    }
    
    func configure(cell: UITableViewCell, at indexPath: IndexPath) {
        let note = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = note.content
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        cell.detailTextLabel?.text = dateFormatter.string(from: note.creationDate!)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObjectContext = AppDelegate.managedContext
            let noteToDelete = fetchedResultsController.object(at: indexPath)
            managedObjectContext.delete(noteToDelete)
        }
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
    private func createNote(with content: String) {
        let managedObjectContext = AppDelegate.managedContext
        let note = Note(context: managedObjectContext)
        note.content = content
        note.creationDate = Date()
        note.notebook = notebook
        //(UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    @IBAction func addNoteButtonTap(_ sender: Any) {
        let createNoteAlert = UIAlertController(title: "Create Note", message: "Enter the content", preferredStyle: .alert)
        createNoteAlert.addTextField() {
            textField in textField.placeholder = "Note content"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        createNoteAlert.addAction(cancelAction)
        let createAction = UIAlertAction(title: "Create", style: .default) {
            action in
            let textField = createNoteAlert.textFields!.first!
            self.createNote(with: textField.text!)
        }
        createNoteAlert.addAction(createAction)
        present(createNoteAlert, animated: true, completion: nil)
    }
    
}

extension NoteViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!)!
            configure(cell: cell, at: indexPath!)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

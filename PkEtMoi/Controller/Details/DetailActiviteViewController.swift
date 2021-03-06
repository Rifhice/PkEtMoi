//
//  DetailActiviteViewController.swift
//  PkEtMoi
//
//  Created by Kevin Giordani on 19/03/2018.
//  Copyright © 2018 Kevin GIORDANI. All rights reserved.
//

import UIKit

class DetailActiviteViewController: UIViewController,UITableViewDataSource, UITableViewDelegate ,isAbleToReceiveAlarm {
    
    func pass(nom:String,date: Date) {
        activite?.addAlarme(date: date)
        AppDelegate.notification.addNotification(title: "Activité", body: (activite?.nom)!, date: date, identifier: "activite" + DateHandler.toString(date: date))
        alarmeTable.reloadData()
    }
    

    @IBOutlet weak var nomActivite: UILabel!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var nivea: UILabel!
    
    var activite :ActiviteModel? = nil

    @IBOutlet weak var alarmeTable: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomActivite.text = activite?.nom
        exp.text = "Exp : \(String(describing: activite!.experience))/10"
        nivea.text = "Level : \(String(describing: activite!.niveau))"
        
        alarmeTable.delegate = self
        alarmeTable.dataSource = self
    }
    
    @IBAction func jeViensDenFaire(_ sender: UIButton) {
        activite?.incExperience()
        exp.text = "Exp : \(String(describing: activite!.experience))/10"
        nivea.text = "Level : \(String(describing: activite!.niveau))"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        alarmeTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addAlarm(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let myVC = storyboard.instantiateViewController(withIdentifier: "alarme") as! AlarmViewController
        myVC.delegate = self
        navigationController?.pushViewController(myVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.activite?.alarmes.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.alarmeTable.dequeueReusableCell(withIdentifier: "activiteAlarmeCell", for: indexPath) as! ActiviteDetailAlarmeTableViewCell
        let text : DateHandler = DateHandler(date: (self.activite?.alarmes.get(i: indexPath.row)!.date)! , formatter: "MMM dd, yyyy HH:mm")
        cell.labelCell.text = text.currentDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            var date = (self.activite?.alarmes.get(i: indexPath.row)?.date)!
            AppDelegate.notification.removeNotification(identifier: ["activite"+DateHandler.toString(date: date)])
            self.activite?.deleteAlarme(date:date)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

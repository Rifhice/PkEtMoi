//
//  CoreDataResumeDAO.swift
//  PkEtMoi
//
//  Created by Kevin Giordani on 19/03/2018.
//  Copyright © 2018 Kevin GIORDANI. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataMedicamentDAO : MedicamentDAO{
    
    var instanceCoreData: Medicament? = nil
    
    init(medicament : Medicament){
        self.instanceCoreData = medicament
    }
    
    override init(){
        
    }
    
    override func _getAll() -> MedicamentSet? {
        var medicament  = [Medicament]()
        
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Medicament")
        do{
            try medicament = CoreDataDAO.context.fetch(fetchRequest) as! [Medicament]
        }
        catch let error as NSError{
            print(error)
            return nil
        }
        var result = MedicamentSet()
        for med in medicament {
            result.insert(medicament: MedicamentModel(medicament: CoreDataMedicamentDAO(medicament:med)))
        }
        return result
    }
    
    override func _insertMedicament(nom:String,description:String)->Bool
    {
        let newMedicament = NSEntityDescription.insertNewObject(forEntityName: "Medicament", into: CoreDataDAO.context) as! Medicament
        newMedicament.nom = nom
        newMedicament.presentation = description
        do{
            try CoreDataDAO.context.save()
            self.instanceCoreData = newMedicament
            return true
        }
        catch let error as NSError{
            print(error)
            return false
        }
    }
    
    override internal func _deleteMedicament()->Bool
    {
        do{
            CoreDataDAO.context.delete(self.instanceCoreData!)
            try CoreDataDAO.context.save()
            return true
        }
        catch let error as NSError{
            print(error)
            return false
        }
    }
    
    override func _getName()->String?
    {
        return instanceCoreData?.nom;
    }
    
    override func _setName(forname:String)
    {
        fatalError(#function + "Must be overridden");
    }
    
    override  func _getDescription()->String?
    {
        fatalError(#function + "Must be overridden");
        return nil;
    }
    
    override func _setDescription(forname:String)
    {
        fatalError(#function + "Must be overridden");
    }
    
    override func _getDoses()->[DosesModel]?
    {
        fatalError(#function + "Must be overridden");
        return nil;
    }
    
    override func _setDoses(forname:[DosesModel])
    {
        fatalError(#function + "Must be overridden");
    }
    
}

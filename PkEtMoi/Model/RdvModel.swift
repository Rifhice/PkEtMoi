//
//  MedicamentModel.swift
//  PkEtMoi
//
//  Created by Kevin Giordani on 19/03/2018.
//  Copyright © 2018 Kevin GIORDANI. All rights reserved.
//

import Foundation
class RdvModel:EventModel{
    
    var dao : RdvDAO
    
    var firstname :String?{
        get{
            return dao._getFirstName()
        }
        set{
            dao._setFirstName(forname : newValue as! String)
        }
    }
    
    var lastname :String?{
        get{
            return dao._getLastName()
        }
        set{
            dao._setLastName(forname : newValue as! String)
        }
    }
    var fullname :String?{
        get{
            return firstname! + " " + lastname!
        }
    }
    
    var adresse :String?{
        get{
            return dao._getAdresse()
        }
        set{
            dao._setAdresse(forname : newValue as! String)
        }
    }
    
    var date :Date?{
        get{
            return dao._getDate()
        }
        set{
            dao._setDate(forname : newValue as! Date)
        }
    }
    
    var telephone : Int32?{
        get{
            return dao._getPhone()
        }
        set{
            dao._setPhone(forname: newValue as! Int32)
        }
    }
    
    var type:String?{
        get{
            return dao._getMedecin()?.exercer?.nom
        }
    }
    
    var alarmes : [AlarmeRDV]{
        get{
            return dao._getAlarmes()!
        }
    }
    
    init(rdv: RdvDAO){
        self.dao = rdv
    }
    
    func getLabel() -> String? {
        var dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        return firstname! + " " + lastname! + dateFormatter.string(from: date!)
    }
    
    init(firstname:String,lastname:String,adresse:String,date:Date,telephone:Int32){
        dao = AbstractDAO.getDAO()._getRdvDAO()!
        dao._insert(adresse: adresse, date: date, nom: lastname, prenom: firstname, telephone: telephone)
    }
    
    func delete() ->Bool{
        return dao._delete()
    }
    
    func addAlarme(date:Date){
        dao._addAlarme(date: date)
    }
    
    func getDateString()->String?{
        var dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        return dateFormatter.string(from: date!)
    }
    
}


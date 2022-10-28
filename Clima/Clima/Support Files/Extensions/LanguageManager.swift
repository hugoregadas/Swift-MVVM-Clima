//
//  LanguageManager.swift
//  Clima
//
//  Created by Hugo Regadas on 28/10/2022.
//

import Foundation
import UIKit

class LanguageManager : NSObject{
    static let sharedLanguage = LanguageManager()
    
    func setupCurrentLanguage() {
        let elements = UserDefaults.standard.object(forKey: "AppleLanguages")  as! NSArray
        var currentLanguage = elements.firstObject as! String
        
        if ((currentLanguage.isEmpty)){
            currentLanguage = Bundle.main.preferredLocalizations.first!
        }
        
        UserDefaults.standard.set([currentLanguage], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
    
    func currentCode() -> String {
        let currentCode = UserDefaults.standard.object(forKey: "AppleLanguages") as! NSArray
        return currentCode.firstObject as! String
    }
    
    func saveLanguageByCode(with code : String) {
        UserDefaults.standard.set([code], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
    }
}

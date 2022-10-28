//
//  ViewController.swift
//  Clima
//
//  Created by Hugo Regadas on 19/10/2022.
//

import UIKit
import CoreLocation

class DashboardViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var changeLanguageButton: UIButton!
    
    //MARK: - Private Var
    private let viewModel = WeatherViewModel(serviceApi: ServiceManager.shared)
    private let locationManager = CLLocationManager()
    
    //MARK: - Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: - private methods User Interface
private extension DashboardViewController{
    //init User interface
    func initUI(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchTextField.delegate = self
        changeLanguageButton.setTitle(viewModel.language, for: .normal)
    }
    
    //Update UI
    func fetchWeatherAndClearTextField(){
        searchTextField.placeholder = NSLocalizedString("Country", comment: "")
        fetchWeather(with: searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    func showWarningTitleChange(){
        let alert = UIAlertController.init(title: NSLocalizedString("warnings_title", comment: ""),
                                           message: NSLocalizedString("warnigs_details_Language", comment: ""),
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }

    //Actions
    @IBAction func buttonLanguagePressed(_ sender: UIButton) {
        if (changeLanguageButton.title(for: .normal) == "PT") {
            LanguageManager.sharedLanguage.saveLanguageByCode(with: "pt")
        }else {
            LanguageManager.sharedLanguage.saveLanguageByCode(with: "en")
        }
        
        showWarningTitleChange()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - private methods service
private extension DashboardViewController {
    func fetchWeather(with countryName: String){
        viewModel.fecthWeather(with: countryName, completion: {
            self.updateUserInterface()
        })
    }
    
    func updateUserInterface() {
        DispatchQueue.main.async {
            self.temperatureLabel.text = self.viewModel.fetchTemp()
            self.cityLabel.text = self.viewModel.fetchName()
            self.containerImage.image = UIImage(systemName: self.viewModel.fetchImageNamed())
        }
    }
}

//MARK: - UITextfield Delegate
extension DashboardViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fetchWeatherAndClearTextField()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        }else {
            textField.placeholder = NSLocalizedString("Search_Country", comment: "")
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

//MARK: - CoreLocation Delegate
extension DashboardViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            viewModel.fetchWeather(with: lat, long: lon) {
                self.updateUserInterface()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


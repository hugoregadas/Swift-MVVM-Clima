//
//  ViewController.swift
//  Clima
//
//  Created by Hugo Regadas on 19/10/2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBoutlets
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    //MARK: - Private Var
    private let viewModel = WeatherViewModel(serviceApi: ServiceManager.shared)
    
    //MARK: - Life cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

//MARK: - private methods User Interface
private extension ViewController{
    //Update UI
    func hiddenSearchTextField(){
        searchTextField.placeholder = "Country"
        fetchWeather(country: searchTextField.text!)
        searchTextField.endEditing(true)
    }
    
    //Actions
    @IBAction func searchCountryPressed(_ sender: UIButton) {
        hiddenSearchTextField()
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        
    }
}

//MARK: - private methods service
private extension ViewController {
    func fetchWeather(country countryName: String){
        viewModel.fecthWeather(countryName, completion: {
            let temp = self.viewModel.fetchTemp()
            let name = self.viewModel.fetchName()
            
            if (temp != nil && name != nil) {
                DispatchQueue.main.async {
                    self.temperatureLabel.text = "\(String(describing: temp!))" + " °C"
                    self.cityLabel.text = name!
                }
            }
        })
    }
}

//MARK: - UITextfield Delegate
extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hiddenSearchTextField()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != "") {
            return true
        }else {
            textField.placeholder = "Search Country"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}


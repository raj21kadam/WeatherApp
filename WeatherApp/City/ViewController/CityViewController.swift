//
//  SignInViewController.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import UIKit

import Combine
class CityViewController: UIViewController {
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var lookUpButton: UIButton!
    var cancelable: Set<AnyCancellable> = []

    private lazy var viewModel: ForecastViewModel = {
        let viewModel = ForecastViewModel()
        return viewModel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lookUpButton.layer.cornerRadius = 8
        lookUpButton.layer.borderColor = UIColor.systemGray4.cgColor
        lookUpButton.layer.borderWidth = 1.5
        cityTextField.setBottomBorder(withColor: .systemGray4)
    }
    private func bindViewModel() {
        
        cityTextField.textPublisher.sink { [weak self] text in
            self?.viewModel.cityName = text
        }.store(in: &cancelable)
        
        viewModel.$error.sink { [weak self] value in
            if let error = value {
                DispatchQueue.main.async {
                    self?.removeLoader()
                    self?.showAlert(message: error, title: nil)
                }
            }
        }.store(in: &cancelable)
        
        viewModel.$forecastList.sink { [weak self] list in
            guard let resultArray = list else {return}
            DispatchQueue.main.async {
                self?.removeLoader()
            if  !resultArray.isEmpty {
                self?.gotoListView()
            }else {
                
                    self?.showAlert(message: ErrorMessages.No_Data_Found, title: nil)
                }
            }
        }.store(in: &cancelable)
        
    }
    
    @IBAction func lookupAction(_ sender: UIButton) {
        self.addLoader(message: "Fetching data...")
        cityTextField.resignFirstResponder()
        viewModel.getHourlyForcastForCity()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func gotoListView(){
        if let controller = ForecastListViewController().getForecastListViewController(forViewModel: viewModel)
        {
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



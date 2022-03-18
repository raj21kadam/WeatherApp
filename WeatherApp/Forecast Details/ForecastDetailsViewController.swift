//
//  ForecastDetailsViewController.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import UIKit

class ForecastDetailsViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var forecastTypeLabel: UILabel!
    @IBOutlet weak var forecastDescriptionLabel: UILabel!
    var navigationTitle = ""
    var forcastData:HourlyForecastModel?
    func getForecastDetailsViewController(forForcast data: HourlyForecastModel, title: String)->ForecastDetailsViewController?
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let forecastDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "ForecastDetailsViewController") as? ForecastDetailsViewController else { return  nil}
        forecastDetailsViewController.forcastData = data
        forecastDetailsViewController.navigationTitle = title
        return forecastDetailsViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        temperatureLabel.text = "\(forcastData?.main?.temp ?? 0.0)"
        feelsLikeLabel.text = "Feels Like: \(forcastData?.main?.feels_like ?? 0.0)"
        forecastTypeLabel.text = forcastData?.weather?.first?.main
        forecastDescriptionLabel.text = forcastData?.weather?.first?.description
        
        self.navigationItem.title = navigationTitle
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

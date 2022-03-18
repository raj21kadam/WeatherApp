//
//  ForecastListViewController.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import UIKit

class ForecastListViewController: UIViewController {

    @IBOutlet weak var forecastTableView: UITableView!
    var forecastVM: ForecastViewModel?
    
    private let FORECAST_CELL_IDENTIFIER = "ForecastTableViewCell"
    func getForecastListViewController(forViewModel viewModel: ForecastViewModel)->ForecastListViewController?
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let forecastListViewController = storyBoard.instantiateViewController(withIdentifier: "ForecastListViewController") as? ForecastListViewController else { return  nil}
        forecastListViewController.forecastVM = viewModel

        return forecastListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastTableView.backgroundColor = .systemGray6
        self.navigationItem.title = forecastVM?.cityName.capitalized
        registerNibs()
    }
   
    private func registerNibs() {
        forecastTableView.register("ForecastTableViewCell")
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

extension ForecastListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastVM?.getListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FORECAST_CELL_IDENTIFIER, for: indexPath) as! ForecastTableViewCell
        if let record = forecastVM?.getForecastRecord(for: indexPath.row)
        {
            cell.setupCell(data: record)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let record = forecastVM?.getForecastRecord(for: indexPath.row) else {return}
        if let controller = ForecastDetailsViewController().getForecastDetailsViewController(forForcast: record, title: forecastVM?.cityName.capitalized ?? "")
        {
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

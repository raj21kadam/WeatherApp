//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temeratureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data: HourlyForecastModel) {
        guard let weatherArray = data.weather, !weatherArray.isEmpty else {return}
        weatherLabel.text = weatherArray[0].main
        temeratureLabel.text = "Temp: \(data.main?.temp ?? 0.0)"
    }
}

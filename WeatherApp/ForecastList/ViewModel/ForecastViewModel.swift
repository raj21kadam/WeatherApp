//
//  SignInViewModel.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation
import Combine

class ForecastViewModel {
    
    var cityName: String = ""
    @Published var forecastList: [HourlyForecastModel]?
    @Published var error: String?
    
    
    func getHourlyForcastForCity() {
        guard !cityName.isEmpty else {
            error = ErrorMessages.Enter_City_Name
            return
        }
        guard let url = URL.init(string: APIConstants.HourlyForecastURL) else {return}
        let request = ["q": cityName, "appid": Constants.API_KEY,"units": "metric"] as [String: Any]
        
        APIManager.manager.loadDataFromUrl(type: WeatherListModel.self, url: url, method: .get, parameters: request, headers: nil) { [weak self] result in
            
            switch result {
        
            case .success(let apiResponse):
                guard let result = apiResponse, let list = result.list else {return}
                self?.forecastList = list
                self?.error = nil
            case .failure(let error):
                self?.error = error.description
                
            }
        }
    }
    
    func getListCount()-> Int {
        return forecastList?.count ?? 0
    }
       
    func getForecastRecord(for index: Int) -> HourlyForecastModel? {
        guard let list = forecastList, !list.isEmpty else{ return nil}
        return  list[index]
    }
}

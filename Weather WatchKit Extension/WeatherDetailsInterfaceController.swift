//
//  WeatherDetailsInterfaceController.swift
//  Weather WatchKit Extension
//
//  Created by Sergey Dunaev on 08.11.2017.
//  Copyright © 2017 SSoft. All rights reserved.
//

import WatchKit
import Foundation


class WeatherDetailsInterfaceController: WKInterfaceController {

    @IBOutlet var intervalLabel: WKInterfaceLabel!
    @IBOutlet var temperatureLabel: WKInterfaceLabel!
    @IBOutlet var conditionImage: WKInterfaceImage!
    @IBOutlet var conditionLabel: WKInterfaceLabel!
    @IBOutlet var feelsLikeLabel: WKInterfaceLabel!
    @IBOutlet var windLabel: WKInterfaceLabel!
    @IBOutlet var highTemperatureLabel: WKInterfaceLabel!
    @IBOutlet var lowTemperatureLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        guard let context = context as? Dictionary<String, Any>, let dataSource = context["dataSource"] as? WeatherDataSource else {
            return
        }
        
        if let index = context["shortTermForecastIndex"] as? Int {
            let weather = dataSource.shortTermWeather[index]
            intervalLabel.setHidden(false)
            upfateCurrentForecastForWeather(weather: weather)
            
            if let active = context["active"] as? Bool, active {
                becomeCurrentPage()
            }
        }
        
        if let index = context["longTermForecastIndex"] as? Int {
            let weather = dataSource.longTermWeather[index]
            
            setTitle(weather.intervalString)
            intervalLabel.setHidden(true)
            
            upfateCurrentForecastForWeather(weather: weather)
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func upfateCurrentForecastForWeather(weather: WeatherData) {
        intervalLabel.setText(weather.intervalString)
        temperatureLabel.setText(weather.temperatureString)
        conditionImage.setImageNamed(weather.weatherConditionImageName)
        conditionLabel.setText(weather.weatherConditionString)
        feelsLikeLabel.setText(weather.feelTemperatureString)
        windLabel.setText(weather.windString)
        highTemperatureLabel.setText(weather.highTemperatureString)
        lowTemperatureLabel.setText(weather.lowTemperatureString)
    }

}

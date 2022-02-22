//
//  Communicator.swift
//  LaMetricCommunicator
//
//  Created by Dan Hart on 2/19/22.
//

import Foundation
import SwiftUI

class Communicator: ObservableObject {
    
    @Published var iconsResponse: IconsResponse = IconsResponse(meta: nil, data: [])
    
    init() {
        requestIcons()
    }
    
    // MARK: - Functions
    func send(message text: String, with sound: APIConstants.SoundID, priority: NotificationPriority, showing iconID: Int, for ip: String, using apiKey: String) {
        guard let url = URL(string: "http://\(ip):8080/api/v2/device/notifications") else { return }
        
        let body = NotificationBody.create(message: text, using: iconID, with: sound, priority: priority)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let loginData = "dev:\(apiKey)".data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type") 
        request.httpBody = try? body.jsonString()?.data(using: .utf8)
        
        print(request.cURL(pretty: true))
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            _ = "breakhere"
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    func requestIcons() {
        guard let url = URL(string: "https://developer.lametric.com/api/v2/icons") else { return }
        
        let task = URLSession.shared.iconsResponseTask(with: url) { response, _, _ in
            guard let icons = response else { return }
            DispatchQueue.main.async {
                self.iconsResponse = icons
                print("Fetched Icons")
            }
        }
        
        task.resume()
    }
}

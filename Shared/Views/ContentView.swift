//
//  ContentView.swift
//  Shared
//
//  Created by Dan Hart on 2/19/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var communicator = Communicator()
    
    @AppStorage("ipAddress") var ipAddress = "192.168.1.27"
    @AppStorage("apiKey") var apiKey = ""
    @AppStorage("sound") var sound = APIConstants.SoundID.bicycle.rawValue
    @AppStorage("icon") var icon = "1234"
    @AppStorage("message") var message: String = "Hi"
    
    @State var isShowingIconPickerView = false
    
    var body: some View {
        NavigationView {
            VStack {
                headerView()
                
                pickerView()
                
                Spacer()
                
                Text("Message")
                    .font(.headline)
                TextField("", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                Button {
                    communicator.send(message: message, with: APIConstants.SoundID(rawValue: sound) ?? APIConstants.SoundID.bicycle, showing: Int(icon) ?? 1234, for: ipAddress, using: apiKey)
                } label: {
                    Text("Send")
                        .font(.largeTitle)
                }
                
                Spacer()
            }
            .padding()
            
            .navigationTitle("Communicator")
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        VStack {
            TextField("IP Address", text: $ipAddress)
            SecureField("API Key", text: $apiKey)
        }
    }
    
    @ViewBuilder
    func pickerView() -> some View {
        VStack {
            Text("Select a sound: ")
            Picker("Sound", selection: $sound) {
                ForEach(APIConstants.SoundID.allCases, id: \.self) { sound in
                    Text(sound.rawValue).tag(sound.rawValue)
                }
            }
            .labelsHidden()
            
            Text("Select an icon: ")
            if communicator.iconsResponse.data.isEmpty {
                Text("Loading...")
            } else {
                Button {
                    isShowingIconPickerView.toggle()
                } label: {
                    Text("Pick Icon")
                }
                .sheet(isPresented: $isShowingIconPickerView, onDismiss: nil) {
                    IconPickerView(data: communicator.iconsResponse.data, selectedIconID: $icon)
                }

                let selectedIcon = communicator.iconsResponse.data.first { item in
                    "\(item.id ?? 1234)" == icon
                }
                AsyncImage(url: URL(string: selectedIcon?.thumb?.small ?? ""))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(message: "Text")
    }
}

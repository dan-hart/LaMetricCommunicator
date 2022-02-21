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
    @State var isLoading = true
    
    var body: some View {
        NavigationView {
            List {
                Section("Connection") {
                    HStack {
                        Text("IP Address")
                        SecureField("", text: $ipAddress)
                    }
                    
                    HStack {
                        Text("API Key")
                        SecureField("", text: $apiKey)
                    }
                    
                    Button {
                        ipAddress = ""
                        apiKey = ""
                    } label: {
                        Text("Clear Connection Data")
                            .disabled(ipAddress.isEmpty && apiKey.isEmpty)
                    }

                }
                
                Section("Customize") {
                    Picker("Select Sound", selection: $sound) {
                        ForEach(APIConstants.SoundID.allCases, id: \.self) { sound in
                            Text(sound.rawValue).tag(sound.rawValue)
                        }
                    }
                    .labelsHidden()
                    
                    if communicator.iconsResponse.data.isEmpty {
                        Text("Select Icon")
                    } else {
                        HStack {
                            Text("Select Icon")
                            .sheet(isPresented: $isShowingIconPickerView, onDismiss: nil) {
                                IconPickerView(data: communicator.iconsResponse.data, selectedIconID: $icon, isParentViewLoading: $isLoading)
                            }
                            
                            Spacer()
                            
                            let selectedIcon = communicator.iconsResponse.data.first { item in
                                "\(item.id ?? 1234)" == icon
                            }
                            AsyncImage(url: URL(string: selectedIcon?.thumb?.small ?? ""))
                                .onTapGesture {
                                    isLoading = true
                                    isShowingIconPickerView.toggle()
                                }
                        }
                        .onAppear {
                            isLoading = false
                        }
                    }
                }
                
                if ipAddress.isEmpty || apiKey.isEmpty {
                    Section("Errors") {
                        if ipAddress.isEmpty {
                            Text("IP Address is empty")
                                .foregroundColor(.red)
                        }
                        if apiKey.isEmpty {
                            Text("API Key is empty")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section("Message") {
                    HStack {
                        TextField("", text: $message)
                        Button {
                            communicator.send(message: message, with: APIConstants.SoundID(rawValue: sound) ?? APIConstants.SoundID.bicycle, showing: Int(icon) ?? 1234, for: ipAddress, using: apiKey)
                        } label: {
                            Text("Send")
                        }
                        .disabled(ipAddress.isEmpty || apiKey.isEmpty)
                    }
                }
                
                Section(footer: Text("This app was intended for demonstration purposes only.")) {
                    Text("Created by Dan Hart in 2022")
                }
            }
            .redacted(reason: isLoading ? .placeholder : [])
            
            .navigationTitle(isLoading ? "Loading..." : "Communicator")
        }
        #if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(message: "Text")
    }
}

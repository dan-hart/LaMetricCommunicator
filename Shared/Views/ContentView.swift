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
    @AppStorage("message") var message = "Hi"
    @AppStorage("priority") var priority = NotificationPriority.warning.rawValue
    
    @State var isShowingIconPickerView = false
    @State var isLoading = true
    @State var result = ""
    
    var body: some View {
        NavigationView {
        #if os(macOS)
            EmptyView()
        #endif
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
                        
                        result = ""
                    } label: {
                        Text("Clear Connection Data")
                            .disabled(ipAddress.isEmpty && apiKey.isEmpty)
                    }

                }
                
                Section("Customize") {
                    Picker("Priority", selection: $priority) {
                        ForEach(NotificationPriority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority.rawValue)
                        }
                    }
                    .labelsHidden()
                    
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
                            let row = HStack {
                                Text("Select Icon")
                                Spacer()
                                let selectedIcon = communicator.iconsResponse.data.first { item in
                                    "\(item.id ?? 1234)" == icon
                                }
                                CachedAsyncImage(url: URL(string: selectedIcon?.thumb?.small ?? ""))
                            }
                            
                            #if os(iOS)
                            NavigationLink {
                                IconPickerView(data: communicator.iconsResponse.data, selectedIconID: $icon, isParentViewLoading: $isLoading)
                            } label: {
                                row
                            }
                            #endif
                            
                            #if os(macOS)
                            row
                            .onTapGesture {
                                isShowingIconPickerView.toggle()
                            }
                            .sheet(isPresented: $isShowingIconPickerView, onDismiss: nil) {
                                IconPickerView(data: communicator.iconsResponse.data, selectedIconID: $icon, isParentViewLoading: $isLoading)
                            }
                            #endif
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
                            result = ""
                            communicator.send(message: message,
                                              with: APIConstants.SoundID(rawValue: sound) ?? APIConstants.SoundID.bicycle,
                                              priority: NotificationPriority(rawValue: priority) ?? .warning,
                                              showing: Int(icon) ?? 1234,
                                              for: ipAddress, using: apiKey) { optionalMessage in
                                if let message = optionalMessage {
                                    result = "❌ \(message)"
                                } else {
                                    result = "✅ Sent Message"
                                }
                            }
                        } label: {
                            Text("Send")
                        }
                        .disabled(ipAddress.isEmpty || apiKey.isEmpty)
                    }
                }
                
                if !result.isEmpty {
                    Section {
                        Text(result)
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

//
//  IconPickerView.swift
//  LaMetricCommunicator
//
//  Created by Dan Hart on 2/19/22.
//

import SwiftUI

struct IconPickerView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var data: [Datum]
    @Binding var selectedIconID: String
    @Binding var isParentViewLoading: Bool
    
    @State var searchText = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
            ScrollView {
                #if os(macOS)
                VStack {
                    Text("Pick an Icon")
                        .font(.largeTitle)
                    TextField("Search", text: $searchText)
                        .padding()
                }
                #endif
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        let url = URL(string: item.thumb?.small ?? "")
                        AsyncImage(url: url)
                            .onTapGesture {
                                selectedIconID = "\(item.id ?? 1234)"
                                #if os(iOS)
                                presentationMode.wrappedValue.dismiss()
                                #endif
                            }
                    }
                }
                .searchable(text: $searchText, prompt: "Search")
                .padding(.horizontal)
            }
            .onAppear {
                isParentViewLoading = false
            }
            
            .navigationTitle("Pick an Icon")
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(data: [], selectedIconID: .constant(""), isParentViewLoading: .constant(false))
    }
}

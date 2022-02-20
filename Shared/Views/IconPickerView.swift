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
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        let url = URL(string: item.thumb?.small ?? "")
                        AsyncImage(url: url)
                            .onTapGesture {
                                selectedIconID = "\(item.id ?? 1234)"
                                presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            .navigationTitle("Pick an icon")
        }
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(data: [], selectedIconID: .constant(""))
    }
}

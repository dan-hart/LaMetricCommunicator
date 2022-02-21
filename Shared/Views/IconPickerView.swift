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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }

                }
            }
            
            .navigationTitle("Pick an icon")
        }
        .onAppear {
            isParentViewLoading = false
        }
        #if os(iOS)
        .navigationViewStyle(StackNavigationViewStyle())
        #endif
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(data: [], selectedIconID: .constant(""), isParentViewLoading: .constant(false))
    }
}

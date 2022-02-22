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
    
    @State var dataForDisplay: [Datum] = []
    
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
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    Spacer()
                }.padding()
                Text("Pick an Icon")
                    .font(.largeTitle)
                    .padding(.top)
                TextField("Search", text: $searchText)
                    .padding()
            }
#endif
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(dataForDisplay, id: \.self) { item in
                    let url = URL(string: item.thumb?.small ?? "")
                    CachedAsyncImage(url: url)
                        .onTapGesture {
                            selectedIconID = "\(item.id ?? 1234)"
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    dataForDisplay = data
                    return
                }
                
                dataForDisplay = data.filter { item in
                    item.title?.lowercased().contains(newValue.lowercased()) ?? false
                }
            }
            .searchable(text: $searchText, prompt: "Search")
            .padding(.horizontal)
        }
#if os(macOS)
        .frame(minWidth: 400, minHeight: 400, alignment: .center)
#endif
        .onAppear {
            isParentViewLoading = false
            dataForDisplay = data
        }
        
        .navigationTitle("Pick an Icon")
    }
}

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(data: [], selectedIconID: .constant(""), isParentViewLoading: .constant(false))
    }
}

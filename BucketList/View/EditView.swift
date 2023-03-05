//
//  EditView.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 26/02/23.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        _viewModel = StateObject(wrappedValue: ViewModel(location: location, onSave: onSave))
    }
    
    var body: some View{
        NavigationStack{
            VStack{
                Form{
                    Section{
                        TextField("Place name", text: $viewModel.newName)
                        TextField("Description", text: $viewModel.newDescription)
                    }
                    
                    Section("Nearby..."){
                        switch viewModel.loadingState{
                        case .loaded:
                            ForEach(viewModel.pages, id: \.pageid) { page in
                                Text(page.title)
                                    .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                    .italic()
                                
                            }
                        case .loading:
                            HStack{
                                ProgressView()
                                    .padding(.trailing, 2)
                                Text("Loading...")
                            }
                        case .failed:
                            Text("Please, try again later.")
                        }
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar{
                Button("Save"){
                    var newLocation = viewModel.location
                    newLocation.id = UUID()  // Because of the equatable func - if the id is the same, the object is the same, so it wouldn't make the changes, so we're forcing it, changing the id -
                    newLocation.name = viewModel.newName
                    newLocation.description = viewModel.newDescription
                    
                    viewModel.onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
        }
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ _ in }
    }
}

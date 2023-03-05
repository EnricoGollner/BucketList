//
//  EditView.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 26/02/23.
//

import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.dismiss) var dismiss
    var location: Location
    var onSave: (Location) -> Void
    
    @State private var newName: String
    @State private var newDescription: String
    
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View{
        NavigationStack{
            VStack{
                Form{
                    Section{
                        TextField("Place name", text: $newName)
                        TextField("Description", text: $newDescription)
                    }
                    
                    Section("Nearby..."){
                        switch loadingState{
                        case .loaded:
                            ForEach(pages, id: \.pageid) { page in
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
                    var newLocation = location
                    newLocation.id = UUID()  // Because of the equatable func - if the id is the same, the object is the same, so it wouldn't make the changes, so we're forcing it, changing the id -
                    newLocation.name = newName
                    newLocation.description = newDescription
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void){
        self.location = location
        self.onSave = onSave
        
        _newName = State(initialValue: location.name)
        _newDescription = State(initialValue: location.description)
    }
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
        guard let url = URL(string: urlString) else{
            print("Bad URL")
            return
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let items = try JSONDecoder().decode(Result.self, from: data)
            
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch{
            print("Couldn't download the data.")
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example){ _ in }
    }
}

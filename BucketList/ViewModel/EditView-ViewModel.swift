//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 05/03/23.
//

import Foundation

extension EditView{
    @MainActor class ViewModel: ObservableObject{
        enum LoadingState {
            case loading, loaded, failed
        }
        
        var location: Location
        var onSave: (Location) -> Void
        
        @Published var newName: String
        @Published var newDescription: String
        
        @Published private(set) var pages = [Page]()
        @Published private(set) var loadingState = LoadingState.loading
        
        init(location: Location, onSave: @escaping (Location) -> Void) {
            self.location = location
            self.onSave = onSave
            self.newName = location.name
            self.newDescription = location.description
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
}


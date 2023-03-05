//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 04/03/23.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView{
    @MainActor class ViewModel: ObservableObject {  // MainActor is responsible for running all user interface updates
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        
        let savePath = FileManager.documentsDirectory.appendingPathExtension("SavedPlaces")
        
        init(){
            do{
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch{
                locations = []
                print("Couldn't load any data from documents directory")
            }
            
        }
        
        func save(){
            do{
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch{
                print("Unable to save data.")
            }
        }
        
        func addLocation(){
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location){
            guard let selectedPlace = selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace){
                locations[index] = location
                save()
            }
        }
        
        func authenticate(){
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
                let reason = "Please, authenticate yourself to unlock your data."
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason){ success, authenticationError in
                    if success{
                        Task { @MainActor in
                            self.isUnlocked
                        }
                    } else  {
                        // error
                    }
                }
            } else{
                // No biometrics
            }
        }
    }
}


////
////  IntegratingMapKitWithSwiftUI.swift
////  BucketList
////
////  Created by Enrico Sousa Gollner on 22/02/23.
////
//
//import MapKit
//import SwiftUI
//
//struct Location: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//}
//
//struct IntegratingMapKitWithSwiftUI: View {
//    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
//
//    let locations = [
//        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
//    ]
//
//    var body: some View {
//        NavigationStack{
//            Map(coordinateRegion: $mapRegion, annotationItems: locations){ location in
//                // MapMarker(coordinate: location.coordinate) - Only the system image of a balloon, none information beyond it.
//                MapAnnotation(coordinate: location.coordinate){
//                    NavigationLink{
//                        Text(location.name)
//                    } label: {
//                        Circle()
//                            .stroke(.red, lineWidth: 3)
//                            .frame(width: 30, height: 30)
//                    }
//                }
//            }
//            .navigationTitle("London Explorer")
//        }
//    }
//}
//
//struct IntegratingMapKitWithSwiftUI_Previews: PreviewProvider {
//    static var previews: some View {
//        IntegratingMapKitWithSwiftUI()
//    }
//}

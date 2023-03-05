//
//  ContentView.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 19/02/23.
//

import MapKit
import SwiftUI

struct ContentView: View{
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked{
            ZStack{
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations){ location in
                    MapAnnotation(coordinate: location.coordinate){
                        VStack{
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .background(.white)
                                .frame(width: 44, height: 44)
                                .clipShape(Circle())
                            
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedPlace = location
                        }
                    }
                    
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack{
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button{
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                        
                    }
                }
            }
            .sheet(item: $viewModel.selectedPlace) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(location: newLocation)
                }
            }
        } else {
            VStack{
                Spacer()
                Label("BucketList", systemImage: "airplane.departure")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                Spacer()
                
                Button("Unlock the data"){
                    viewModel.authenticate()
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                Spacer()
                Spacer()
            }
            .alert("Error authenticating", isPresented: $viewModel.showErrorInIdAlert){
                Button("Cancel", role: .cancel){}
                Button("Try again") { viewModel.authenticate() }
            } message: {
                if let error = viewModel.errorOcurred{
                    Text(error.localizedDescription)
                } else{
                    Text("No error!")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

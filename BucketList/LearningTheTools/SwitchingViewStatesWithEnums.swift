////
////  SwitchingViewStatesWithEnums.swift
////  BucketList
////
////  Created by Enrico Sousa Gollner on 21/02/23.
////
//
//import SwiftUI
//
//enum LoadingState{
//    case loading, success, failed
//}
//
//struct LoadingView: View{
//    var body: some View{
//        VStack{
//            ProgressView()
//            Text("Loading...")
//        }
//    }
//}
//
//struct SuccessView: View{
//    var body: some View{
//        Text("Success!")
//    }
//}
//
//struct FailedView: View{
//    var body: some View{
//        Text("Failed.")
//    }
//}
//
//struct SwitchingViewStatesWithEnums: View {
//    var loadingState = LoadingState.loading
//    
//    var body: some View {
//        switch loadingState{
//        case .loading:
//            LoadingView()
//        case .success:
//            SuccessView()
//        case .failed:
//            FailedView()
//        }
//    }
//}
//
//struct SwitchingViewStatesWithEnums_Previews: PreviewProvider {
//    static var previews: some View {
//        SwitchingViewStatesWithEnums()
//    }
//}

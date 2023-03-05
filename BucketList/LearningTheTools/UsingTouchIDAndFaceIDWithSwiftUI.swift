//
//  UsingTouchIDAndFaceIDWithSwiftUI.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 22/02/23.
//

import LocalAuthentication
import SwiftUI

struct UsingTouchIDAndFaceIDWithSwiftUI: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack{
            if isUnlocked{
                Text("Unlocked")
            } else{
                VStack{
                    Text("Locked")
                    
                    Button("Try again", action: authenticate)
                }
            }
        }
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        // Check if biometric authentication is currently possible in the device:
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We want to unlock your data."  // Used to ask permission in TouchID - The FaceID mensage is setted in the info of the project.
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success {
                    isUnlocked = true
                } else{
                    // There was a problem
                }
            }
        } else{
            // There's no biometrics in the device or the user haven't enrolled it
        }
    }
}

struct UsingTouchIDAndFaceIDWithSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        UsingTouchIDAndFaceIDWithSwiftUI()
    }
}

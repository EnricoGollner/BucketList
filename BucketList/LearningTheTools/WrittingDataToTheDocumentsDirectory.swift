//
//  WrittingDataToTheDocumentsDirectory.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 21/02/23.
//

import SwiftUI

struct WrittingDataToTheDocumentsDirectory: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let msg = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do{
                    try msg.write(to: url, atomically: true, encoding: .utf8)
                    
                    // Reading it back:
                    let input = try String(contentsOf: url)
                    print(input)
                } catch{
                    print(error.localizedDescription)
                }
            }
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct WrittingDataToTheDocumentsDirectory_Previews: PreviewProvider {
    static var previews: some View {
        WrittingDataToTheDocumentsDirectory()
    }
}

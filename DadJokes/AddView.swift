//
//  AddView.swift
//  DadJokes
//
//  Created by glenn sandvoss on 5/27/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var setup = ""
    @State private var punchline = ""
    @State private var rating = "Silence"
    
    let ratings = ["Sob", "Sigh", "Silence", "Smirk"]
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Setup", text: $setup)
                    TextField("Punchline", text: $punchline)
                    
                    Picker ("Rating", selection: $rating) {
                        ForEach(ratings, id: \.self) {rating in Text(rating)
                        }
                    }
                }
                Button("Add Joke"){
                    let newJoke = Jokes(context: self.moc)
                    newJoke.setup = self.setup
                    newJoke.punchline = self.punchline
                    newJoke.rating = self.rating
                    
                    do {
                        try self.moc.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("whoops! \(error.localizedDescription)")
                            
                        }
                    }
                    
                }
            }
        }
    }


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

//
//  ContentView.swift
//  DadJokes
//
//  Created by glenn sandvoss on 5/25/21.
//

import SwiftUI
import CoreData



        struct ContentView: View {
            @Environment(\.managedObjectContext) var moc
            @FetchRequest(entity: Jokes.entity(), sortDescriptors: [
                NSSortDescriptor( keyPath: \Jokes.setup,ascending: true)
            ]) var jokes: FetchedResults<Jokes>
            @State private var showingAddJoke = false
            
            
            var body: some View {
                NavigationView {
                    List{
                        ForEach(jokes, id: \.setup) { joke in
                            NavigationLink(destination:
                              Text(joke.punchline)) {
                                EmojiView(for: joke.rating)
                                Text(joke.setup)
                    }
                }
                        .onDelete(perform: removeJokes)
                        
            }.navigationBarTitle("All Groan Up")
                    .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                        self.showingAddJoke.toggle()
                    })
                    .sheet(isPresented: $showingAddJoke) {
                        AddView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
            func removeJokes(at offsets: IndexSet) {
                for index in offsets {
                    let joke = jokes[index]
                    moc.delete(joke)
                }
            }
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}

//
//  JokeCard.swift
//  DadJokes
//
//  Created by glenn sandvoss on 5/29/21.
//
import CoreData
import SwiftUI

struct JokeCard: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showingPunchline = false
    @State private var dragAmount = CGSize.zero
    var joke: Jokes
    var body: some View {
        VStack {
            GeometryReader {geometry in
                VStack {
                    Text(verbatim: self.joke.setup)
                        .font(.largeTitle)
                        .lineLimit(10)
                        .padding([.horizontal])
                    
                    Text(verbatim: self.joke.punchline)
                        .font(.largeTitle)
                        .lineLimit(10)
                        .padding([.horizontal, .bottom])
                        .blur(radius: self.showingPunchline ? 0 : 6)
                        .opacity(self.showingPunchline ? 1 : 0.25)
                    }
                    .multilineTextAlignment(.center)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .background(RoundedRectangle(cornerRadius: 25)
                        .fill(Color.white)
                        .shadow(color: .black, radius: 5, x: 0, y: 0))
                .onTapGesture {
                    withAnimation{
                     self.showingPunchline.toggle()
                    }
                }
                .rotation3DEffect(
                    .degrees(Double(geometry.frame(in: .global).minX) / 10),
                    axis: (x: 0.0, y: 1.0, z: 0.0))
            }

                EmojiView(for: joke.rating)
                    .font(.system(size: 72))
        }
        .padding(.top, 200 )
        .frame(minHeight: 0, maxHeight: 500)
        .frame(width: 300.0)
        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .offset(y: dragAmount.height)
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded {_ in
                    if self.dragAmount.height < -200{
                        withAnimation {
                            self.dragAmount = CGSize(width: 0, height: -1000)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                self.moc.delete(self.joke)
                                //try? self.moc.save()
                                
                            })
                        }
                    } else {
                        self.dragAmount = .zero
                }
            }
        )
        .animation(.spring())
    }
}


struct JokeCard_Previews: PreviewProvider {
    static var previews: some View {
        let joke = Jokes(context: NSManagedObjectContext(concurrencyType:.mainQueueConcurrencyType))
        joke.setup = "What do you call a hen who counts her eggs?"
        joke.punchline = "A mathemachicken"
        joke.rating = "Sigh"
        
        return JokeCard(joke: joke)
    }
}

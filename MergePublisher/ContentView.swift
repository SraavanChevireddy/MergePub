//
//  ContentView.swift
//  MergePublisher
//
//  Created by Sraavan Chevireddy on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var test = TestMergeViewModel()
    @State var value = ""
    var body: some View {
        VStack{
            TextField("type something", text: Binding(
                       get: { value },
                       set: { newVal in
                           if value.removeSpaces.count < 16 {
                               if newVal.removeSpaces.elementsEqual(value.removeSpaces) &&
                                    newVal.removeSpaces.count.isMultiple(of: 4) {
                                   value = newVal + " "
                               } else {
                                   value = newVal
                               }
                           }
                   }))
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], content: {
                    Button {
                        test.one.send("I'm First")
                    } label: {
                        Text("ONE")
                    }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    
                    Button {
                        test.two.send("I'm Second")
                    } label: {
                        Text("TWO")
                    }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    
                    Button {
                        test.three.send("I'm Third")
                    } label: {
                        Text("THREE")
                    }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    
                    Button {
                        test.four.send("I'm Fourth")
                    } label: {
                        Text("FOUR")
                    }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                
                Button {
                    test.six.send("I'm SIX")
                } label: {
                    Text("FIVE - Upcast")
                }.buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                    
                    Button {
                        test.one.send("I'm first")
                        test.two.send("I'm Second")
                        test.three.send("I'm Third")
                        test.four.send("I'm Fourth")
                    } label: {
                        Text("MERGE!")
                    }.buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
            })
        }.padding()
            .onChange(of: value) { newValue in
                test.one.send(newValue)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    var removeSpaces: String {
        replacingOccurrences(of: " ", with: "")
    }
}

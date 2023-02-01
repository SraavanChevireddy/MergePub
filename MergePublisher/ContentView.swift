//
//  ContentView.swift
//  MergePublisher
//
//  Created by Sraavan Chevireddy on 02/02/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var test = TestMergeViewModel()
    var body: some View {
        VStack(spacing: 15) {
            Button {
                test.one.send("I'm First")
            } label: {
                Text("ONE")
            }
            
            Button {
                test.two.send("I'm Second")
            } label: {
                Text("TWO")
            }
            
            Button {
                test.three.send("I'm Third")
            } label: {
                Text("THREE")
            }
            
            Button {
                test.four.send("I'm Fourth")
            } label: {
                Text("FOUR")
            }
            
            Button {
                test.one.send("I'm first")
                test.two.send("I'm Second")
                test.three.send("I'm Third")
                test.four.send("I'm Fourth")
            } label: {
                Text("MERGE!")
            }


        }.padding()
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

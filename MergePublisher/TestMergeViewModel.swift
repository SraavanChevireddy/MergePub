//
//  TestMergeViewModel.swift
//  MergePublisher
//
//  Created by Sraavan Chevireddy on 02/02/23.
//

import Foundation
import Combine

class TestMergeViewModel: ObservableObject {
    
    var one = PassthroughSubject<String, Never>()
    var two = PassthroughSubject<String, Never>()
    var three = PassthroughSubject<String, Never>()
    var four = PassthroughSubject<String, Never>()
    
    @Published var userName = ""
    
    var disposables = Set<AnyCancellable>()
    
    init (){
        one.sink { _ in
            
        } receiveValue: { value in
            debugPrint("One value received")
            print("USERNAME ==== \(self.userName)")
        }.store(in: &disposables)
        
        two.sink { _ in
            
        } receiveValue: { value in
            debugPrint("Two value received")
        }.store(in: &disposables)
        
        three.sink { _ in
            
        } receiveValue: { value in
            debugPrint("Three value received")
        }.store(in: &disposables)
        
        four.sink { _ in
            
        } receiveValue: { value in
            debugPrint("Four value received")
        }.store(in: &disposables)
        
        
        one.combineLatest(two, three, four)
            .share()
            .sink { _ in
                
            } receiveValue: { one, two , three, four in
                debugPrint(" \(one) -- \(two) --- \(three) --- \(four) TRIGGERED")
            }.store(in: &disposables)
        
        one.zip(two, three) { one, second, three in
            print("\(one) >>>>> \(second) >>>> \(three)")
        }.sink { _ in
            
        } receiveValue: {  _ in
            print("I'm Zipped")
        }.store(in: &disposables)
        
        one.share().upstream.assign(to: \.userName, on: self)
            .store(in: &disposables)
        

    }
    
}

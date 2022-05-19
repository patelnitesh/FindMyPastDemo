//
//  ProfilesViewModel.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import Foundation
import Combine


public class ProfilesViewModel: ObservableObject {
    
    private let service: FindMyPastService
    private(set) var profiles: [Person] = []
    @Published private(set) var state: ResultState = .loading
    private var cancellable = Set<AnyCancellable>()

    init(service: FindMyPastService) {
        self.service = service
        self.getProfiles()
    }
    
    func getProfiles() {
        self.state = .loading
        let cancellable = self.service
            .requestProfiles(from: .getProfiles(userId: "cgriswold"))
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.profiles = []
                    self.state = .failed(error.toEquatableError())
                case .finished:
                    self.state = .success
                }
            } receiveValue: { res in
                guard let persons = res.data else {
                    return
                }
                self.profiles = persons
            }
        
        self.cancellable.insert(cancellable)
    }
}

//
//  ProfileViewModel.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import Combine
import Foundation
import SwiftUI

public class PersonViewModel: ObservableObject {
    private let service: FindMyPastService
    private(set) var personId: String
    @Published var person: Person!

    @Published private(set) var state: ResultState = .loading
    private var cancellable = Set<AnyCancellable>()

    init(service: FindMyPastService, personId: String, person: Person? = nil) {
        self.service = service
        self.personId = personId
        self.person = person
        // TODO: this load before even details-view load
        self.getProfile()
    }
    
    func getProfile() {
        self.state = .loading
        let cancellable = self.service
            .requestProfile(from: .getProfile(userId: "cgriswold", personId: personId))
            .sink { (res) in
                switch res {
                case .failure(let error):
                    self.person = nil
                    self.state = .failed(error.toEquatableError())
                case .finished:
                    self.state = .success
                }
            } receiveValue: { res in
                guard let person = res.data else {
                    return
                }
                self.person = person
            }
        self.cancellable.insert(cancellable)
    }
}

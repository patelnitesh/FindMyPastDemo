//
//  ProfilesView.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import SwiftUI

struct ProfilesView: View {
    @ObservedObject var viewModel: ProfilesViewModel
    var username: String
    
    init(username: String) {
        self.username = username
        viewModel = ProfilesViewModel(service: FMPService(), username: username)
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error) {
                self.viewModel.getProfiles(username: username)
            }
        case .success:
            if viewModel.profiles.count == 0 {
                let noDataError = APIError.noProfilesUser(username)
                ErrorView(error: noDataError) {
                    self.viewModel.getProfiles(username: username)
                }
            }
            
            List{
                ForEach(viewModel.profiles, id: \.id) { person in
                    
                    NavigationLink (destination: PersonDetailsView(person: person)) {
                        HStack(alignment: .center, spacing: 10) {
                            AsyncImageView(url: person.image ?? "BadURL")
                                .frame(width: 50, height: 50, alignment: .center)
                                .transition(.opacity.combined(with: .scale))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(person.fullName).font(.callout)
                                Text(person.dateOfBirth).font(.caption2)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Profiles")
            .refreshable {
                self.viewModel.getProfiles(username: username)
            }
        }
    }
}


struct ProfilesView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilesView(username: "SomeUSerNAME")
    }
}

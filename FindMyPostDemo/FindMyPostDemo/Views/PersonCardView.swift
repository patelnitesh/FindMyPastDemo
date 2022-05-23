//
//  ProfileCardView.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import SwiftUI

struct PersonCardView: View {
    let profileId: String
    let relationshipTitle: String
    let isSelected: Bool
    @ObservedObject var viewModel: PersonViewModel
    
    init(profileId: String, isSelected:Bool = false, relationshipTitle: String = "") {
        self.profileId = profileId
        self.isSelected = isSelected
        self.relationshipTitle = relationshipTitle
        viewModel = PersonViewModel(service: FMPService(), personId: profileId)
    }
    
    var body: some View {
        
        switch viewModel.state {
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error) {
                self.viewModel.getProfile()
            }
        case .success:
            VStack{
                if let person = viewModel.person {
                    VStack(alignment: .center, spacing: 5) {
                        Text(relationshipTitle)
                        AsyncImageView(url: person.image ?? "BadURL")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100, alignment: .center)
                            
                        VStack(alignment: .center, spacing: 5) {
                            Text(person.firstname ?? "No firstname").font(.callout)
                            Text(person.surname ?? "No lastname").font(.callout)
                            Text(person.dateOfBirth).font(.caption2)
                        }
                    }
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(isSelected ? .blue : .black, lineWidth: 3))
                }
            }
        }
    }
}


struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        PersonCardView(profileId: "001")
    }
}

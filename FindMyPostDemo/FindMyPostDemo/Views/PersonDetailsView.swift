//
//  PersonDetailsView.swift
//  FindMyPostDemo
//
//  Created by Nitesh Patel on 18/05/2022.
//

import SwiftUI

struct PersonDetailsView: View {
    @State var person: Person
    @ObservedObject var viewModel: PersonViewModel
    
    init( person: Person) {
        self.person = person
        viewModel = PersonViewModel(service: FMPService(), personId: person.id ?? "_")
    }
    
    var body: some View {
        
        switch viewModel.state {
        case .loading: Text("Loading")
        case .failed(_):
            Text("can not find relationship")
        case .success:
            if let relationships = viewModel.person.relationships {
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .center, spacing: 30) {
                        
                        // Father - Mother
                        HStack(alignment: .center, spacing: 30) {
                            PersonCardView(profileId: relationships.father ?? "Noid",relationshipTitle: "FATHER")
                            PersonCardView(profileId: relationships.mother ?? "Noid", relationshipTitle: "MOTHER")
                        }
                        
                        // Main - Spouse
                        HStack{
                            // pass isSelected - TRUE for Main Person - Whos tree we are watching
                            PersonCardView(profileId: person.id ?? "_", isSelected: true)
                            PersonCardView(profileId: relationships.spouse ?? "Noid",relationshipTitle: "SPOUSE")
                        }
                        
                        // Children
                        VStack{
                            if let children = relationships.children {
                                ForEach(children, id: \.self) { child in
                                    PersonCardView(profileId: child)
                                }
                            }
                        }
                    }.padding(10)
                }
            }
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(person: Person.dummyPerson())
    }
}

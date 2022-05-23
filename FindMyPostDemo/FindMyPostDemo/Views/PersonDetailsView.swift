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
    
    // TODO: WIP - Experiment to connect each PersonCard and relatioships
    fileprivate func drawRelationshipLines() -> some View {
        return VStack(alignment: .center, spacing: 0) {
            Spacer(minLength: 200)
            Rectangle().frame(width: 22, height: 2, alignment: .center)
                .border(.blue, width: 1)
            
            Rectangle().frame(width: 2, height: 200, alignment: .center)
                .border(.red, width: 1)
        }
    }
    
    var body: some View {
        switch viewModel.state {
        case .loading: Text("Loading")
        case .failed(_):
            Text("Can not find relationship for \(person.fullName)")
        case .success:
            if let relationships = viewModel.person.relationships {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 30) {
                        
                        // Father - Mother
                        HStack(alignment: .center, spacing: 30) {
                            PersonCardView(profileId: relationships.father ?? "Noid",relationshipTitle: "FATHER")
                            
                           //drawRelationshipLines()

                            PersonCardView(profileId: relationships.mother ?? "Noid", relationshipTitle: "MOTHER")
                        }
                        
                        Spacer(minLength: 10)
                        
                        // Main - Spouse
                        HStack(alignment: .center, spacing: 30){
                            // pass isSelected - TRUE for Main Person - Whos tree we are watching
                            PersonCardView(profileId: person.id ?? "_", isSelected: true)
                            PersonCardView(profileId: relationships.spouse ?? "Noid",relationshipTitle: "SPOUSE")
                        }
                        
                        Spacer(minLength: 10)
                        
                        // Children
                        VStack{
                            if let children = relationships.children {
                                Text("CHILDREN")
                                ForEach(children, id: \.self) { child in
                                    PersonCardView(profileId: child)
                                }
                            }
                        }
                    }.padding(10)
                }
                .navigationTitle(person.fullName)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(person: Person.dummyPerson())
    }
}

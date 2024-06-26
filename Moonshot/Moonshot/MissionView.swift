//
//  MissionView.swift
//  Moonshot
//
//  Created by Ahmed Adel on 15/03/2024.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                
                Text(mission.formattedLaunchDate)
                    .padding(.top, 3)
                    .font(.caption.bold())
                    .foregroundColor(.white.opacity(0.7))
                
                
                
                VStack(alignment: .leading) {
                    
                    // Custom Devider
                    LineSeperator()
                    
                    Text("Mission Highlights")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    // Custom Devider
                    LineSeperator()
                    
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            CrewMemberView(crewMember: crewMember)
                        }
                    }
                }
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}


//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(crew, id: \.role) { crewMember in
//                            NavigationLink {
//                                AstronautView(astronaut: crewMember.astronaut)
//                            } label: {
//                                Image(crewMember.astronaut.id)
//                                    .resizable()
//                                    .frame(width: 104, height: 72)
//                                    .clipShape(.circle)
//                                    .overlay(
//                                        Circle()
//                                            .strokeBorder(.white, lineWidth: 1)
//                                    )
//                                VStack(alignment: .leading) {
//                                    Text(crewMember.astronaut.name)
//                                        .foregroundStyle(.white)
//                                        .font(.headline)
//
//                                    Text(crewMember.role)
//                                        .foregroundStyle(.secondary)
//
//                                }
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                }

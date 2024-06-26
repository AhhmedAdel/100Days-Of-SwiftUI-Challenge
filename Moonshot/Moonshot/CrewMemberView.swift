import SwiftUI

struct CrewMemberView: View {
    let crewMember: MissionView.CrewMember
    
    var body: some View {
        NavigationLink {
            AstronautView(astronaut: crewMember.astronaut)
        } label: {
            HStack {
                Image(crewMember.astronaut.id)
                    .resizable()
                    .frame(width: 104, height: 72)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 1)
                    )
                VStack(alignment: .leading) {
                    Text(crewMember.astronaut.name)
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(crewMember.role)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal)
    }
}

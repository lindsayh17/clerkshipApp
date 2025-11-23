//
//  HomeNavCardView.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/22/25.
//

struct HomeNavCard: View {
    var title: String
    var icon: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(12)
                    .background(color.opacity(0.8))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.leading, 4)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding()
            .background(Color.white.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

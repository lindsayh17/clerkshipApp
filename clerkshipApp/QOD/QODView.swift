//
//  QODView.swift
//  clerkshipApp
//
import SwiftUI

struct QODView: View {
    @State var showDailyQuestionAnswer = false
    @EnvironmentObject var qod: QODStore
    
    var body: some View {
        // Daily Question
        SectionView(title: "Daily Question") {
            VStack(alignment: .leading, spacing: 12) {
                if let dailyQuestion = qod.qod{
                    Text(dailyQuestion.questionText)
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .bold()
                Button(action: {
                        withAnimation {
                            // Show answer
                            showDailyQuestionAnswer.toggle()
                        }
                    }) {
                        Text(showDailyQuestionAnswer ? "Hide Answer" : "Show Answer")
                            .underline()
                    }
                    // Answer
                    if showDailyQuestionAnswer {
                        if let dailyAnswer = qod.qod{
                            Text(dailyAnswer.answer)
                                .foregroundColor(.white)
                        }
                    }
                } else {
                    Text("No daily question available.")
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
    }
}

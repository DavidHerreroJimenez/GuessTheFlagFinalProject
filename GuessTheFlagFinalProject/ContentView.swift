// Package: GuessTheFlagFinalProject,
// File name: ContentView.swift,
// Created by David Herrero on 05/11/2019.

import SwiftUI

struct ContentView: View {
 @State private var countries = ["Estonia",
                   "France",
                   "Germany",
                   "Ireland",
                   "Italy",
                   "Nigeria",
                   "Poland",
                   "Russia",
                   "Spain",
                   "UK",
    "US"].shuffled()
  
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var myCountryName = ""
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
    func flagTapped(_ number: Int,_ countryName: String) {
        
        myCountryName = countryName
        
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    
  
  var body: some View {
    ZStack {
//      Color(red: 31 / 255,
//            green: 56 / 255,
//            blue: 100 / 255)
//        .edgesIgnoringSafeArea(.all)
        LinearGradient(gradient: Gradient(colors:[.blue,.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundColor(.white)
          Text(countries[correctAnswer])
            .foregroundColor(.white).font(.largeTitle).fontWeight(.black)
        }
        
        ForEach(0 ..< 3) { number in
          Button(action: {
            self.flagTapped(number, self.countries[number])
          }) {
            Image(self.countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
          }.shadow(color: .gray, radius: 10)
        }
        Spacer()
      }
    }.alert(isPresented: $showingScore) {
          Alert(title: Text(scoreTitle),
                message: Text("Your score is \(myCountryName) ?"),
                dismissButton: .default(Text("Continue")) {
                  self.askQuestion()
          })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

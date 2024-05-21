//
//  ContentView.swift
//  typingTest
//
//  Created by minhkhoi mac on 5/18/24.
//

import SwiftUI
import Foundation

struct Quote {
    let id: Int
    let numWords: Int
    let quoteText: String
    let quoteAuthor: String
}

struct SobrietyTest1: View {
    // Quotes array
    @State private var quotes = [Quote]() // Array to store texts from JSON
    @State private var grabbedQuote: Quote?
    
    @ObservedObject var viewmodel : CoreMotionViewModel = .shared

    // Text properties
    @State private var displayedText = "" // Currently displayed text
    @State private var textAuthor: String = "" // Author of the displayed text
    @State private var typedText = "" // Text typed by the user
    @State private var textIndex = 0 // Index of the currently displayed text
    @State private var numWords = 0 // Number of words in the displayed text
    @State private var numChars = 0 // Number of characters in the displayed text

    @State private var isDone = false

    // calculated values
    @State private var startTime: Date? // Time when typing test starts
    @State private var endTime: Date? // Time when typing test ends
    @State private var elapsedTime: TimeInterval = 0 // Elapsed time in seconds
    @State private var wordErrorCount = 0 // Count of word errors
    @State private var characterErrorCount = 0 // Count of character errors
    @State private var totalTypedCharacters = 0 // Total typed characters
    @State private var wpm: Double = 0.0 // Words per minute
    @State private var numCharsTyped = 0
    @State private var TypeError = 0
    @State private var accuracy = 0.0

    var body: some View {
        VStack {
            // Display command in bold
            Text("Sobriety Test")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text("Type the following sentence while walking in a straight line:")
                .font(.system(size: 20))
                .foregroundColor(Color.blue)
                .padding()
                .multilineTextAlignment(.center)
            Image(systemName:"arrow.up")
                .foregroundColor(viewmodel.Col)
                .bold()
                .font(.system(size: 50))
            Text(quotes.isEmpty ? "Loading..." : displayedText)
                .padding()
                .bold()
                .italic()
                .font(.system(size: 20))
            // grab the last character and index of the typed text
            // and compares it to displayed text
            
            TextField("Type here", text: $typedText)
                .padding()
                .onChange(of: typedText) { newValue in
                    if let lastCharacter = newValue.last {
                        if typedText.firstIndex(of: lastCharacter) != grabbedQuote?.quoteText.firstIndex(of: lastCharacter) {
                            TypeError+=1
                        }
                        numCharsTyped += 1
                        // let typedIndex = newValue.index(before: newValue.endIndex)
                        // let typedCharacter = newValue[typedIndex]
                        // let displayedIndex = displayedText.index(displayedText.startIndex, offsetBy: totalTypedCharacters)
                        // let displayedCharacter = displayedText[displayedIndex]
                        // if typedCharacter == displayedCharacter {
                        //     totalTypedCharacters += 1
                        // } else {
                        //     totalTypedCharacters += 1
                        //     characterErrorCount += 1
                        // }
                        // if lastCharacter == " " {
                        //     let typedWords = typedText.split(separator: " ")
                        //     let displayedWords = displayedText.split(separator: " ")
                        //     if typedWords.count == displayedWords.count {
                        //         for (index, word) in typedWords.enumerated() {
                        //             if word != displayedWords[index] {
                        //                 wordErrorCount += 1
                        //             }
                        //         }
                        //     }
                        // }
                    }
                }
            Text("Author: \(textAuthor)")
            Text("WPM: \(wpm, specifier: "%.1f")")
            Spacer()
            Button(action: {
                    //startTypingTest()
                //viewmodel.error = 0
                //TypeError = 0
                    //viewmodel.startUpdates()
                    calculateMetricsFinal()
                    isDone = true
                    endTime = Date()
                    elapsedTime = endTime!.timeIntervalSince(startTime!)
                    wpm = Double(numWords) / (elapsedTime / 60.0)
                    accuracy = (1 - (Double(numCharsTyped - numChars) / Double(numChars))) * 100
                    print("Elapsed time in seconds: \(elapsedTime)")
                    print("Words per minute: \(wpm)")
                    print("Accuracy: \(accuracy)")
                if isSober() {
                  
                }
                else{
                    returnDrunk()
                }
                
                }) {
                    NavigationLink(destination:isSober() ? AnyView(Results1View()) : AnyView(Results2View()) ) {
                        Text("Submit")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                    
                }
                .padding()

        }
        .padding()
        .onAppear {
            if let quotes = loadTexts() {
                self.quotes = quotes
            }
            startTypingTest()
            viewmodel.error = 0
            //TypeError = 0
            viewmodel.startUpdates()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func returnSober() -> some View{
        Results1View()
    }
    
    func returnDrunk() -> some View {
       Results2View()
    }

    func findQuoteText(byId id: Int, inQuotes quotes: [Quote]) -> String? {
    // Filter the quotes array to find the Quote object with the given ID
    if let quote = quotes.first(where: { $0.id == id }) {
        return quote.quoteText
    } else {
        return nil // ID not found
    }
}
    
    func loadTexts() -> [Quote]? {
        do {
            // Get the URL of your JSON file
            guard let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
                return nil
            }

            // Read the data from the file
            let data = try Data(contentsOf: fileURL)

            // Parse the JSON data
            let quotesData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]

            // Process the JSON data into an array of Quote objects
            let quotes = quotesData?.compactMap { dict -> Quote? in
                guard let id = dict["id"] as? Int,
                      let numWords = dict["num_words"] as? Int,
                      let quoteText = dict["quoteText"] as? String,
                      let quoteAuthor = dict["quoteAuthor"] as? String else {
                    return nil
                }
                return Quote(id: id, numWords: numWords, quoteText: quoteText, quoteAuthor: quoteAuthor)
            }
            return quotes
        } catch {
            print("Error reading JSON file: \(error)")
            return nil
        }
    }
    
    func startTypingTest() {
        // Randomly select a text from the 'texts' array
        let randomQuote = quotes.randomElement()
        if let randomQuote = randomQuote {
            numWords = randomQuote.numWords
            grabbedQuote = randomQuote
            textIndex = randomQuote.id
            textAuthor = randomQuote.quoteAuthor
            displayedText = randomQuote.quoteText
            numChars = displayedText.count
        }
        
        // Reset timer
        startTime = Date()
    }
    
    
    func isSober() -> Bool{
        print(viewmodel.Soberness)
        print(TypeError)
        if viewmodel.Soberness == "Drunk" || ( TypeError > 5){
            return false
    
        }
        else {return true}
        
        
        
    }
    
    func calculateMetricsFinal() {
        if let startTime = startTime {
            let endTime = Date()
            let timeTaken = endTime.timeIntervalSince(startTime) // in seconds
            let minutes = timeTaken / 60.0 // convert to minutes
            
            // Calculate WPM
            let words = totalTypedCharacters / 5 // Assuming average word length of 5 characters
            wpm = Double(words) / minutes
            
            // Calculate error rates
            let wordErrorRate = Double(wordErrorCount) / Double(words)
            let characterErrorRate = Double(characterErrorCount) / Double(totalTypedCharacters)
            
            // // Provide feedback to the user
            // print("WPM: \(wpm)")
            // print("Word Error Rate: \(wordErrorRate)")
            // print("Character Error Rate: \(characterErrorRate)")
        }
    }
}


#Preview {
    SobrietyTest1()
}

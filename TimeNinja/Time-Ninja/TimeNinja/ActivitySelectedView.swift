//
//  ActivitySelected.swift
//  TimeNinja
//
//  Created by Francesca Ferrini on 20/10/23.
//
import Foundation
import SwiftUI
import Combine


struct ActivitySelectedView: View {
    
    
    var nameRecived: String
    var imageRecived: String
    var dateRecived = String()
    var timerRecived = String()
    var notesRecived = String()
    var minutesRecived = Float()
    
    
    
    
    init(nameRecived: String, imageRecived: String, dateRecived: String,
         timerRecived: String, notesRecived: String, minutesRecived: Float) {
        self.nameRecived = nameRecived
        self.imageRecived = imageRecived
        self.dateRecived = dateRecived
        self.timerRecived = timerRecived
        self.notesRecived = notesRecived
        self.minutesRecived = minutesRecived
        _time = State(initialValue: timerRecived)
    }
    
    //VARUIABILI TEMPO
    @State var isActive = false
    @State var isComplete = false
    @State var time: String = "\(String()):00"
    @State var minutes: Float = 3.0 {
        didSet{
            self.time = "\(Int(minutes)):00"
        }
    }
    @State private var initialTime = 0
    @State private var endDate = Date()
    @State private var progress: Float = 0.0
    @State private var count = 10
    private let timer = Timer.publish(every: 1, on: .main, in:
            .common).autoconnect()
    
    
    
    
    
    var body: some View{
        
        
        VStack {
            
            Text(" \(nameRecived)")
                .font(.system(size: 50))
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 15)
            
            Image(systemName: imageRecived)
                .resizable()
                .frame(width: 70, height: 60)
                .padding(.top,15)
            
            
            Text("\(time)")
                .font(.system(size: 50, weight: .medium, design: .rounded))
                .padding()
                .frame(width: 250)
                .cornerRadius(20)
                .onReceive(timer) { _ in
                    updateCountdown()
                    self.time = ("\(time):00").replacingOccurrences(of: ":00", with: "", options: NSString.CompareOptions.literal, range: nil)
                    if isActive {
                        if progress < 1.0 {
                            progress += 1.0 / Float(minutesRecived * 60)
                        } else {
                            isActive = false
                        }
                    }
                }
            
            ZStack(alignment: .leading) {
                ProgressView(value: progress)
                    .scaleEffect(2, anchor: .center)
                    .frame(width: 180)
                
            }
            
            
            
            Button(action: {
                self.start(minutesTime: minutes)
                print("Start")
            }){
                Image(systemName: "play.circle")
                //.cornerRadius(34)
                    .font(Font.system(size: 40))
                    .frame(width: 34 , height:34, alignment: .center)
                
            }.padding(.top,20)
                .disabled(isActive)
            
            
            
            
            VStack(alignment: .leading){
                Text("**Note**:\n\(notesRecived)")
                    .font(.system(size: 30))
                    .font(.body)
                    .padding(.top, 100)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
      
                  
       
            
            Spacer() // Questo spazierà il contenuto verso l'alto
        }
        
    }
    
    func start(minutesTime: Float) {
        time = timerRecived
        minutes = minutesRecived
        initialTime = (Int(minutes))
        endDate = Date()
        isActive = true
        endDate = Calendar.current.date(byAdding: .minute, value:
                                            Int(minutes), to: endDate)!
    }
    
    func updateCountdown(){
        guard isActive else { return }
        // Gets the current date and makes the time difference calculation
        let now = Date()
        let diff = endDate.timeIntervalSince1970 -
        now.timeIntervalSince1970
        
        // Checks that the countdown is not <= 0
        if diff <= 0 {
            self.isActive = false
            self.time = "0:00"
            self.isComplete = true
            return
        }
        
        // Turns the time difference calculation into sensible data and formats it
        let date = Date(timeIntervalSince1970: diff)
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        // Updates the time string with the formatted time
        self.minutes = Float(minutes)
        self.time = String(format:"%d:%02d", minutes, seconds)
    }
}

#Preview {
    ActivitySelectedView(nameRecived: "", imageRecived: "", dateRecived:
                            "", timerRecived: "", notesRecived: "", minutesRecived: Float())
}


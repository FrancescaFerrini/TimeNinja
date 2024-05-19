import SwiftUI
import Foundation
import Combine




struct ContentView: View {
    
    @State private var dateFormatter: DateFormatter = DateFormatter()
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var notes: String = ""
    @State private var timer: String = ""
    @State private var selectedCategoryIndex = 0
    @State private var selectedCategory: String = ""
    @Binding var savedData: [(name: String, notes: String, date: String, timer: String, category: String, categoryImage: String)]
    @Binding var shouldUpdateMainScreen: Bool
    @State private var isMainScreenActive: Bool = false
    
    let categoryIcons: [(String, String)] = [
        ("gamecontroller", "  Hobbies"),
        ("figure.basketball", "  Sports"),
        ("globe.europe.africa", "  Social"),
        ("brain.fill", "  Read"),
        ("book", "  Study"),
        ("briefcase", "  Work"),
        ("figure.cooldown", "  Exercise"),
        ("paintpalette", "  Creative"),
        ("frying.pan", "  Cooking"),
        ("calendar", "  Planning"),
        ("figure.mind.and.body", "  Meditation"),
        ("target", "  Goal Setting"),
        ("bed.double.fill", "  Rest"),
        ("ear.fill", "  Listening"),
        ("pencil", "  Writing"),
        ("graduationcap", "  Learning"),
        ("umbrella.fill", "  Relaxation"),
        ("music.note", "  Music"),
        ("folder", "  Other")
    ]
    
    @Environment(\.presentationMode) var goBack
    @State private var isSaveButtonPressed = false
    
    var isButtonEnabled: Bool {
        return !name.isEmpty && !notes.isEmpty && !timer.isEmpty
    }
    
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                List {
                    HStack() {
                        Text("Name").multilineTextAlignment(.leading)
                        Spacer(minLength: 72)
                        TextField("Value", text: $name)
                            .frame(height: 35)
                            .padding(.leading, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                    }
                    HStack() {
                        Text("Date&Time").multilineTextAlignment(.leading)
                        Spacer(minLength: 20)
                        DatePicker("", selection: $date)
                    }
                    HStack() {
                        Text("Notes").multilineTextAlignment(.leading)
                        Spacer(minLength: 72)
                        TextField("Value", text: $notes)
                            .frame(height: 35)
                            .padding(.leading, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    HStack() {
                        Text("Timer").multilineTextAlignment(.leading)
                        Spacer()
                        TextField("30", text: $timer)
                            .keyboardType(.numberPad)
                            .frame(width: 40, height: 35)
                            .padding(.leading, 10)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        Text("minutes")
                    }
                    HStack() {
                        Text("Category")
                        Spacer()
                        
                        Picker(selection: $selectedCategoryIndex, label: Text("")) {
                            ForEach(0..<categoryIcons.count, id: \.self) { index in
                                HStack {
                                    Image(systemName: self.categoryIcons[index].0)
                                        .font(.system(size: 30))
                                        .tag(index)
                                    
                                    Text(self.categoryIcons[index].1)
                                        .font(.body)
                                        .foregroundColor(.primary)
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                    
                }
                
               // .listStyle(GroupedListStyle())
                
            }
            .navigationTitle("New Task")
            .navigationBarItems(
                trailing: Button("Save", action: {
                    isSaveButtonPressed.toggle()
                    let imageCategory = categoryIcons[selectedCategoryIndex].0
                    let selectedCategory = categoryIcons[selectedCategoryIndex].1
                    dateFormatter.dateFormat = "MM/dd/yy"
                    let dateString = dateFormatter.string(from: date)
                    print(dateString)
                    print(imageCategory)
                    print(selectedCategory)
                    // Aggiungi i dati all'array savedData
                    savedData.append((name: name, notes: notes, date: dateString, timer: timer, category: selectedCategory, categoryImage: imageCategory))
                        
                        // Imposta shouldUpdateMainScreen su true
                        shouldUpdateMainScreen = true
                    name = ""
                    notes = ""
                    timer = ""
                    date = Date()
                    selectedCategoryIndex = 0
                    isMainScreenActive = true
                    print(savedData)
                    self.goBack.wrappedValue.dismiss()
                    
                    
                }).disabled(!isButtonEnabled)
                
            )
            
            
        }
        .navigationBarTitleDisplayMode(.inline)
        
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(savedData: .constant([]), shouldUpdateMainScreen: .constant(false))
    }
}

import SwiftUI



struct MainScreenView: View {
    
    @State private var searchText = ""
    @State private var isContentViewActive = false
    @State private var isListActive = false
    
    
    
    
    var currentDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: Date())
    }
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: Date())
    }
    
    @State var newMinutes = Float()
    
    
    @State private var savedData: [(name: String, notes: String, date: String, timer: String, category: String, categoryImage: String)] = []
    
    @State private var shouldUpdateMainScreen = false // Nuova variabile di stato
    
    
    
    
    var body: some View {
        
        @State var isItemActive: [Bool] = []
        
        NavigationStack {
            VStack(spacing: 20) {
                
                HStack(alignment: .center, spacing: 0) {
                    
                    
                    TextField("Search", text: $searchText)
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(Color(.label))
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                    
                        .padding(.trailing, 10)
                        .padding(.top, 20)
                        .overlay(HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .padding(.top, 20);
                            Button(action: {
                            }){Image(systemName: "mic.fill")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                                    .padding()
                                .padding(.top, 20)}
                        })
                    
                }
                .padding([.leading, .trailing], 16)
                
                /*Text(currentDay)
                 .font(Font.custom("SF Pro", size: 36))
                 .foregroundColor(Color(.label))
                 .padding(.leading, -165)*/
                
                Text(currentDate)
                    .font(Font.custom("SF Pro", size: 24))
                    .foregroundColor(Color(.label))
                    .padding(.leading, -160)
                    .padding(.top, 20)
                
                
                List{
                    ForEach(savedData, id: \.name) { data in
                        
                        HStack(spacing: 40) {
                            NavigationLink(destination: ActivitySelectedView(nameRecived: data.name, imageRecived: data.categoryImage, dateRecived:
                                                                                data.date, timerRecived: data.timer, notesRecived: data.notes, minutesRecived: Float(data.timer) ?? 0.0)) {
                            Image(systemName: data.categoryImage)
                                .resizable()
                                .frame(width: 50, height: 40)
                                .foregroundColor(Color(.label))
                                .background(Color(.white))
                            VStack(alignment: .leading) {
                                Text("Name: \(data.name)")
                                    .bold()
                                    .font(Font.custom("SF Pro", size: 20))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, minHeight: 22, maxHeight: 22, alignment: .leading)
                                
                                
                                /*Text("\(data.date)")
                                 .font(Font.custom("SF Pro", size: 15))
                                 .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                                 .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .leading)*/
                                HStack{
                                    Text("\(data.category)")
                                        .frame(alignment: .leading)
                                        .padding(.leading, -10)
                                        .padding(.trailing, 20)
                                        .padding(.vertical, 5)
                                    
                                    
                                    Text("Timer: \(data.timer)")
                                        .padding(.leading, 0)
                                        .padding(.trailing, 16)
                                        .padding(.vertical, 0)
                                    
                                }
                                Text("Notes: \(data.notes)")
                                    .font(.subheadline)
                                
                            }
                            
                            /*.swipeActions(edge: .trailing, allowsFullSwipe: false) {
                             Button(role: .destructive) {
                             // Show a confirmation alert here
                             let alert = UIAlertController(title: "Are you sure you want to delete this task?", message: nil, preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                             alert.addAction(UIAlertAction(title: "Delete", style: .destructive){ _ in
                             if let index = savedData.firstIndex(where: { $0.name == data.name }) {
                             savedData.remove(at: index)
                             }
                             })
                             /*alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                              // Handle cancel action here (do nothing)
                              alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                              // Handle delete action here
                              if let index = savedData.firstIndex(where: { $0.name == data.name }) {
                              savedData.remove(at: index)
                              }
                              })*/
                             
                             UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                             } label: {
                             Label("Delete", systemImage: "trash")
                             }
                             /*UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                              } label: {
                              Label("Delete", systemImage: "trash")
                              }*/
                             }*/
                            
                            
                        }
                        } .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .cancel) {
                                
                                // Show a confirmation alert here
                                let alert = UIAlertController(title: "Are you sure you want to delete this task?", message: nil, preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                                alert.addAction(UIAlertAction(title: "Delete", style: .destructive){ _ in
                                    if let index = savedData.firstIndex(where: { $0.name == data.name }) {
                                        savedData.remove(at: index)
                                    }
                                })
                                /*alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                                 // Handle cancel action here (do nothing)
                                 alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                                 // Handle delete action here
                                 if let index = savedData.firstIndex(where: { $0.name == data.name }) {
                                 savedData.remove(at: index)
                                 }
                                 })*/
                                
                                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                            } label: {
                                Label("Delete", systemImage: "trash").tint(.red)
                            }
                            /*UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
                             } label: {
                             Label("Delete", systemImage: "trash")
                             }*/
                        }
                    }
                }
               
                
                .toolbar{
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            isContentViewActive = true
                        }){
                            /*NavigationLink(
                             destination: CalendarView(),
                             label: {
                             Image(systemName: "calendar")
                             .font(Font.system(size: 24))
                             .foregroundColor(.green)
                             .padding(.top, 0)
                             }
                             )*/
                            Image(systemName: "plus")
                                .labelStyle(IconOnlyLabelStyle())
                                .foregroundColor(.green)
                                .padding(.vertical, 30)
                        }.sheet(isPresented: $isContentViewActive, content: {
                            ContentView(savedData: $savedData, shouldUpdateMainScreen: $shouldUpdateMainScreen)
                        })
                        
                    }
                }.onAppear {
                    if shouldUpdateMainScreen {
                        shouldUpdateMainScreen = false
                        
                    }
                }.navigationBarHidden(false)
                    .navigationBarTitle("Today")
                
                    .padding(.bottom, 24)
            }
        }
        
    }
    
    struct DateView: View {
        var date: Date
        
        var body: some View {
            Text(formattedDate(from: date))
                .font(Font.custom("SF Pro", size: 15))
                .foregroundColor(Color(.label).opacity(0.6))
                .frame(maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .leading)
        }
        
        func formattedDate(from date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMMM d, yyyy - HH:mm"
            return formatter.string(from: date)
        }
    }
    
    struct MainScreenView_Previews: PreviewProvider {
        static var previews: some View {
            MainScreenView()
        }
    }
}

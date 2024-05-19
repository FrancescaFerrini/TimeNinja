import SwiftUI



struct MainPage: View {
    @State private var searchText = ""
    @State private var isContentViewActive = false
    
    var currentDay: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Format to get the full day name (e.g., Monday)
        return formatter.string(from: Date())
    }
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy" // Format to get the full date (e.g., January 1, 2023)
        return formatter.string(from: Date())
    }
    
    var tasks: [Task] = [
        Task(name: "Exercising", date: Date(), timer: "2h", notes: "Example notes 1", category: "gamecontroller"),
        Task(name: "Reading", date: Date(), timer: "1h", notes: "Example notes 2", category: "book")
        // Add more tasks as needed
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(alignment: .center, spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(Font.system(size: 24))
                        .foregroundColor(Color(.label))
                    
                    TextField("Search", text: $searchText)
                        .font(Font.custom("SF Pro", size: 20))
                        .foregroundColor(Color(.label))
                        .padding(.horizontal, 12)
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                    
                    Button(action: {
                        // Handle dictation icon button action
                    }) {
                        Image(systemName: "mic.fill")
                            .font(Font.system(size: 24))
                            .foregroundColor(Color(.label))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Handle calendar icon button action
                    }) {
                        Image(systemName: "calendar")
                            .font(Font.system(size: 24))
                            .foregroundColor(Color(.label))
                    }
                }
                .padding([.leading, .trailing], 16)
                
                Text(currentDay)
                    .font(Font.custom("SF Pro", size: 36))
                    .foregroundColor(Color(.label))
                
                Text(currentDate)
                    .font(Font.custom("SF Pro", size: 24))
                    .foregroundColor(Color(.label))
                
                ScrollView {
                    ForEach(tasks) { task in
                        TaskCellView(task: task)
                            .onTapGesture {
                                // Handle cell tap action, for example:
                                print("Cell tapped for task: \(task.name)")
                                // Perform additional actions here
                            }
                    }
                    NavigationLink(destination: ContentView(), isActive: $isContentViewActive) {
                        EmptyView()
                    }
                    .navigationBarHidden(true)
                    
                }
                .padding()
                
                Button(action: {
                    // Handle button action
                    
                    isContentViewActive = true //
                    
                })
                {
                    Image(systemName: "plus")
                        .font(Font.system(size: 36))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .cornerRadius(500)
                }
                .padding(.bottom, 24)
            }
            
        }
    }
    
    struct TaskCellView: View {
        var task: Task
        
        var body: some View {
            HStack(alignment: .center, spacing: 16) {
                Image(systemName: task.category)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.label))
                    .background(Color(.systemGray5))
                    .padding(.leading, 16)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.name)
                        .font(Font.custom("SF Pro", size: 17))
                        .foregroundColor(.black)
                    
                    DateView(date: task.date)
                }
                
                Spacer()
                
                Text(task.timer)
                    .font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color(.label))
                    .padding(.trailing, 16)
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 5)
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

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}

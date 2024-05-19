//
//  CalendarView.swift
//  TimeNinja
//
//  Created by Eduardo Gonzalez Melgoza on 24/10/23.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack() {
            
            DatePicker(
                "Select a date",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .padding()
            
            Button("Today") {
                selectedDate = Date()
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView()
}

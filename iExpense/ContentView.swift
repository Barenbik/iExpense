//
//  ContentView.swift
//  iExpense
//
//  Created by Tony Sharples on 22/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(itemForegroundStyle(for: item))
                                    Text(item.type)
                                        .foregroundStyle(itemForegroundStyle(for: item))
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                                    .foregroundStyle(itemForegroundStyle(for: item))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(itemForegroundStyle(for: item))
                                    Text(item.type)
                                        .foregroundStyle(itemForegroundStyle(for: item))
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "GBP"))
                                    .foregroundStyle(itemForegroundStyle(for: item))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func itemForegroundStyle(for item: ExpenseItem) -> Color {
        if item.amount < 10 {
            return Color.red
        }
        
        if item.amount < 100 {
            return Color.orange
        }
        
        return Color.green
    }
}

#Preview {
    ContentView()
}

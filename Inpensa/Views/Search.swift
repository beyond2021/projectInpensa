//
//  Search.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/19/23.
//

import SwiftUI
import Combine


struct Search: View {
    // View Properties
    @State private var searchText: String = ""
    @State private var filteredText: String = ""
    @State private var selectedCategory: Category? = nil
    // Combine
    let searchPublisher = PassthroughSubject<String, Never>()
    var body: some View {
        NavigationStack {
      ScrollView {
                LazyVStack( spacing: 12) {
                    FilterTransactionsView(category: selectedCategory, searchText: filteredText) { transactions in
                        ForEach(transactions) { transaction in
                            NavigationLink {
                                TransactionsView(editTransaction: transaction)
                            } label: {
                                TransactionCardView(transaction: transaction, showCategory: true)
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                }
                .padding(15)
                
            }
            .overlay(content: {
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filteredText.isEmpty ? 1 : 0)
            })
            .onChange(of: searchText, { oldValue, newValue in
                // print(newValue)
                // Immediately know when search text is empty
                if newValue.isEmpty {
                    filteredText = ""
                }
                searchPublisher.send(newValue)
            })
            // Combine
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filteredText = text
                print(text)
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.25))
            // Category
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToolBarContent()
                }
            }
        }
    }
    //MARK: Toolbar Content
    @ViewBuilder
    func ToolBarContent() -> some View {
        Menu {
            Button {
                selectedCategory = nil // button sets the category
            } label: {
                HStack {
                    Text("Both") // Button Name set by Button
                }
                if selectedCategory == nil {
                    Image(systemName: "checkmark") // checkmark when category is swt
                }
            }

            
            
            
            
            ForEach(Category.allCases, id: \.rawValue) { category in
                Button {
                    selectedCategory = category // button sets the category
                } label: {
                    HStack {
                        Text(category.rawValue) // Button Name set by Button
                    }
                    if selectedCategory == category {
                        Image(systemName: "checkmark") // checkmark when category is swt
                    }
                }

                
            }
        } label: {
            Image(systemName: "slider.vertical.3")
        }

    }
}

#Preview {
    Search()
}

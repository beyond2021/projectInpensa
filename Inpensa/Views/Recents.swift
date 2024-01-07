//
//  Recents.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/19/23.
// READING DATA

import SwiftUI
import SwiftData

struct Recents: View {
    // User Properties Will Be used in Settings stored in the phone
    @AppStorage("userName")private var userName: String = ""
    // View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endtOfMonth
    // Category Selection
    @State private var selectedCategory: Category = .expense
    // Filter View
    @State private var showFilterView: Bool = false
    // For Animation
    @Namespace private var animation
    
    
    //MARK: Main View
    var body: some View {
        GeometryReader {
            // For animation Purpose 
            let size = $0.size
            NavigationStack {
                ScrollView(.vertical) {
                    LazyVStack( spacing: 10, pinnedViews: .sectionHeaders, content: {
                        Section {
                            // Date filled Button
                            Button(action: {showFilterView = true}, label: {
                                //From the date formatter
                                Text("\(format(date:startDate, format:"MM dd YY")) to \(format(date:endDate, format:"MM dd yy"))")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(appTint
                                    )
                                   
                            })
                            .hSpacing(.leading)
                            
                            
                            
                            FilterTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                // Card View
                                CardView(income: total(transactions, category: .income), expense: total(transactions, category: .expense))
                                // Custom Segmented control
                                CustomSegmentedControl()
                                    .padding(.bottom, 10)
                                //  Display Data
                                ForEach(transactions.filter({ $0.category == selectedCategory.rawValue})) { transaction in
                                    // Nav link to open tapped Transaction = Updating Data
                                    NavigationLink(value: transaction) {
                                        TransactionCardView(transaction: transaction)
                                    }
                                    .buttonStyle(.plain)

                                }
                        
                            }
                           
                        
      
                        } header: {
                            HeaderView(size)
                        }
                        
                    })
                    .padding(15) // Header view BG is clipped
                }
                .background(.gray.opacity(0.25))
                // Blurred BG
                .blur(radius: showFilterView ? 8 : 0)
                // Disable
                .disabled(showFilterView)
                // Qork around
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionsView(editTransaction: transaction)
                }
            }
            .overlay {
                if showFilterView {
                    DateFilterView(start: startDate, end: endDate) { start, end in
                        startDate = start
                        endDate = end
                        showFilterView = false
                    } onClose: {
                        showFilterView = false
                    }
                    .transition(.move(edge: Edge.leading))
                }

                }
                .animation(.snappy, value: showFilterView)
      
        }
    }
    // MARK: Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack( spacing: 10, content: {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Inpensa")
                    .font(.title.bold())
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout.bold())
                        .foregroundStyle(.gray)
                }
            })
            // Animation to scale the HeaderView when the scrollView
            // is dragged.(Default NavigationStack animation)
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(HeaderScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            Spacer(minLength: 0)
            NavigationLink {
                TransactionsView()
                
            } label: {
                // Red Plus Nav Link
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
        })
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack( spacing: 0, content: {
                Rectangle()
                    .fill(.ultraThinMaterial) // Color of header
                Divider()
            })
            // Making Header visible only when scrolling
            .visualEffect { content, geometryProxy in
                content
                   .opacity(headerBGOpacity(geometryProxy))
            }
           
                .padding(.horizontal, -15)
                .padding(.top, -(safeArea.top + 15)) //Safe Area
        }
        
    }
    // Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.horizontal, 10)
                    .background {
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                        
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
                
                
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
        
    }
    // Date Filter View
    // MARK: Header Opacity
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        
        print(minY)
        return minY > 0 ? 0 : (-minY / 15)
    }
    // MARK: Header scale
    func HeaderScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).midY
        let screenHeight = size.height
        let progress = minY / screenHeight
        let scale = min(max(progress, 0), 1) * 0.6
        return 1 + scale
        
    }
}

#Preview {
    ContentView()
}

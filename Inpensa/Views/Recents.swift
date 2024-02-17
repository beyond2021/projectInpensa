//
//  Recents.swift
//  Inpensa
//
//  Created by KEEVIN MITCHELL on 12/19/23.
// READING DATA

import SwiftUI
import SwiftData

struct Recents: View {
    /// User Properties
    @AppStorage("userName") private var userName: String = ""
    /// View Properties
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endtOfMonth
    @State private var showFilterView: Bool = false
    @State private var selectedCategory: Category = .expense
    /// For Animation
    @Namespace private var animation
    
    /// View Properties
    @State private var offsetY: CGFloat = 0
    // Input Data
    @State private var showingInputDataOptions = false
    
    @AppStorage("dataInputSelectionType") private var selection: String = DataInputType.manual.rawValue
  
    var body: some View {
        GeometryReader {
            /// For Animation Purpose
            let size = $0.size
            
            NavigationStack {
               
                   
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                            Section {
                                /// Date Filter Button
                                Button(action: {
                                    showFilterView = true
                                }, label: {
                                    Text("\(format(date: startDate,format: "dd - MMM yy")) to \(format(date: endDate,format: "dd - MMM yy"))")
                                        .font(.caption2)
                                        .foregroundStyle(appTint)
                                })
                                .hSpacing(.leading)
                                
                                FilterTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                    /// Card View
                                    CardView(
                                        income: total(transactions, category: .income),
                                        expense: total(transactions, category: .expense)
                                    )
                                    
                                    /// Custom Segmented Control
                                    CustomSegmentedControl()
                                        .padding(.bottom, 10)
                                    
                                    ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                        NavigationLink(value: transaction) {
                                            TransactionCardView(transaction: transaction)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                            } header: {
                                HeaderView(size)
                                //BlueHeaderView(size)
                            }
                        }
                        .padding(15)
                    }
                    .background(.gray.opacity(0.25))
                    .blur(radius: showFilterView ? 8 : 0)
                    .disabled(showFilterView)
                    .navigationDestination(for: Transaction.self) { transaction in
                        TransactionsView(editTransaction: transaction)
                    }
                }
                .overlay {
                    if showFilterView {
                        DateFilterView(start: startDate, end: endDate, onSubmit: { start, end in
                            startDate = start
                            endDate = end
                            showFilterView = false
                        }, onClose: {
                            showFilterView = false
                        })
                        .transition(.move(edge: .leading))
                    }
               
                
            }
            .animation(.snappy, value: showFilterView)
            .sheet(isPresented: $showingInputDataOptions) {
                       Text("INPENSA")
                   
                            .presentationDetents([.medium, .large])
                    }
            .overlay(alignment: .bottomTrailing, content: {
               // ReelDetailsView()
                AIButtons()
                    .padding(.leading, 15)
                    .padding(.trailing, 20)
                    .padding(.bottom, safeArea.bottom + 15)
            })

        }
    }
    
    /// Header View
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5, content: {
//                Text("Inpensa!")
//                    .font(.title.bold())
               Image("INPENSADARKBLUE")
//                    .resizable()
                    
                
//                    .background(appTint.gradient, in: .rect(cornerRadius: 5))
//                    .contentShape(.rect)
                
                if !userName.isEmpty {
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(appTint)
                }
            })
            .visualEffect { content, geometryProxy in
                content
                    .scaleEffect(headerScale(size, proxy: geometryProxy), anchor: .topLeading)
            }
            
            Spacer(minLength: 0)
            
           
            
            
            HStack(spacing: 10) {
                NavigationLink {
                    TransactionsView()
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 45, height: 45)
                        .background(appTint.gradient, in: .circle)
                        .contentShape(.circle)
                }
                // AI Buttons
                
            }
            
     
        }
        .padding(.bottom, userName.isEmpty ? 10 : 5)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    
                
                Divider()
            }
            .visualEffect { content, geometryProxy in
                content
                    .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }

    /// Segmented Control
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .foregroundStyle(appTint)
                    .hSpacing()
                    .padding(.vertical, 10)
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
    
    func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        return minY > 0 ? 0 : (-minY / 15)
    }
    
    func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        let screenHeight = size.height
        
        let progress = minY / screenHeight
        let scale = (min(max(progress, 0), 1)) * 0.4
        
        return 1 + scale
    }
   
    /// Sample Cards
    @ViewBuilder
    func SampleCardsView() -> some View {
        VStack(spacing: 15) {
            ForEach(1...25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.black.opacity(0.05))
                    .frame(height: 75)
            }
        }
        .padding(15)
    }
    
   @ViewBuilder
    func AIButtons() -> some View {
        VStack( spacing: 20) {
            Button {
                
            } label: {
                Image(systemName: "mic")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
            
            Button {
                
            } label: {
                Image(systemName: "doc.viewfinder.fill")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }

        }
    
    }
  
  
  
}

#Preview {
    ContentView()
}

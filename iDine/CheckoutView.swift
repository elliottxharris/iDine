//
//  ChecoutView.swift
//  iDine
//
//  Created by Elliott Harris on 4/17/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    let paymentTypes = ["Cash", "Credit Card", "iDine Points"]
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    let tipAmounts = [10, 15, 20, 25, 0]
    @State private var tipAmount = 15
    @State private var showingAlert = false
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let total = Double(order.total)
        let tip = total / 100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total + tip)) ?? "$0"
    }
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(paymentTypes, id: \.self) {
                        Text($0)
                    }
                }
                
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) { tip in
                        Text("\(tip)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header:
                Text("Total \(totalPrice)")
                        .font(.title)
            ) {
                Button("Confirm Order") {
                    showingAlert.toggle()
                }
            }
        }
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Order Confirmed"), message: Text("Your total is \(totalPrice)"), dismissButton: .default(Text("OK")))
        })
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}

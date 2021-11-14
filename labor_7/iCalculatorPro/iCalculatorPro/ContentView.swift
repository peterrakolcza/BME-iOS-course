//
//  ContentView.swift
//  iCalculatorPro
//
//  Created by Rakolcza Peter on 2021. 11. 11..
//

import SwiftUI

struct ContentView: View {
    @State private var operand1: String = ""
    @State private var operand2: String = ""
    @State private var result: String = "Result"
    @State private var selectedOperation = OperationType.add
    
    enum OperationType: String, CaseIterable, Identifiable {
        case add = "+"
        case subtract = "-"
        case multiply = "*"
        case divide = "/"
        
        var id: String { self.rawValue }
    }
    
    var body: some View {
        
        VStack {
            Text("iCalculator Pro")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            TextField("1. operandus", text: $operand1)
                .padding(.horizontal)
            
//            Text("+")
            Picker("Operation", selection:$selectedOperation) {
                ForEach(OperationType.allCases){ operation in
                        Text(operation.rawValue).tag(operation)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            TextField("2. operandus", text: $operand2)
                .padding(.horizontal)
            
            Button{
                if let o1 = Float(operand1), let o2 = Float(operand2) {
                    switch(selectedOperation){
                    case .add:
                        self.result = String(o1 + o2)
                    case .subtract:
                        self.result = String(o1 - o2)
                    case .multiply:
                        self.result = String(o1 * o2)
                    case .divide:
                        self.result = String(o1 / o2)
                    }
                }
            } label: {
                Text("=")
                    .frame(width: 100, height: 30, alignment: .center)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.white, lineWidth: 2)
//                    )
//                    .foregroundColor(.white)
//                    .background(RoundedRectangle(cornerRadius: 20).fill(Color.blue))
                    
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .tint(.purple)
            
            Text("\(result)")
            
            Spacer()
        }
        .textFieldStyle(.roundedBorder)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

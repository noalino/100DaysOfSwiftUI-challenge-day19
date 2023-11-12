//
//  ContentView.swift
//  LengthConverter
//
//  Created by Noalino on 12/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = "meters"
    @State private var outputUnit = "kms"
    @State private var value = 0.0
    @FocusState private var isInputFocused: Bool
    
    var valueToMeters: Double {
        switch inputUnit {
        case "kms":
            return value * 1000
        case "feet":
            return value / 3.28084
        case "yards":
            return value / 1.09361
        case "miles":
            return value / 0.000621371
        default:
            return value
        }
    }
    
    var convertedValue: Double {
        switch outputUnit {
        case "kms":
            return valueToMeters / 1000
        case "feet":
            return valueToMeters * 3.28084
        case "yards":
            return valueToMeters * 1.09361
        case "miles":
            return valueToMeters * 0.000621371
        default:
            return valueToMeters
        }
    }
    
    let units = ["meters", "kms", "feet", "yards", "miles"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit") {
                    Picker("Select an input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output unit") {
                    Picker("Select an output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Input") {
                    TextField("Enter a value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }
                
                Section("Output") {
                    Text(convertedValue.formatted())
                }
            }
            .navigationTitle("LengthConverter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isInputFocused {
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  Convert
//
//  Created by Никита Мартьянов on 19.07.23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var ourput = 0.0
    @State private var dio = "Форенгейты"
    @State private var dao = "Форенгейты"
    @FocusState private var AmountIsFocused : Bool
    let tempi = ["Форенгейты","Цельсия","Кельвина"]
    func convertTemperature(input: Double, dio: String, dao: String) -> Double {
        var ourput = input
        
        switch dio {
        case "Цельсия":
            switch dao {
            case "Форенгейты":
                ourput = (input * 1.8) + 32
            case "Кельвина":
                ourput = input + 273.15
            default:
                break
            }
        case "Форенгейты":
            switch dao {
            case "Цельсия":
                ourput = (input - 32) / 1.8
            case "Кельвина":
                ourput = (input + 459.67) * 5/9
            default:
                break
            }
        case "Кельвина":
            switch dao {
            case "Цельсия":
                ourput = input - 273.15
            case "Форенгейты":
                ourput = (input * 1.8) - 459.67
            default:
                break
            }
        default:
            break
        }
        
        return ourput
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount",value:$input,format:.number)
                        .keyboardType(.decimalPad)
                        .focused($AmountIsFocused)
                }
                Section {
                    Picker("",selection: $dio) {
                        ForEach(tempi, id: \.self) {
                            Text($0)
                        }
                        }
                    .pickerStyle(.segmented)
                    }
                header : {
                    Text("Выберите вид начальных градусов")
                }
                Section {
                    Picker("",selection: $dao) {
                        ForEach(tempi, id: \.self) {
                            Text($0)
                        }
                        }
                    .pickerStyle(.segmented)
                    }
                header : {
                    Text("Выберите вид полученных градусов")
                }
                Section {
                    Text("\(convertTemperature(input: input, dio: dio, dao: dao), specifier: "%.2f")")

                }
                }
              
            }
            .navigationTitle("Convert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Готово"){
                        AmountIsFocused = false
                    }
                }
            }

        }

    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

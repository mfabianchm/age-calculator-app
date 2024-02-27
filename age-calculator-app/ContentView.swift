//
//  ContentView.swift
//  age-calculator-app
//
//  Created by Marcos Fabian Chong Megchun on 26/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var years: String = ""
    @State var months: String = ""
    @State var days: String = ""
    @State var yearsToShow: Int = 0
    @State var monthsToShow: Int = 0
    @State var daysToShow: Int = 0
    @State var error_msg_days: String = ""
    @State var error_msg_months: String = ""
    @State var error_msg_years: String = ""
    @State var allFieldsOk: Bool = false
    @State var dayHasError:Bool = false
    @State var monthHasError:Bool = false
    @State var yearHasError:Bool = false
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    let currentDay = Calendar.current.component(.day, from: Date())
    
    func checkDayAndMonth (day: Int, month: Int) -> Bool {
        if(month == 2 && day > 28) {
            return false
        } else if (month == 4 || month == 6 || month == 9 || month == 11) {
            if (day > 30) {
                return false
            }
        }
        return true
    }
    
    func checkDate(day: String, month: String, year: String) {
        if(day == "") {
            dayHasError = true
            error_msg_days = "This field is required"
        } else {
            let numberDay = Int(day) ?? 0
            if(numberDay < 1 || numberDay > 31) {
                dayHasError = true
                error_msg_days = "Must be a valid date"
            } else {
                dayHasError = false
            }
        }
        
        if(month == "") {
            monthHasError = true
            error_msg_months = "This field is required"
        } else {
            let numberMonth = Int(month) ?? 0
            if(numberMonth < 1 || numberMonth > 12) {
                monthHasError = true
                error_msg_months = "Must be a valid month"
            } else {
                monthHasError = false
            }
        }
        
        if(year == "") {
            yearHasError = true
            error_msg_years = "This field is required"
        } else {
            let numberYear = Int(year) ?? 0
            if(numberYear > currentYear) {
                yearHasError = true
                error_msg_years = "Must be in the past"
            } else {
                yearHasError = false
            }
        }
        
        if(!dayHasError && !monthHasError && !yearHasError) {
            let numberDay = Int(day) ?? 0
            let numberMonth = Int(month) ?? 0
            let numberYear = Int(year) ?? 0
            let dayIsValid = checkDayAndMonth(day: numberDay, month: numberMonth)
            if (!dayIsValid) {
                dayHasError = true
                monthHasError = true
                yearHasError = true
                error_msg_days = "Must be a valid date"
                error_msg_months = "Must be a valid date"
                error_msg_years = "Must be a valid date"
            } else {
                calculateAge(currentYear: currentYear, currentMonth: currentMonth, currentDay: currentDay, birthDay: numberDay, birthMonth: numberMonth, birthYear: numberYear)
            }
        }
    }
    
    func doCalculation() {
        self.checkDate(day: days, month: months, year: years)
    }
    
    func calculateAge(currentYear: Int, currentMonth: Int, currentDay: Int, birthDay: Int, birthMonth: Int, birthYear: Int) {
        var years = currentYear - birthYear
        if (birthMonth > currentMonth) {
            years -= 1
        } else if (birthMonth == currentMonth && birthDay > currentDay) {
            years -= 1
        }
        let months = abs(currentMonth - birthMonth)
        let days = abs(currentDay - birthDay)
        print(days)
        daysToShow = days
        monthsToShow = months
        yearsToShow = years
        allFieldsOk = true
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 1) {
                    Text("DAY")
                        .tracking(2)
                        .foregroundColor(dayHasError ? Color("Light-red") : Color("Smokey-grey"))
                        .font(.custom("Poppins-ExtraBold", size: 18))
                    TextField("DD", text: $days)
                        .font(.custom("Poppins-ExtraBold", size: 27))
                        .foregroundColor(Color("Smokey-grey"))
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(dayHasError ? Color("Light-red") : Color("Light-grey"), style: StrokeStyle(lineWidth: 1.0)))
                        .onChange(of: days) { newValue in
                            doCalculation()
                        }
                    if(dayHasError) {
                        Text(error_msg_days)
                            .foregroundColor(Color("Light-red"))
                            .font(.custom("Poppins-Italic", size: 16))
                    }
                }
                VStack(alignment: .leading, spacing: 1) {
                    Text("MONTH")
                        .tracking(2)
                        .foregroundColor(monthHasError ? Color("Light-red") : Color("Smokey-grey"))
                        .font(.custom("Poppins-ExtraBold", size: 18))
                    TextField("MM", text: $months)
                        .font(.custom("Poppins-ExtraBold", size: 27))
                        .foregroundColor(Color("Smokey-grey"))
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(monthHasError ? Color("Light-red") : Color("Light-grey"), style: StrokeStyle(lineWidth: 1.0)))
                        .onChange(of: months) { newValue in
                            doCalculation()
                        }
                    if(monthHasError) {
                        Text(error_msg_months)
                            .foregroundColor(Color("Light-red"))
                            .font(.custom("Poppins-Italic", size: 16))
                    }
                }
                VStack(alignment: .leading, spacing: 1) {
                    Text("YEAR")
                        .tracking(2)
                        .foregroundColor(yearHasError ? Color("Light-red") : Color("Smokey-grey"))
                        .font(.custom("Poppins-ExtraBold", size: 18))
                    TextField("YYYY", text: $years)
                        .font(.custom("Poppins-ExtraBold", size: 27))
                        .foregroundColor(Color("Smokey-grey"))
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(yearHasError ? Color("Light-red") : Color("Light-grey"), style: StrokeStyle(lineWidth: 1.0)))
                        .onChange(of: years) { newValue in
                            doCalculation()
                        }
                    if(yearHasError) {
                        Text(error_msg_years)
                            .foregroundColor(Color("Light-red"))
                            .font(.custom("Poppins-Italic", size: 16))
                    }
                }
            }
            Button(action: {
                allFieldsOk = false
                dayHasError = false
                monthHasError = false
                yearHasError = false
                days = ""
                months = ""
                years = ""
            }, label: {
                Image("icon-arrow")
                      .resizable()
                      .frame(width: 20, height: 20)
                      .padding(20)
                      .background(Color("Purple"))
                      .clipShape(Circle())
                      .offset(y: 40)
                      .zIndex(30)
            })
            
            Divider()
            VStack {
                Text(allFieldsOk ? "\(yearsToShow)" : "--")
                + Text(" years")
                    .foregroundColor(Color("Off-Black"))
                Text(allFieldsOk ? "\(monthsToShow)" : "--")
                + Text(" months")
                    .foregroundColor(Color("Off-Black"))
                Text(allFieldsOk ? "\(daysToShow)" : "--")
                + Text(" days")
                    .foregroundColor(Color("Off-Black"))
            } .padding(.top, 50)
                .foregroundColor(Color("Purple"))
        }
        .padding()
        .font(.custom("Poppins-ExtraBold", size: 60))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

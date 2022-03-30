//
//  ContentView.swift
//  ProgressCircleBar
//
//  Created by Jesus Mora on 30/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var circleValue: Float = 0.1
    @State private var showingIncrementAlert = false
    @State private var showingDecrementAlert = false
    
    //Computed property to return the Color.
    var colorProgressValue: Color {
        
        var colorLit: Color = Color.green
        
        switch circleValue {
        case 0..<0.3:
            colorLit = Color.red
        case 0.3..<0.5:
            colorLit = Color.yellow
        case 0.5..<0.7:
            colorLit = Color.mint
        case 0.7..<1:
            colorLit = Color.green
        default:
            colorLit = Color.green
        }

        return colorLit
    }

    
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .top, endPoint: .leading).ignoresSafeArea()
            ZStack {
                        Circle()
                            .stroke(lineWidth: 7.0)
                            .opacity(0.3)
                            .foregroundColor(Color.black).opacity(0.1)
                            
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(circleValue, 1.0)))
                            .stroke(style: StrokeStyle(lineWidth: 7.0, lineCap: .round, lineJoin: .round))
                            .background(Circle().foregroundColor(Color.black).opacity(0.6))
                            .foregroundColor(colorProgressValue)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.default, value: circleValue)
                        Text(String(format: "%.0f%%", min(circleValue, 1.0)*100.0))
                            .font(.system(size:72))
                            .bold()
                            .foregroundColor(Color.white)
                
                    }
                .frame(width: 210.0, height: 210.0)
                .padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
           
            VStack{
                HStack{
                    
                    // Increment Button
                    Button {
                        
                        if circleValue >= 1 {
                            showingIncrementAlert = true
                        } else {
                            circleValue = circleValue + 0.1
                        }
                        
                    } label: {
                       
                            Text("Increment")
                                .bold()
                                .padding()
                                .background(Color(red: 0.3, green: 0.7, blue: 0.5))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .padding(.init(top: 340, leading: 20, bottom: 20, trailing: 20))
                    } .alert("You can't increment more :(", isPresented: $showingIncrementAlert) {
                        Button(role: .cancel) {} label: {
                            Text("OK")
                        }

                    }
                    // Decrement Button
                    Button {
                        
                        if circleValue < 0.1 {
                            showingDecrementAlert = true
                        } else {
                            circleValue = circleValue - 0.1
                        }
                        
                    } label: {
                       
                            Text("Decrement")
                                .bold()
                                .padding()
                                .background(Color(red: 1, green: 0, blue: 0.5))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                                .padding(.init(top: 340, leading: 20, bottom: 20, trailing: 20))
                    } .alert("Yo can't decrement more :(", isPresented: $showingDecrementAlert) {
                        Button(role: .cancel) {} label: {
                            Text("OK")
                        }

                    }
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

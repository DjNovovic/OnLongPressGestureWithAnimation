//
//  ContentView.swift
//  OnLongPressGestureWithAnimation
//
//  Created by Đorđije Novović on 24.8.21..
//

import SwiftUI

struct ContentView: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack {
            Text("onLongPressGesture")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 100)
            Text("withAnimation")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 100)
            ZStack {
                Rectangle()
                    .fill(isSuccess ? Color.green : Color.blue)
                    .frame(maxWidth: isComplete ? .infinity : 0)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)
                    .cornerRadius(16)
                Text(isSuccess ? "Loading completed!" : "")
            }
            
            HStack {
                Text("LOAD")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(16)
                    .onLongPressGesture(minimumDuration: 3.0, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 3.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                
                Text("RESTART")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.secondary)
                    .cornerRadius(16)
                    .onTapGesture {
                        isComplete = false
                        isSuccess = false
                    }
                
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  PlayCes
//
//  Created by Shantanu Tapole on 19/08/25.
//


import SwiftUI

class TimerHolder {
    static let shared = TimerHolder()
    var timer: Timer? = nil
    private init() {}
}

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    let titles = ["Play", "Goal","Swim","Run", "Shoot", "Dunk", "Score", "Win", "Hit"]
    let colours: [Color] = [.orange, .green, .blue, .red]
    @State private var currentIndex: Int = 0
    @State private var currentIndexColour: Int = 0
    
    // New state to toggle between login and signup UI
    @State private var showSignUp = false
    // State for programmatic navigation to EmailSignupOrLogin
    @State private var showEmailPassword = false
    // State for programmatic navigation to PhoneNumber
    @State private var showPhoneNumber = false
    // State for programmatic navigation to PhoneNumberOTP
    @State private var showPhoneNumberOTP = false

    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    
var body: some View {
        VStack(spacing: 20) {
            
            VStack {
                Text("It's your turn to")
                    .font(.system(size: 45, weight: .heavy))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(titles[currentIndex])
                    .font(.system(size: 55, weight: .thin))
                    .fontWeight(.bold)
                    .foregroundColor(colours[currentIndexColour])
                    .shadow(color: colours[currentIndexColour].opacity(0.6), radius: 10, x: 5, y: 5)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear {
                        // Run only once
                        guard TimerHolder.shared.timer == nil else { return }

                        TimerHolder.shared.timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                            withAnimation(.easeInOut(duration: 0.5)) {
                                currentIndex = (currentIndex + 1) % titles.count
                                currentIndexColour = (currentIndexColour + 1) % colours.count
                            }
                        }
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: showSignUp ? .top : .center)

//MARK: - Show Sign Up Popup
            if showSignUp {
                if (!showEmailPassword && !showPhoneNumber){
                    VStack(spacing: 10) {
                        Text("Login or Sign Up with").foregroundColor(.gray).padding()
                        HStack(spacing: 10){
                            Button("\(Image(systemName: "envelope.fill")) Email") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showEmailPassword = true
                                }
                            }
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: UIScreen.main.bounds.width * 0.2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .shadow(color: .blue.opacity(0.6), radius: 10, x: 0, y:0)
                            
                            Button("\(Image(systemName: "phone.fill")) Phone") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    showPhoneNumber = true
                                }
                            }
                            .font(.system(size: 18, weight: .medium))
                            .frame(width: UIScreen.main.bounds.width * 0.2)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .shadow(color: .green.opacity(0.6), radius: 10, x: 0, y:0)
                        }
                        HStack(spacing: 10){
                            Button("\(Image(systemName: "person.fill")) Google") {}
                                .font(.system(size: 17, weight: .medium))
                                .frame(width: UIScreen.main.bounds.width * 0.2)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(50)
                                .shadow(color: .red.opacity(0.6), radius: 10, x: 0, y:0)
                            
                            Button("\(Image(systemName: "apple.logo")) Apple") {}
                                .font(.system(size: 18, weight: .medium))
                                .frame(width: UIScreen.main.bounds.width * 0.2)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(50)
                                .shadow(color: .white.opacity(0.6), radius: 10, x: 0, y:0)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                //MARK: - Email and Password Behaviour
                if showEmailPassword {
                    VStack(spacing: 20) {
                        Text("Login or Sign Up with Email").foregroundColor(.gray)
                        TextField("", text: $email, prompt: Text("Email").foregroundColor(.white.opacity(0.5)))
                            .padding()
                            .background(Color.black)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                            )
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        
                        SecureField("", text: $password, prompt: Text("Password").foregroundColor(.white.opacity(0.5)))
                            .padding()
                            .background(Color.black)
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                            )
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        
                        
                        Button("Next") {
                            // Handle email/password login/signup
                        }
                        .font(.system(size: 18, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(12)
                        .shadow(color: Color.orange.opacity(0.4), radius: 8, x: 0, y: 0)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .padding()
                    .frame(maxWidth: .infinity)
                    
                    Button("Back") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showSignUp = true
                            showEmailPassword = false
                        }
                    }.foregroundColor(.blue)
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.1)
                        .background(Color.blue.opacity(0.3))
                        .cornerRadius(50)
                }
                
                //MARK: - Phonenumber Behaviour
                if showPhoneNumber {
                    VStack(spacing: 20) {
                        Text("Enter your phone number").foregroundColor(.gray)
                        TextField("", text: $email, prompt: Text("Phone number").foregroundColor(.white.opacity(0.5)))
                            .padding()
                            .background(Color.black)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.green.opacity(0.7), lineWidth: 2)
                            )
                            .foregroundColor(.white)
                            .keyboardType(.phonePad)
                            .padding(.horizontal)
                        if showPhoneNumberOTP {
                            Text("Enter the 6-digit OTP").foregroundColor(.gray)
                            VStack(spacing: 30) {
                                HStack(spacing: 12) {
                                    ForEach(0..<6, id: \.self) { index in
                                        TextField("", text: Binding(
                                            get: { otpDigits[index] },
                                            set: { newValue in
                                                let filtered = newValue.filter { $0.isNumber }
                                                if let firstChar = filtered.first {
                                                    otpDigits[index] = String(firstChar)
                                                    if index < 5 {
                                                        DispatchQueue.main.async {
                                                            UIResponder.currentFirstResponder?.moveToNextResponder()
                                                        }
                                                    }
                                                } else {
                                                    otpDigits[index] = ""
                                                }
                                            }
                                        ))
                                        .keyboardType(.numberPad)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 40, height: 55)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.green.opacity(0.7), lineWidth: 2)
                                        )
                                        .foregroundColor(.white)
                                        .shadow(color: Color.green.opacity(0.4), radius: 5, x: 0, y: 0)
                                    }
                                }

                                Button("Verify OTP") {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        // Handle OTP verification logic
                                    }
                                }
                                .font(.system(size: 18, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .shadow(color: Color.green.opacity(0.4), radius: 8, x: 0, y: 0)
                                .padding(.horizontal)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                            }
                        } else {
                            Button("Send OTP") {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    showPhoneNumberOTP = true
                                }
                            }
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                            .shadow(color: Color.orange.opacity(0.4), radius: 8, x: 0, y: 0)
                            .padding(.horizontal)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                    }
                    .padding()
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .frame(maxWidth: .infinity)
                    
                    Button("Back") {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showSignUp = true
                            showPhoneNumber = false
                            showPhoneNumberOTP = false
                            otpDigits = Array(repeating: "", count: 6)
                        }
                    }
                    .foregroundColor(.blue)
                    .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.1)
                    .background(Color.blue.opacity(0.3))
                    .cornerRadius(50)
                    .padding(.top)
                }
            }
            
            //MARK: - Go back to Sign Up button
            else {
                // Login UI
                Button("Login or Sign Up") {
                    withAnimation(.easeInOut(duration: 0.5)) {
                            showSignUp = true
                    }
                }
                .font(.system(size: 18, weight: .medium))
                .frame(width: UIScreen.main.bounds.width * 0.4)
                .padding()
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(50)
                .padding(.horizontal)
                .shadow(color: .white.opacity(0.7), radius: 15, x: 0, y:0)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.black.ignoresSafeArea())
    }
}


#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}

extension UIResponder {
    private static weak var _currentFirstResponder: UIResponder?

    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    @objc private func findFirstResponder() {
        UIResponder._currentFirstResponder = self
    }

    func moveToNextResponder() {
        self.resignFirstResponder()
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
}

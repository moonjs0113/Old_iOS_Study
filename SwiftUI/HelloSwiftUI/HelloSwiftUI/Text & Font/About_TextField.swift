//
//  About_TextField.swift
//  HelloSwiftUI
//
//  Created by Moon Jongseek on 2022/07/02.
//

import SwiftUI

enum FieldType: Hashable {
    case email
    case password
}

struct AboutTextField: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showJoinAlert = false
    @State private var showInputAlert = false
    
    @State private var favoriteNumber: Int = 0
    
    //    @FocusState private var emailFocused: Bool
    //    @FocusState private var passwordFocused: Bool
    @FocusState private var focusedField: FieldType?
    
    var body: some View {
        VStack {
            VStack {
                TextField("Number", value: $favoriteNumber, format: .number, prompt: Text("Input Number"))
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                TextField("Email", text: $email, prompt: Text("Input Email"))
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.username) // 저장된 Email 제안 등을 사용하기 위한 Type
                    .keyboardType(.emailAddress) // 실제 보여지는 Keyboard Type
                
                SecureField("Password", text: $password, prompt: Text("Input Password"))
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)
            }
            
            Form {
                Section {
                    // iOS Title -> Placeholder, prompt -> Placeholder
                    // prompt가 있으면 우선적용
                    // macOS Title -> Label, prompt -> Placeholder
                    TextField("Email",
                              text: self.$email,
                              prompt: Text("Input Email")
                    )
                    .textInputAutocapitalization(.never) // 대문자 자동 변환 끄기
                    .disableAutocorrection(true) // 자동완성 끄기
                    //                            .focused($emailFocused)
                    .focused(self.$focusedField, equals: .email) // Focused Equals 쓰자
                    // Return 자리에 버튼을 바꿀 수 있다.
                    .submitLabel(.next)
                    .onSubmit { // Submit 눌렀을 때 Trigger
                        self.focusedField = .password
                    }
                    
                    SecureField("Password",
                                text: self.$password,
                                prompt: Text("Input Password")
                    )
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    //                        .focused($passwordFocused)
                    .focused(self.$focusedField, equals: .password)
                    .submitLabel(.done)
                    .onSubmit { // Submit 눌렀을 때 Trigger
                        if email.isEmpty {
                            showInputAlert = true
                        } else {
                            showJoinAlert = true
                            self.focusedField = nil
                        }
                    }
                }
                
                Section {
                    Button {
                        if email.isEmpty {
                            showInputAlert = true
                        } else {
                            showJoinAlert = true
                            self.focusedField = nil
                        }
                    } label: {
                        Text("회원가입")
                    }
                    .frame(maxWidth: .infinity)
                    .alert("회원가입", isPresented: $showJoinAlert) {
                        Button {
                            email = ""
                            password = ""
                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("계정: \(email)\n비밀번호: \(password)")
                    }
                    .alert("경고", isPresented: $showInputAlert) {
                        Button {
                            self.focusedField = .email
                        } label: {
                            Text("확인")
                        }
                    } message: {
                        Text("이메일을 입력해 주세요")
                    }
                }
            }
            .onAppear {
                // 아직은 이 방법이 최선이라고 한다.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.focusedField = .email
                }
            }
        }
    }
}

struct About_TextField_Previews: PreviewProvider {
    static var previews: some View {
        AboutTextField()
    }
}

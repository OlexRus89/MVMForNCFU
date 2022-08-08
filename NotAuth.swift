import SwiftUI

struct NotAuth: View {
    @StateObject var AnimationGradinet = ViewPattern()
    @Binding var Profil: String
    var body: some View {
        ZStack {
            StructGradientPattern(animationGradient: AnimationGradinet, Profil: $Profil)
            
            // ПОМЕНЯТЬ!!!!
            if AnimationGradinet.ShowHUDselected_0 {
                News(AnimationGradient: AnimationGradinet)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                    .zIndex(AnimationGradinet.selected == 0 ? 1 : 0)
            }
            if AnimationGradinet.ShowHUDselected_1 {
                Schedule(AnimationGradient: AnimationGradinet)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                    .zIndex(AnimationGradinet.selected == 1 ? 1 : 0)
            }
            
            if AnimationGradinet.ShowHUDselected_3 {
                SignIn(AnimationGradient: AnimationGradinet, Verif: $Profil)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                    .zIndex(AnimationGradinet.selected == 3 ? 1 : 0)
            }
//            Entrance(AnimationGradient: AnimationGradinet)
//                .offset(y: AnimationGradinet.ShowHUDselected_2 ? 0 : 1500)
//                .animation(.spring(), value: AnimationGradinet.selected)
//                .zIndex(AnimationGradinet.selected == 2 ? 1 : 0)
//            
//                .offset(y: AnimationGradinet.ShowHUDselected_3 ? 0 : 1500)
//                .animation(.spring(), value: AnimationGradinet.selected)
//                .zIndex(AnimationGradinet.selected == 3 ? 1 : 0)
            StructButtonPattern(selected: AnimationGradinet, Profil: $Profil)
                .zIndex(2)
//            StructVerifBiometry()
//                .ignoresSafeArea()
//                .zIndex(3)
            ZStack {
                if AnimationGradinet.enableService || AnimationGradinet.enableSchedule {
                    if AnimationGradinet.enableService {
                        StructService(Verif: $Profil)
                    }
                    if AnimationGradinet.enableSchedule {
                        StructService(Verif: $Profil)
                    }
                    AnimationGradinet.ButtonBackPattern()
                } else {
                    AnimationGradinet.ButtonMenuPattern(enableMenuSize: AnimationGradinet.enableMenuSize, enableMenuOpacity: AnimationGradinet.enableMenuOpacity)
                    AnimationGradinet.SearchButtonPattern()
                }
                StructSearch(Models: AnimationGradinet)
                StructMenu(MenuManual: AnimationGradinet, Verif: $Profil)
            }
            .zIndex(3)
        }
    }
}

struct News: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected == 0 ? Color.black : Color.clear, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
            VStack {
                Text("Новости")
                Circle()
                    .frame(width: 200, height: 200)
            }
        }
    }
}

struct Schedule: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected == 1 ? .black : .clear, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
            VStack {
                Text("Расписание")
                Text("\(AnimationGradient.selected)")
            }
        }
    }
}

struct Entrance: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected == 2 ? .black : .clear, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
            VStack {
                Text("Поступление")
                Text("\(AnimationGradient.selected)")
            }
            
        }
    }
}

struct SignIn: View {
    @ObservedObject var AnimationGradient: ViewPattern
    @Binding var Verif: String
    @State var uiImage = UIImage()
    @State var Login = ""
    @State var Password = "df"
    @State var Code = ""
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected == 3 ? .black : .clear, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
            VStack {
                // MARK: Имя пользователя
                // ------------------------------------------------------------
                Text("Имя пользователя")
                if #available(iOS 15, *) {
                    TextField("Введите логин", text: $Login)
                        .disableAutocorrection(true)
                        .textFieldStyle(OvalTextFieldStyle())
                        .frame(width: 250, height: 0, alignment: .center)
                        .padding(30)
                        .submitLabel(.next)
                } else {
                    TextField("Введите логин", text: $Login)
                        .disableAutocorrection(true)
                        .textFieldStyle(OvalTextFieldStyle())
                        .frame(width: 250, height: 0, alignment: .center)
                        .padding(30)
                    
                }
                // ------------------------------------------------------------
                
                Spacer()
                    .frame(height: 15)
                
                // MARK: Пароль
                // ------------------------------------------------------------
                Text("Пароль")
                if #available(iOS 15, *) {
                    SecureField("Введите пароль", text: $Password)
                        .disableAutocorrection(true)
                        .textFieldStyle(OvalTextFieldStyle())
                        .frame(width: 250, height: 0, alignment: .center)
                        .padding(30)
                        .submitLabel(.continue)
                }
                else {
                    SecureField("Введите пароль", text: $Password)
                        .disableAutocorrection(true)
                        .textFieldStyle(OvalTextFieldStyle())
                        .frame(width: 250, height: 0, alignment: .center)
                        .padding(30)
                }
                // ------------------------------------------------------------
                
                Spacer()
                    .frame(height: 15)
                
                // MARK: Подтверждения бота
                // ------------------------------------------------------------
                Text("Подтвердите результат")
                if Login == "" && Password == "" {
                    HStack {
                        Spacer()
                        Image("Captcha")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120)
                            .cornerRadius(30)
                            .shadow(radius: 5)
                        Spacer()
                            .frame(width: 28)
                        if #available(iOS 15, *) {
                            TextField("Ответ", text: $Code)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(OvalTextFieldStyleCaptcha())
                                .frame(width: 100)
                                .keyboardType(.numbersAndPunctuation)
                            
                        }
                        else {
                            TextField("", text: $Code)
                                .disableAutocorrection(true)
                                .textFieldStyle(OvalTextFieldStyleCaptcha())
                                .frame(width: 50, height: 0, alignment: .center)
                                .padding(30)
                                .keyboardType(.numbersAndPunctuation)
                        }
                        Spacer()
                    }
                    .padding(15)
                    .onAppear(perform: Captcha)
                }
                // ------------------------------------------------------------
                
                // MARK: Вход
                // ------------------------------------------------------------
                Button(action: {
                    
                }, label: {
                    Text("Войти")
                })
                .padding(9.5)
                .buttonStyle(SettingButton())
                // ------------------------------------------------------------
            }
        }
    }
    
    func Captcha() {
        let backgroundURL:NSURL? = NSURL(string: "https://ecampus.ncfu.ru/Captcha/Captcha")
        
        DispatchQueue.global(qos: .userInitiated).async {
            let backgroundData:NSData? = NSData(contentsOf: backgroundURL! as URL)
            DispatchQueue.main.async {
                if (backgroundData != nil) {
                    self.uiImage = UIImage(data: backgroundData! as Data)!
                }
            }
        }
    }
}

// Стиль кнопки, логина и пароля
// ---------------------------------------------------------------------
struct SettingButton: ButtonStyle {
    @State var animation = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 10)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .cornerRadius(15)
                .colorMultiply(self.animation ? .blue : .white)
                .shadow(radius: 5)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animation.toggle()
                    }
                })
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}

struct OvalTextFieldStyleCaptcha: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color(.systemBackground))
            .cornerRadius(30)
            .shadow(radius: 5)
    }
}
// ---------------------------------------------------------------------

// ------------------------------------------------------------

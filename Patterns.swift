import SwiftUI
import LocalAuthentication

class ViewPattern: ObservableObject {
    @Published var AnimationGradient = false
    @Published var AnimationGradientButton = false
    
    @Published var AnimationLoading = false
    @Published var selected = 0
    @Published var selectedOpacity = 0
    
    
    @Published var ShowHUDselected_0 = true
    @Published var ShowHUDselected_1 = false
    @Published var ShowHUDselected_2 = false
    @Published var ShowHUDselected_3 = false
    
    @Published var enableCard = false
    @Published var enableCardSize: CGFloat = 1500
    @Published var ChangeCard = false
    
    @Published var enableSearch = false
    @Published var TextSearch = ""
    
    @ViewBuilder
    
    // MARK: Изменение карты (Физическое и сайта)
    // ------------------------------------------------------------
    func ChangeCardButtonPattern() -> some View {
        VStack {
            Spacer()
                .frame(height: 39)
            HStack {
                Spacer()
                Button(action: {
                    self.ChangeCard.toggle()
                }, label: {
                    Image(systemName: "gobackward")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(.systemBackground))
                            .shadow(radius: 10))
                })
                Spacer()
                    .frame(width: 10)
            }
            Spacer()
        }
    }
    // ------------------------------------------------------------
    
    // MARK: Создание макета кнопки "Поиск"
    // ------------------------------------------------------------
    func SearchButtonPattern() -> some View {
        VStack {
            Spacer()
                .frame(height: 40)
            HStack {
                Spacer()
                Button(action: {
                    self.enableSearch.toggle()
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(.systemBackground))
                            .shadow(radius: 10))
                })
                Spacer()
                    .frame(width: 10)
            }
            Spacer()
        }
    }
    
    func SearchTextPattern(Text: Binding<String>) -> some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .padding(.vertical, 35)
                        .padding(.horizontal, 14)
                        .offset(y: self.enableSearch ? 9 : -9)
                        .opacity(self.enableSearch ? 1 : 0)
                        .foregroundColor(Color(.systemBackground))
                        .frame(height: 110)
                        .shadow(color: .black ,radius: 10)
                    VStack {
                        Spacer()
                            .frame(height: 16)
                        HStack {
                            Spacer()
                                .frame(width: 20)
                            Button (action: {
                                self.enableSearch.toggle()
                                self.TextSearch = ""
                            }, label: {
                                Image(systemName: "chevron.right")
                                    .padding(10)
                                    .foregroundColor(.primary)
                            })
                            Spacer()
                            TextField("Введите преодователя, группу или аудиторию", text: Text)
                                .disabled(!self.enableSearch ? true : false)
                            Spacer()
                            Button(action:  {
                                
                            }, label: {
                                Image(systemName: "magnifyingglass")
                                    .padding(10)
                                    .foregroundColor(.primary)
                                    .opacity(self.TextSearch != "" ? 1 : 0.3)
                            })
                            .disabled(self.TextSearch != "" ? false : true)
                            Spacer()
                                .frame(width: 20)
                        }
                    }
                    .offset(y: self.enableSearch ? 0 : -20)
                    .opacity(self.enableSearch ? 1 : 0)
                }
            }
            Spacer()
        }
        .animation(.easeInOut, value: self.enableSearch)
    }
    
    func SearchRoundedRentaglePattern() -> some View {
        VStack {
            Spacer()
                .frame(height: 75)
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .padding(.vertical, 35)
                .padding(.horizontal, 14)
                .offset(y: self.TextSearch != "" ? 9 : 25)
                .opacity(self.TextSearch != "" ? 1 : 0)
                .foregroundColor(Color(.systemBackground))
                .shadow(color: .black ,radius: 10)
                .animation(.easeInOut, value: self.TextSearch)
            Spacer()
                .frame(height: 0)
        }
    }
    // ------------------------------------------------------------
    
    // MARK: Постройка макета опции меню
    // ------------------------------------------------------------
    // MARK: Выход
    // ------------------------------------------------------------
    func ExitButtonPattern() -> some View {
        HStack {
            Spacer()
                .frame(width: 30)
            Button(action: {
                self.enableMenuSize = -500
                self.enableMenuOpacity = 0.0
            }, label: {
                Image(systemName: "xmark")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Spacer()
                    .frame(width: 25)
                Text("Выход")
                    .frame(width: 130, alignment: .leading)
                    .multilineTextAlignment(.leading)
            })
            Spacer()
        }
        .foregroundColor(.red)
    }
    // ------------------------------------------------------------
    
    // MARK: Сервисы
    // ------------------------------------------------------------
    @Published var enableService = false
    func ServiceButtonPattern() -> some View {
        HStack {
            Spacer()
                .frame(width: 25)
            Button(action: {
                self.enableMenuSize = -500
                self.enableMenuOpacity = 0.0
                self.enableService.toggle()
            }, label: {
                Image("News")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                Spacer()
                    .frame(width: 20)
                Text("Сервисы")
                    .frame(width: 130, alignment: .leading)
                    .multilineTextAlignment(.leading)
            })
            Spacer()
        }
        .foregroundColor(.primary)
    }
    // ------------------------------------------------------------
    
    // MARK: Расписание
    // ------------------------------------------------------------
    @Published var enableSchedule = false
    func ScheduleButtonPattern() -> some View {
        HStack {
            Spacer()
                .frame(width: 25)
            Button(action: {
                self.enableMenuSize = -500
                self.enableMenuOpacity = 0.0
                self.enableSchedule.toggle()
            }, label: {
                Image("Schedule")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30)
                Spacer()
                    .frame(width: 20)
                Text("Расписание")
                    .frame(width: 130, alignment: .leading)
                    .multilineTextAlignment(.leading)
            })
            Spacer()
        }
        .foregroundColor(.primary)
    }
    // ------------------------------------------------------------
    // ------------------------------------------------------------
    
    // MARK: Приветствие
    // ------------------------------------------------------------
    func HelloLogoNCFUPattern() -> some View {
        Image("Logo")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    // ------------------------------------------------------------
    
    // MARK: Макет построки основного блока
    // ------------------------------------------------------------
    func RoundedRentaglePattern() -> some View {
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.vertical, 35)
            .padding(.horizontal, 14)
            .offset(y: 9)
            .foregroundColor(Color(.systemBackground))
    }
    // ------------------------------------------------------------
    
    // MARK: Макет постройки градиента по блокам, используя функцию верификация пользователя (Неавторизованные, Студенты, Преподаватели)
    // ------------------------------------------------------------
    func GradientPattern(Profil: String) -> some View {
        ZStack {
            if #available(iOS 15, *) {
                LinearGradient(colors: Profil == "Учеба" ? [.mint, .blue] : Profil == "Учебный процесс" ? [.pink, .blue] : [Color.blue, Color(.systemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
            } else {
                LinearGradient(colors: Profil == "Учеба" ? [Color(.displayP3, red: 152/255, green: 251/255, blue: 152/255), Color.blue] : Profil == "Учебный процесс" ? [.pink, .blue] : [Color.blue, Color(.systemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
        .ignoresSafeArea()
    }
    // ------------------------------------------------------------
    
    // MARK: Макет основной загрузки
    // ------------------------------------------------------------
    func LoadingPattern(Verif: String) -> some View {
        Circle()
            .trim(from: 0.1, to: 0.8)
            .stroke(AngularGradient(gradient: .init(colors: Verif == "Учеба" ? [Color(.systemBackground), Color.mint ,Color.cyan, Color.blue] : Verif == "Учебный процесс" ? [Color(.systemBackground), Color.purple, Color.cyan, Color.blue] : [Color(.systemBackground), Color.blue]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
    }
    
    func LoadingPatternOnContent(Verif: String) -> some View {
        Circle()
            .trim(from: 0.1, to: 0.8)
            .stroke(AngularGradient(gradient: .init(colors: Verif == "Учеба" ? [Color.mint ,Color.cyan, Color.blue] : Verif == "Учебный процесс" ? [Color.purple, Color.cyan, Color.blue] : [Color(.systemBackground), Color.blue]), center: .center), style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .shadow(radius: 10)
    }
    // ------------------------------------------------------------
    
    // MARK: Макет меню
    // ------------------------------------------------------------
    @Published var enableMenu = false
    @Published var enableMenuSize = -500
    @Published var enableMenuOpacity = 0.0
    
    func MenuPattern(ColorSchemeTheme: ColorScheme, enableMenu: Bool, enableMeniSize: Int, enableMenuOpacity: Double, Verif: String) -> some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: ColorSchemeTheme == .dark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight))
                .opacity(enableMenuOpacity)
                .animation(.spring(), value: enableMenuOpacity)
            ZStack {
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 250)
                        .offset(x: -25)
                        .foregroundColor(Color(.systemBackground))
                        .shadow(color: .black, radius: 10)
                    Spacer()
                }
                VStack {
                    Spacer()
                        .frame(height: 30)
                    HStack {
                        Spacer()
                            .frame(width: 72)
                        Image("LogoNCFURU")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 15)
                    HStack {
                        Spacer()
                            .frame(width: 12)
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(.systemGray5))
                            .frame(width: 200, height: 10)
                        Spacer()
                    }
                    Group {
                        Spacer()
                        VStack {
                            Spacer()
                                .frame(height: 20)
                            ServiceButtonPattern()
                            if Verif == "Учеба" || Verif == "Учебный процесс" {
                                Spacer()
                                    .frame(height: 40)
                                ScheduleButtonPattern()
                                Spacer()
                                    .frame(height: 40)
                                ExitButtonPattern()
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                            .frame(width: 12)
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(.systemGray5))
                            .frame(width: 200, height: 10)
                        Spacer()
                    }
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        Spacer()
                            .frame(width: 31)
                        Text("© Svidnitskiy Alexey, 2022")
                            .font(.footnote)
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(height: 25)
                }
            }
            .offset(x: CGFloat(enableMeniSize))
            .animation(.spring(), value: enableMeniSize)
        }
        .ignoresSafeArea()
    }
    // ------------------------------------------------------------
    
    // MARK: Кнопка вызова меню
    // ------------------------------------------------------------
    func ButtonMenuPattern(enableMenuSize: Int, enableMenuOpacity: Double) -> some View {
        VStack {
            Spacer()
                .frame(height: 46)
            HStack {
                Spacer()
                    .frame(width: 10)
                Button(action: {
                    self.enableMenuSize = 0
                    self.enableMenuOpacity = 1.0
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(.systemBackground))
                            .shadow(radius: 10))
                })
                Spacer()
            }
            Spacer()
        }
    }
    // ------------------------------------------------------------
    
    // MARK: Кнопка вызова меню
    // ------------------------------------------------------------
    func ButtonBackPattern() -> some View {
        VStack {
            Spacer()
                .frame(height: 41)
            HStack {
                Spacer()
                    .frame(width: 13)
                Button(action: {
                    self.enableService = false
                    self.enableSchedule = false
                    
                    self.enableCard = false
                    self.enableCardSize = 1500
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(Circle()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color(.systemBackground))
                            .shadow(radius: 10))
                })
                Spacer()
            }
            Spacer()
        }
    }
    // ------------------------------------------------------------
}

// MARK: Структура построения живого градиента
// ------------------------------------------------------------
struct StructGradientPattern: View {
    @ObservedObject var animationGradient: ViewPattern
    @Binding var Profil: String
    var body: some View {
        ZStack {
            ViewPattern().GradientPattern(Profil: self.Profil)
                .hueRotation(.degrees(animationGradient.AnimationGradient ? -30 : 30))
                .onAppear {
                    withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                        animationGradient.AnimationGradient.toggle()
                    }
                }
        }
    }
}

struct StructButtonGradientPattern: View {
    @ObservedObject var animationGradient: ViewPattern
    @Binding var Profil: String
    var body: some View {
        ZStack {
            ViewPattern().GradientPattern(Profil: self.Profil)
                .hueRotation(.degrees(animationGradient.AnimationGradientButton ? -30 : 30))
                .onAppear {
                    withAnimation(.easeInOut(duration: 10).repeatForever(autoreverses: true)) {
                        animationGradient.AnimationGradientButton.toggle()
                    }
                }
        }
    }
}
// ------------------------------------------------------------

struct StructButtonPattern: View {
    @ObservedObject var selected: ViewPattern
    @Binding var Profil: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer(minLength: 30)
                Button(action: {
                    selected.selectedOpacity = 0
                    withAnimation(Animation.spring()) {
                        selected.ShowHUDselected_0 = true
                        selected.selected = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            DismissShowHUDSelected_1()
                            DismissShowHUDSelected_2()
                            DismissShowHUDSelected_3()
                        }
                    }
                }, label: {
                    Image("News")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                })
                .opacity(selected.selected == 0 ? 1 : 0.3)
                Spacer(minLength: 10)
                Button(action: {
                    selected.selectedOpacity = 1
                    withAnimation(Animation.spring()) {
                        selected.ShowHUDselected_1 = true
                        selected.selected = 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            DismissShowHUDSelected_0()
                            DismissShowHUDSelected_2()
                            DismissShowHUDSelected_3()
                        }
                    }
                }, label: {
                    Image("News")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35)
                })
                .opacity(selected.selected == 1 ? 1 : 0.3)
                
                if Profil == "Учеба" || Profil == "Учебный процесс" {
                    Spacer(minLength: 10)
                    VStack {
                        Button(action: {
                            selected.enableCard.toggle()
                            selected.enableCardSize = 0
                        }, label: {
                            Image("Logo")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35)
                                .padding(7)
                                .colorMultiply(.black)
                                .colorInvert()
                        })
                        .background(StructButtonGradientPattern(animationGradient: selected, Profil: $Profil))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                    }
                    .offset(y: -30)
                    Spacer(minLength: 10)
                }
                else {
                    Spacer(minLength: 10)
                }
                
//                Button(action: {
//                    selected.selected = 2
//                    selected.ShowHUDselected_2 = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
//                        DismissShowHUDSelected_0()
//                        DismissShowHUDSelected_1()
//                        DismissShowHUDSelected_3()
//                    })
//                }, label: {
//                    Image("News")
//                        .renderingMode(.original)
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 35)
//                })
//                .opacity(selected.selected == 2 ? 1 : 0.3)
                Spacer()
                Group {
                    Button(action: {
                        withAnimation(Animation.spring()) {
                            selected.selected = 3
                            selected.ShowHUDselected_3 = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                                DismissShowHUDSelected_0()
                                DismissShowHUDSelected_1()
                                DismissShowHUDSelected_2()
                            })
                        }
//                        selected.selected = 3
//                        selected.ShowHUDselected_3 = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
//                            DismissShowHUDSelected_0()
//                            DismissShowHUDSelected_1()
//                            DismissShowHUDSelected_2()
//                        })
                    }, label: {
                        Image("News")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35)
                    })
                    .opacity(selected.selected == 3 ? 1 : 0.3)
                    Spacer()
                        .frame(width: 35)
                    Spacer(minLength: 30)
                }
            }
            Spacer()
                .frame(height: 35)
        }
    }
    
    func DismissShowHUDSelected_0() {
        selected.ShowHUDselected_0 = false
    }
    func DismissShowHUDSelected_1() {
        selected.ShowHUDselected_1 = false
    }
    func DismissShowHUDSelected_2() {
        selected.ShowHUDselected_2 = false
    }
    func DismissShowHUDSelected_3() {
        selected.ShowHUDselected_3 = false
    }
}

// MARK: Структура приветсвия
// ------------------------------------------------------------
struct StructHelloNCFU: View {
    @StateObject var Hello = ViewPattern()
    @Binding var Verif: String
    var body: some View {
        VStack {
            Spacer()
            Hello.HelloLogoNCFUPattern()
                .frame(width: 250)
            Spacer()
            StructLoading(loading: Hello, Verif: $Verif)
                .frame(width: 40, height: 40)
            Spacer()
        }
    }
}
// ------------------------------------------------------------

// MARK: Струкура загрузки
// ------------------------------------------------------------
struct StructLoading: View {
    @ObservedObject var loading: ViewPattern
    @Binding var Verif: String
    var body: some View {
        loading.LoadingPattern(Verif: Verif)
//            .rotationEffect(.init(degrees: loading.AnimationLoading ? 360 : 0))
            .rotationEffect(.degrees(loading.AnimationLoading ? 360 : 0))
            .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: loading.AnimationLoading)
            .onAppear {
                loading.AnimationLoading.toggle()
            }
    }
}

struct StructLoadingOnContent: View {
    @ObservedObject var loading: ViewPattern
    @Binding var Verif: String
    var body: some View {
        loading.LoadingPatternOnContent(Verif: Verif)
            .rotationEffect(.init(degrees: loading.AnimationLoading ? 360 : 0))
            .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false), value: loading.AnimationLoading)
            .onAppear {
                loading.AnimationLoading.toggle()
            }
    }
}
// ------------------------------------------------------------

// MARK: Структура меню
// ------------------------------------------------------------
struct StructMenu: View {
    @Environment(\.colorScheme) var ColorSchemeTheme
    @ObservedObject var MenuManual: ViewPattern
    @Binding var Verif: String
    var body: some View {
        MenuManual.MenuPattern(ColorSchemeTheme: ColorSchemeTheme, enableMenu: MenuManual.enableMenu, enableMeniSize: MenuManual.enableMenuSize, enableMenuOpacity: MenuManual.enableMenuOpacity, Verif: Verif)
            .gesture(DragGesture()
                .onChanged({ value in 
                    if (value.translation.width < 0 && value.translation.width > -150) && value.translation.height > 0 {
                        MenuManual.enableMenuSize = Int(value.translation.width)
                        MenuManual.enableMenuOpacity = (value.translation.width + 120) / 100
                    }
                })
                    .onEnded({ value in
                        if value.translation.width < -100 && value.translation.height > 0 {
                            MenuManual.enableMenuSize = -500
                            MenuManual.enableMenuOpacity = 0
                            MenuManual.enableMenu.toggle()
                        }
                        else {
                            MenuManual.enableMenuSize = 0
                            MenuManual.enableMenuOpacity = 1.0
                        }
                    }))
    }
}
// ------------------------------------------------------------

// MARK: Структура блока "Сервисы"
// ------------------------------------------------------------
struct StructService: View {
    @StateObject var Models = ViewPattern()
    @Binding var Verif: String
    var body: some View {
        ZStack {
            Models.RoundedRentaglePattern()
        }
    }
}
// ------------------------------------------------------------

// MARK: Структура блока "Сервисы"
// ------------------------------------------------------------
struct StructSchedule: View {
    @StateObject var Models = ViewPattern()
    @Binding var Verif: String
    var body: some View {
        ZStack {
            Models.RoundedRentaglePattern()
        }
    }
}
// ------------------------------------------------------------

// MARK: Структура блока "Поиск"
// ------------------------------------------------------------
struct StructSearch: View {
    @Environment(\.colorScheme) var ColorSchemeTheme
    @StateObject var Models = ViewPattern()
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: ColorSchemeTheme == .light ? .light : .dark))
                .opacity(Models.enableSearch ? 1 : 0)
                .animation(.easeInOut, value: Models.enableSearch)
            
            Models.SearchTextPattern(Text: $Models.TextSearch)
            Models.SearchRoundedRentaglePattern()
            
        }
        .ignoresSafeArea()
    }
}
// ------------------------------------------------------------

// MARK: Подготока к основному контенту
// ------------------------------------------------------------
struct StructPreContent: View {
    @ObservedObject var loading: ViewPattern
    @Binding var Verif: String
    var body: some View {
        StructGradientPattern(animationGradient: loading, Profil: $Verif)
        VStack {
            loading.HelloLogoNCFUPattern()
                .colorMultiply(.black)
                .colorInvert()
                .frame(width: 120)
            Spacer()
                .frame(height: 30)
            Text(Verif == "Учеба" ? "Добрый день, Студент" : "Добрый день, Сотрудник")
                .foregroundColor(Color(.systemBackground))
            Spacer()
                .frame(height: 40)
        }
        VStack {
            Spacer()
                .frame(width: 0)
            StructLoadingOnContent(loading: loading, Verif: $Verif)
                .frame(width: 40)
        }
    }
}
// ------------------------------------------------------------

struct StructVerifBiometry: View {
    @State var BiometricType = String()
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: .black, radius: 10)
            VStack {
                ZStack {
                    if BiometricType == "FaceID" {
                        Image("FaceID")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .offset(y: -100)
                    }
                    if BiometricType == "TouchID" {
                        Image("TouchID")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115)
                            .offset(y: -100)
                    }
                    if BiometricType == "Код-пар" {
                        Image("Passcode")
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 115)
                            .offset(y: -100)
                    }
                }
                HStack {
                    Spacer()
                        .frame(width: 60)
                    Text(BiometricType)
                        .bold()
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .frame(width: 60)
                }
                .offset(y: 0)
                HStack {
                    Spacer()
                        .frame(width: 60)
                    Text("Подключите, чтобы подтверждать вход и не вводить логин и пароль")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .offset(y: 20)
                    Spacer()
                        .frame(width: 60)
                }
            }
            
            VStack {
                Spacer()
                Button(action: {
                }, label: {
                    Text("Подключить")
                        .foregroundColor(.primary)
                        .padding(10)
                        .background(LinearGradient(colors: [Color.blue, Color(.systemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .cornerRadius(30)
                            .blur(radius: 10)
                            .shadow(color: Color.clear, radius: 50))
                })
                Spacer()
                    .frame(height: 80)
            }
        }
        .onAppear {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                self.BiometricType = context.biometryType == LABiometryType.faceID ? "FaceID" : context.biometryType == LABiometryType.touchID ? "TouchID" : "Код-пароль"
            }
        }
    }
}

struct StructVerifBiometry_Previews: PreviewProvider {
    static var previews: some View {
        StructVerifBiometry()
    }
}

// Протокол запроса на сайт
// ---------------------------------------------------------------------
protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

extension Dictionary : URLQueryParameterStringConvertible {
    /**
     This computed property returns a query parameters string from the given NSDictionary. For
     example, if the input is @{@"day":@"Tuesday", @"month":@"January"}, the output
     string will be @"day=Tuesday&month=January".
     @return The computed parameters string.
     */
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            if(key.hashValue == 1) {
#if DEBUG
                print(key)
#endif
            }
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
// ---------------------------------------------------------------------

// MARK: Макет структуры заднего визуального эффекта
// ---------------------------------------------------------------------
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
// ---------------------------------------------------------------------

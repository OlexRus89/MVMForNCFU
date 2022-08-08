import SwiftUI

struct Student: View {
    @StateObject var Models = ViewPattern()
    @Binding var Profil: String
    @State var onContent = true
    var body: some View {
        ZStack {
            if onContent {
                StructGradientPattern(animationGradient: Models, Profil: $Profil)
                Items(AnimationGradient: Models)
                    .offset(y: Models.ShowHUDselected_0 ? 0 : 1500)
                    .animation(.spring(), value: Models.selected)
                    .zIndex(Models.selected == 0 ? 1 : 0)
                ScheduleAuth(AnimationGradient: Models)
                    .offset(y: Models.ShowHUDselected_1 ? 0 : 1500)
                    .animation(.spring(), value: Models.selected)
                    .zIndex(Models.selected == 1 ? 1 : 0)
                Chat(AnimationGradient: Models)
                    .offset(y: Models.ShowHUDselected_2 ? 0 : 1500)
                    .animation(.spring(), value: Models.selected)
                    .zIndex(Models.selected == 2 ? 1 : 0)
                Profile(AnimationGradient: Models)
                    .offset(y: Models.ShowHUDselected_3 ? 0 : 1500)
                    .animation(.spring(), value: Models.selected)
                    .zIndex(Models.selected == 3 ? 1 : 0)
                
                Card(AnimationGradient: Models)
                    .offset(y: Models.enableCardSize)
                    .animation(.spring(), value: Models.enableCardSize)
                    .zIndex(3)
                
                StructButtonPattern(selected: Models, Profil: $Profil)
                    .zIndex(2)
                
                ZStack {
                    if Models.enableService || Models.enableSchedule || Models.enableCard {
                        if Models.enableService {
                            StructService(Verif: $Profil)
                        }
                        if Models.enableSchedule {
                            StructService(Verif: $Profil)
                        }
                        if Models.enableCard {
                            Models.ChangeCardButtonPattern()
                        }
                        
                        Models.ButtonBackPattern()
                    } else {
                        Models.ButtonMenuPattern(enableMenuSize: Models.enableMenuSize, enableMenuOpacity: Models.enableMenuOpacity)
                        Models.SearchButtonPattern()
                    }
                    StructSearch(Models: Models)
                    StructMenu(MenuManual: Models, Verif: $Profil)
                }
                .zIndex(3)
            } else {
                StructPreContent(loading: Models, Verif: $Profil)
            }
        }
    }
}

struct Card: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.enableCard ? Color.black : Color.clear, radius: 10)
                .animation(.spring(), value: AnimationGradient.enableCard)
            VStack {
                Text("Карта")
            }
        }
        .gesture(DragGesture()
            .onChanged({ value in 
                if value.translation.height > 0 {
                    AnimationGradient.enableCardSize = value.translation.height
                }
            })
                .onEnded({ value in
                    if value.translation.height < 200 {
                        AnimationGradient.enableCardSize = 0
                    }
                    else {
                        AnimationGradient.enableCard.toggle()
                        AnimationGradient.enableCardSize = 1500
                    }
                }))
    }
}




struct Items: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected != 0 || AnimationGradient.enableCard ? Color.clear : Color.black, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
                .animation(.spring(), value: AnimationGradient.enableCard)
            VStack {
                Text("Новости")
                Text("\(AnimationGradient.selected)")
            }
        }
    }
}

struct ScheduleAuth: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected != 1 || AnimationGradient.enableCard ? .clear : .black, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
                .animation(.spring(), value: AnimationGradient.enableCard)
            VStack {
                Text("Расписание")
                Text("\(AnimationGradient.selected)")
            }
        }
    }
}

struct Chat: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected != 2 || AnimationGradient.enableCard ? .clear : .black, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
                .animation(.spring(), value: AnimationGradient.enableCard)
            VStack {
                Text("Поступление")
                Text("\(AnimationGradient.selected)")
            }
            
        }
    }
}

struct Profile: View {
    @ObservedObject var AnimationGradient: ViewPattern
    var body: some View {
        ZStack {
            ViewPattern().RoundedRentaglePattern()
                .shadow(color: AnimationGradient.selected != 3 || AnimationGradient.enableCard ? .clear : .black, radius: 10)
                .animation(.spring(), value: AnimationGradient.selected)
                .animation(.spring(), value: AnimationGradient.enableCard)
            VStack {
                Text("Войти")
                Text("\(AnimationGradient.selected)")
            }
            
        }
    }
}

import SwiftUI

struct Teacher: View {
    @StateObject var AnimationGradinet = ViewPattern()
    @Binding var Profil: String
    @State var onContent = false
    var body: some View {
        ZStack {
            if onContent {
                StructGradientPattern(animationGradient: AnimationGradinet, Profil: $Profil)
                Items(AnimationGradient: AnimationGradinet)
                    .offset(y: AnimationGradinet.ShowHUDselected_0 ? 0 : 1500)
                    .animation(.spring(), value: AnimationGradinet.selected)
                    .zIndex(AnimationGradinet.selected == 0 ? 1 : 0)
                ScheduleAuth(AnimationGradient: AnimationGradinet)
                    .offset(y: AnimationGradinet.ShowHUDselected_1 ? 0 : 1500)
                    .animation(.spring(), value: AnimationGradinet.selected)
                    .zIndex(AnimationGradinet.selected == 1 ? 1 : 0)
                Chat(AnimationGradient: AnimationGradinet)
                    .offset(y: AnimationGradinet.ShowHUDselected_2 ? 0 : 1500)
                    .animation(.spring(), value: AnimationGradinet.selected)
                    .zIndex(AnimationGradinet.selected == 2 ? 1 : 0)
                Profile(AnimationGradient: AnimationGradinet)
                    .offset(y: AnimationGradinet.ShowHUDselected_3 ? 0 : 1500)
                    .animation(.spring(), value: AnimationGradinet.selected)
                    .zIndex(AnimationGradinet.selected == 3 ? 1 : 0)
                
                Card(AnimationGradient: AnimationGradinet)
                    .offset(y: AnimationGradinet.enableCardSize)
                    .animation(.spring(), value: AnimationGradinet.enableCardSize)
                    .zIndex(3)
                
                StructButtonPattern(selected: AnimationGradinet, Profil: $Profil)
                    .zIndex(2)
                
                ZStack {
                    if AnimationGradinet.enableService || AnimationGradinet.enableSchedule || AnimationGradinet.enableCard {
                        if AnimationGradinet.enableService {
                            StructService(Verif: $Profil)
                        }
                        if AnimationGradinet.enableSchedule {
                            StructService(Verif: $Profil)
                        }
                        if AnimationGradinet.enableCard {
                            AnimationGradinet.ChangeCardButtonPattern()
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
            } else {
                StructPreContent(loading: AnimationGradinet, Verif: $Profil)
            }
        }
    }
}

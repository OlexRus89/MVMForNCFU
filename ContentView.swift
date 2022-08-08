import SwiftUI
import SwiftSoup

struct ContentView: View {
    @State var StartView = false
    @State var Verif = String()
    var body: some View {
        ZStack {
            if StartView && Verif != "" {
                if Verif == "Расписание" {
                    NotAuth(Profil: $Verif)
                }
                if Verif == "Учеба" {
                    Student(Profil: $Verif)
                        .ignoresSafeArea()
                    
                }
                if Verif == "Учебный процесс" {
                    Teacher(Profil: $Verif)
                }
            } else {
                StructHelloNCFU(Verif: $Verif)
            }
        }
        .onAppear {
            Verif = "Расписание"
            StartView.toggle()
            DispatchQueue.global(qos: .background).async {
//                verification()
            }
        }
    }
    func verification() {
            let login = "vinokursky" // Дешифрование логина
            let password = "nxpwzmbi" // Дешифрование пароля
            
            // Запрос сайта авторизации (первое подключение сайта)
            // ---------------------------------------------------------------------
            let sessionConfig = URLSessionConfiguration.default
            
            /* Create session, and optionally set a URLSessionDelegate. */
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            /* Create the Request:
             Request (GET https://ecampus.ncfu.ru/account/login)
             */
            
            guard let URL = URL(string: "https://ecampus.ncfu.ru/account/login") else {return}
            var request = URLRequest(url: URL)
            request.httpMethod = "GET"
            
            // Headers
            
            request.addValue("gzip, zlib, deflate, zstd, br", forHTTPHeaderField: "Accept-Encoding")
            
            /* Start a new Task */
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                if (error == nil) {
                    // Success
                    let statusCode = (response as! HTTPURLResponse).statusCode
#if DEBUG
                    print("URL Session Task Succeeded: HTTP \(statusCode)")
#endif
                    
                    if statusCode == 500 {
                        verification() // Если ошибка 500, то повторно проверяет процедуру
                    }
                }
                else {
#if DEBUG
                    // Failure
                    print("URL Session Task Failed: %@", error!.localizedDescription)
#endif
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            // ---------------------------------------------------------------------
            
            // Взятие токена из первого запроса сайта
            // ---------------------------------------------------------------------
            do {
                let myHTMLString = try String(contentsOf: URL, encoding: .utf8)
                let htmlContent = myHTMLString
                do {
                    let doc: Document = try SwiftSoup.parse(htmlContent)
                    let elements = try doc.select("[name=__RequestVerificationToken]") // Извлекает токен
                    let RequestVerificationToken = try elements.get(0)
                    let token = try RequestVerificationToken.val()
                    let _ = webPost(userN: login, passwdN: password, token: token, URL: URL) // Функция на второй запрос сайта
                    print(token)
                }
                catch Exception.Error(type: _, Message: _) {
                    return
                }
                catch {
                    return
                }
            }
            catch {
                return
            }
        }
        
        func webPost(userN: String, passwdN: String, token: String, URL: URL) -> String {
            let requestVerificationName: String = "__RequestVerificationToken"
            let rememberMeName: String = "RememberMe"
            let remembermeBool: String = "true"
            let sessionConfig = URLSessionConfiguration.default
            let code: Int = 1
            
            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
            
            var request = URLRequest(url: URL)
            request.httpMethod = "POST"
            
            
            request.addValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.addValue("ecampus.ncfu.ru", forHTTPHeaderField: "Host")
            request.addValue("Paw/3.3.3 (Macintosh; OS X/12.1.0) GCDHTTPRequest", forHTTPHeaderField: "User-Agent")
            request.addValue("gzip, zlib, deflate, zstd, br", forHTTPHeaderField: "Accept-Encoding")
            
            let bodyParametersRequest = [requestVerificationName : token] // Добавление токена в запрос
            let bodyParametersLogin = ["Login" : userN] // Добавления логина в запрос
            let bodyParametersPassword = ["Password" : passwdN] // Добавления пароля в запрос
            let bodyParametersRememberMe = [rememberMeName : remembermeBool] // Добавление запоминания в запрос (Всегда истина)
            let Code = ["Code" : code]
            
            let bodyParameters: String = bodyParametersRequest.queryParameters + "&" + bodyParametersLogin.queryParameters + "&" + bodyParametersPassword.queryParameters + "&" + Code.queryParameters + "&" + bodyParametersRememberMe.queryParameters // Внесение в запрос
            
            print(bodyParameters)
            // Подключение запооса
            // ---------------------------------------------------------------------
            request.httpBody = bodyParameters.data(using: .utf8, allowLossyConversion: true)
            
            let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                if (error == nil) {
                    let statusCode = (response as! HTTPURLResponse).statusCode
                    // Success
                    if statusCode == 200 { // Если запрос удачный
                        
#if DEBUG
                        print("URL Session Task Succeeded: HTTP (POST) \(statusCode)")
#endif
                        self.Verif = VerificationProfil()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                            self.StartView.toggle()
                        })
                        //                    verificationWeb() // Функция перехода на проверку верификациии входа в ЛК
                    }
                    else { // Если запрос неудачный
                        verification() // Возвращается обратно на повтореную авторизацию
                        
#if DEBUG
                        print("URL Session Task Succeeded: HTTP (POST) \(statusCode)")
#endif
                    }
                }
                else {
#if DEBUG
                    // Failure
                    print("URL Session Task Failed: %@", error!.localizedDescription)
#endif
                }
            })
            task.resume()
            session.finishTasksAndInvalidate()
            // ----------------------------------------------------------------
            
            return ""
        }
        // ---------------------------------------------------------------------
        
        
        // Проверка входа в ЛК
        // ---------------------------------------------------------------------
        //    func verificationWeb() {
        //        let myURLString = "https://ecampus.ncfu.ru"
        //        guard let myURL = URL(string: myURLString) else { return }
        //        do {
        //            let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
        //            let htmlContent = myHTMLString
        //            do {
        //                let doc: Document = try SwiftSoup.parse(htmlContent)
        //                let divSignIn = try doc.select("div.login.text-right")
        //                let signIn = try divSignIn.select("a")
        //                //                let script = try doc.select("script")
        //                //                let type = try doc.select("[type=text/javascript]")
        //                //                let value = try type.select("[data-bind='text: FullName']")
        //                let boolSignIn = try signIn.text()
        //                if boolSignIn == "Войти"{
        //                    print("Не вошел")
        //                    isSuccess = false
        //                }
        //                else {
        //                    print("Вошел")
        //                    isSuccess = true
        //                }
        //            }
        //            catch Exception.Error(type: _, Message: _) {
        //                return
        //            }
        //            catch {
        //                return
        //            }
        //        }
        //        catch {
        //            return
        //        }
        //        // ---------------------------------------------------------------------
        //    }
        // ---------------------------------------------------------------------
}










import SwiftUI
import SwiftSoup

func VerificationProfil() -> String {
    let myURLString = "https://ecampus.ncfu.ru"
    guard let myURL = URL(string: myURLString) else { return "" }
    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .utf8)
        let htmlContent = myHTMLString
        do {
            let doc: Document = try SwiftSoup.parse(htmlContent)
            let script = try doc.select("ul")
            let selectSpan = try script.select("span").first()!
            let StatusText = try selectSpan.text()
            return StatusText
        }
        catch Exception.Error(type: _, Message: _) {
            return ""
        }
        catch {
            return ""
        }
    }
    catch {
        return ""
    }
}

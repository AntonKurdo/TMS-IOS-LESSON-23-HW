import Foundation
import UIKit

func verifyUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

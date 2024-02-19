import UIKit

func showAlert(title: String, message: String, vc: UIViewController, successAction: ((UIAlertAction) -> Void)? ){
    
    let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let okButton = UIAlertAction(title: "OK", style: .default, handler: successAction)

    alertMessagePopUpBox.addAction(okButton)
   
    vc.present(alertMessagePopUpBox, animated: true)
}

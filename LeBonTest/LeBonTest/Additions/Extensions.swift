//
//  Extensions.swift
//  LeBonTest
//
//  Created by Stéphane Azzopardi on 05/02/2021.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(url: URL, placeholder: UIImage? = nil, animated: Bool = true) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    self.image = placeholder
                    return
                }
                UIView.transition(with: self,
                                  duration: 0.2,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.image = image
                                  },
                                  completion: nil)
            }
        })

        task.resume()
        return task
    }
}

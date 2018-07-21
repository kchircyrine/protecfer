//
//  Presentation.swift
//  Protecfer
//
//  Created by cyrine kchir on 15/01/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

class Presentation {
   
    var title = ""
    var featuredImage: UIImage
    var color: UIColor
    
    struct TITLES {
        static let TITLE_1 = "Avec Protecfer"
        static let TITLE_2 = "Ne perdez plus de temps"
        static let TITLE_3 = "Cherchez les articles"
        static let TITLE_4 = "Commandez en ligne"
        static let TITLE_5 = "Payez en ligne"
        static let TITLE_6 = "Consulter la liste de vos commandes"
        static let TITLE_7 = "La commande vous vient jusqu'a votre porte"
    }
    
    struct IMAGES {
        static let IMG_1 = "f1"
        static let IMG_2 = "img1"
        static let IMG_3 = "f3"
        static let IMG_4 = "f4"
        static let IMG_5 = "f5"
        static let IMG_6 = "f6"
        static let IMG_7 = "f7"
    }
   
    
    init(title: String, featuredImage: UIImage, color: UIColor)
    {
        self.title = title
        self.featuredImage = featuredImage
        self.color = color
    }
    

    static func fetchInterests() -> [Presentation]
    {
        return [
            Presentation(title: TITLES.TITLE_1, featuredImage: UIImage(named: IMAGES.IMG_1)!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_2, featuredImage: UIImage(named: IMAGES.IMG_2)!, color: UIColor(red: 240/255.0, green: 133/255.0, blue: 91/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_3, featuredImage: UIImage(named: IMAGES.IMG_3)!, color: UIColor(red: 105/255.0, green: 80/255.0, blue: 227/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_4, featuredImage: UIImage(named: IMAGES.IMG_4)!, color: UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_5, featuredImage: UIImage(named: IMAGES.IMG_5)!, color: UIColor(red: 245/255.0, green: 62/255.0, blue: 40/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_6, featuredImage: UIImage(named: IMAGES.IMG_6)!, color: UIColor(red: 103/255.0, green: 217/255.0, blue: 87/255.0, alpha: 0.8)),
            Presentation(title: TITLES.TITLE_7, featuredImage: UIImage(named: IMAGES.IMG_7)!, color: UIColor(red: 63/255.0, green: 71/255.0, blue: 80/255.0, alpha: 0.8))
        ]
    }

}

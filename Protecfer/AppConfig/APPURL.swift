//
//  APPURL.swift
//  Protecfer
//
//  Created by cyrine kchir on 08/04/2018.
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit

struct APPURL {
    private struct Domains {
        //static let PRODUCT = "http://test-dev.cloudapp.net"
        static let Local = "http://localhost:3000"
        //static let QA = "testAddress.qa.com"
    }
    
    private  struct Routes {
        static let Api = "/api/"
    }
    
    private  static let Domain = Domains.Local
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    public static let PRODUCT_URL = BaseURL + "products"
    public static let PRODUCT_PICTURE_URL = PRODUCT_URL + "/img/"
    public static let LAST_PRODUCTS_URL = PRODUCT_URL + "/lastproducts/bydate"
    public static let SIMILAR_PRODUCTS_URL = PRODUCT_URL + "/sameCategory/"
    
    public static let BASE_USER_URL = BaseURL + "users"
    public static let REGISTER_URL =  BASE_USER_URL + "/signup"
    public static let LOGIN_URL =  BASE_USER_URL + "/login"
    public static let GET_USER_URL = BASE_USER_URL + "/byToken/"
   
    
    public static let WISHLIST_URL = BaseURL + "wishlist/"
    
    public static let ORDERLINES_URL = BaseURL + "orderlines/"
    
    public static let ORDER_PDF_URL = BaseURL + "pdf/"
    
    public static let COMPANY_URL = BaseURL + "companies/"
    
    
    public static let MESSAGE_URL = BaseURL + "messages/"
    
    public static let COMMENT_URL = BaseURL + "comments"
    
   public static let ACHIEVEMENT_URL = BaseURL + "realisations"
   public static let ACTIVE_ACHIEVEMENT_URL = ACHIEVEMENT_URL + "/active"
   public static let ACHIEVEMENT_IMG_URL = ACHIEVEMENT_URL + "/img/"
    
   
    public static let CATEGORIES_URL = BaseURL + "categories"
    public static let CATEGORIES_PARENT_URL = CATEGORIES_URL + "/only/categories"
    
    public static let TYPES_URL = BaseURL + "types"
    public static let ACTIVE_TYPES_URL = TYPES_URL + "/active"
    public static let PICTURE_TYPES_URL = TYPES_URL + "/img/"
    
}

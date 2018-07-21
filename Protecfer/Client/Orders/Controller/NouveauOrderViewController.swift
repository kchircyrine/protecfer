//
//  NouveauOrderViewController.swift
//  Protecfer
//  Copyright © 2018 cyrine kchir. All rights reserved.
//

import UIKit
import Toast_Swift

class NouveauOrderViewController: UIViewController,OrderLineCellDelegate {
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var payPalConfig = PayPalConfiguration() // default
    
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    var orderRepository = OrderRepository()
    var order = Order()
    var priceTVA: Float = 0.0
    var priceDelivery:Float = 0.0
    var subTotal:Float = 0.0
    var totalPrice: Float = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillContent()
        setUpPaypalConfig()
        let channel = AppPusher.pusher.subscribe("events-channel")
        channel.bind(eventName: "orders", callback: { (data: Any?) -> Void in
            if data != nil {
                do {
                    if let data = data as? NSDictionary {
                        self.order = Order()
                        self.order._id = (data["_id"] as? String)!
                        let orderlines = data["orderLines"] as? NSArray
                        for item in orderlines! {
                            if let orderLineDic = item as? NSDictionary {
                                let orderline = Orderline()
                                orderline.fromDicToObject(orderLineDic: orderLineDic)
                                self.order.orderLines.append(orderline)
                            }
                        }
                        self.calculateTotalPrice(order: self.order)
                    }
                    if self.order.orderLines.count == 0{
                        self.showEmptyMessage()
                    }else{
                       self.hideEmptyMessage()
                    }
                    self.tableView.reloadData()
                }
            }} )
        AppPusher.pusher.connect()
    }
    
    
    func calculateTotalPrice(order: Order) {
        for item in order.orderLines {
            subTotal = subTotal + item.product.price!
        }
        priceTVA = subTotal * 0.19
        priceDelivery = subTotal * 0.1
        totalPrice = priceTVA + priceDelivery + subTotal
        self.subTotalLabel.text = "\(subTotal) TND"
        self.totalPriceLabel.text = "\(totalPrice) TND"
    }
    
    func showEmptyMessage() {
        self.emptyMessage.isHidden = false
        self.tableView.isHidden = true
        self.bottomView.isHidden = true
    }
    
    func hideEmptyMessage() {
        self.emptyMessage.isHidden = true
        self.tableView.isHidden = false
        self.bottomView.isHidden = false
    }
    
    
    func fillContent()  {
        self.orderRepository.getOrder(token: TOKEN.getTOKEN()!){ order in
            self.order = order
            self.calculateTotalPrice(order: self.order)
            if self.order.orderLines.count == 0{
               self.showEmptyMessage()
            }else{
                self.hideEmptyMessage()
            }
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func paymentBtAction(_ sender: Any) {
        paymentAction()
    }
    
    func orderLineCellDidTapTrash(_ sender: OrderlineCell) {
        guard let tappedIndexPath = tableView.indexPath(for: sender) else { return }
        // Delete the row
        orderRepository.removeOrderlineFromOrder(id: order.orderLines[tappedIndexPath.row]._id!){ success in
            if success {
                self.order.orderLines.remove(at: tappedIndexPath.row)
                self.tableView.deleteRows(at: [tappedIndexPath], with: .automatic)
                self.calculateTotalPrice(order: self.order)
            } else {
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension NouveauOrderViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.orderLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : OrderlineCell = tableView.dequeueReusableCell(withIdentifier: "OrderlineCellule") as! OrderlineCell
        cell.orderline = self.order.orderLines[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension NouveauOrderViewController : PayPalPaymentDelegate {
    
    struct URLS {
        static let PAYPAL_URL = "https://www.paypal.com/webapps/mpp/ua/privacy-full"
        static let PAYPAL_URL_USERAGREEMENT = "https://www.paypal.com/webapps/mpp/ua/useragreement-full"
    }
    
    func setUpPaypalConfig () {
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Protecfer"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: URLS.PAYPAL_URL)
        payPalConfig.merchantUserAgreementURL = URL(string: URLS.PAYPAL_URL_USERAGREEMENT)
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
    }
    
     func paymentAction() {
        // Remove our last completed payment, just for demo purposes.
        //resultText = ""
        var items = [PayPalItem]()
        // Optional: include multiple items
        for order in self.order.orderLines {
            let item = PayPalItem(name: order.product.name!, withQuantity: UInt(order.quantity), withPrice:   NSDecimalNumber(string: "\(order.product.price! * 0.39)"), withCurrency: "USD", withSku: order.product.reference)
            
            items.append(item)
        }
       
        
        /*let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: "USD", withSku: "Hip-00066")
        let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "37.99"), withCurrency: "USD", withSku: "Hip-00291")*/
        
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "\(priceDelivery * 0.38)")
        let tax = NSDecimalNumber(string: "\( priceTVA  * 0.38)")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        let total = subtotal.adding(shipping).adding(tax)
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Total commande", intent: .sale)
        payment.items = items
        payment.paymentDetails = paymentDetails
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self as PayPalPaymentDelegate)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            print("Payment not processalbe: \(payment)")
        }
    }
    
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            var style = ToastStyle()
            self.orderRepository.validateOrder(reference: self.order.reference, completion: { (response) in
                style.backgroundColor = .blue
                if (response){
                    self.view.makeToast("Votre paiement a été effectué avec succés", duration: 3.0, position: .bottom, style: style)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }else {
                    self.view.makeToast("Erreur lors de la commande", duration: 3.0, position: .bottom, style: style)
                }
            })
        })
    }
    
}

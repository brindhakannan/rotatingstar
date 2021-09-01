//
//  ViewController.swift
//  RotatingStar
//
//  Created by Brindha Kannan on 26/08/21.
//

import UIKit

class ViewController: UIViewController, webserviceDelegate {
    
    func getresponse(response: Data) {
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: response, options: .allowFragments)
            print("jsonObj------------>",jsonObj)
            DispatchQueue.main.async{
                self.btn_start.isHidden = false
                self.animateBool = true
                self.rotateView(targetView: self.view_img)
            }
        }
        catch{
            print(error)
        }
    }
    
    
    var view_img = UIView()
    var imgStar = UIImageView()
    var btn_start = UIButton()

    var web_service = webservice()
    let duration = 2.0
    
    var animateBool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        drawUI()
        

//        self.rotateView(targetView: view_img, duration: duration)
        
    }
    
    func drawUI(){
        
        view.addSubview(view_img)
        view_img.translatesAutoresizingMaskIntoConstraints = false
        view_img.setViewConstraints(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, padding: UIEdgeInsets(top: view.frame.size.height * 0.25, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.size.width / 2, height: 150))
        view_img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view_img.backgroundColor = .blue
        
        view_img.addSubview(imgStar)
        imgStar.translatesAutoresizingMaskIntoConstraints = false
        imgStar.setViewConstraints(top: view_img.topAnchor, left: view_img.leadingAnchor, right: view_img.trailingAnchor, bottom: view_img.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        imgStar.backgroundColor = .brown
        
        guard let url = URL(string: "https://image.flaticon.com/icons/png/512/1828/1828884.png")
          else {
            print("Invalid URL")
            return }
        
        let data = try? Data(contentsOf: url)

        if let imageData = data {
            let image = UIImage(data: imageData)
            imgStar.image = image

        }
        
        view.addSubview(btn_start)
        btn_start.translatesAutoresizingMaskIntoConstraints = false
        btn_start.setViewConstraints(top: imgStar.bottomAnchor, left: imgStar.leadingAnchor, right: imgStar.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 50))
        btn_start.layer.cornerRadius = 5.0
        btn_start.layer.borderColor = UIColor.black.cgColor
        btn_start.layer.borderWidth = 0.5
        btn_start.setTitle("START", for: .normal)
        btn_start.setTitleColor(UIColor.black, for: .normal)
        btn_start.addTarget(self, action: #selector(btnClick), for: .touchUpInside)

    }
    
    func rotateView(targetView: UIView, duration: Double = 1.0) {
        
        if animateBool == false{
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(M_PI))
//            print("--->",CGFloat(M_PI))
        }) { finished in
            self.rotateView(targetView: self.view_img, duration: duration)
        }
        }
        else{
            UIView.setAnimationsEnabled(true)

        }
    }
    
    @objc func btnClick(){
        
        animateBool = false
        rotateView(targetView: view_img, duration: duration)
        btn_start.isHidden = true
        web_service.delegate = self
        web_service.serviceCall(urlString : "https://reqres.in/api/users?delay=3")
    
    }
}

extension UIView
{
    func setViewConstraints(top:NSLayoutYAxisAnchor?,left:NSLayoutXAxisAnchor?,right:NSLayoutXAxisAnchor?,bottom:NSLayoutYAxisAnchor?, padding:UIEdgeInsets = .zero,size:CGSize = .zero ) -> Void {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
        if let top = top
        {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive=true
        }
        
        if let bottom = bottom
        {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive=true
        }
        if let left = left
        {
            leadingAnchor.constraint(equalTo: left, constant: padding.left).isActive=true
        }
        if let right = right
        {
            trailingAnchor.constraint(equalTo: right, constant: padding.right).isActive=true
        }
        
        if size.width>0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive=true
        }
        
        if size.height>0
        {
            heightAnchor.constraint(equalToConstant: size.height).isActive=true
        }
    }
    
    func sizeAngchor(view: UIView,size:CGSize)
    {
        if size.width>0
        {
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: size.width).isActive = true
            
        }
        else
        {
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: size.height).isActive = true
        }
    }
    
}


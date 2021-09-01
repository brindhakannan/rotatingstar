//
//  webservice.swift
//  RotatingStar
//
//  Created by Brindha Kannan on 27/08/21.
//

import UIKit
import Security

protocol webserviceDelegate {
    func getresponse(response:Data)
}

class webservice: NSObject,URLSessionDelegate{
    
    var delegate : webserviceDelegate?
    
    func serviceCall(urlString:String) {
        
        var session : URLSession?
        let inputurl: String = urlString
        guard let endpointUrl = URL(string: inputurl as String) else {
            return
        }
        
        //NETWORK AVAILABILITY
        if ReachabilityTest.isConnectedToNetwork() {
            print("Internet connection available")
        }
        else{
           print("No internet connection available")
        }
        
        let urlrequest = URLRequest(url: endpointUrl)

        let config = URLSessionConfiguration.default
         session = URLSession(configuration: config)

        let task = session?.dataTask(with: urlrequest)
        {
            (data,response,error)in
            guard error == nil else
            {
                return
            }

            guard let responseData = data else {
                print("error")
                return
            }
            self.delegate?.getresponse(response: responseData)

        }
        task?.resume()
    }
  
}

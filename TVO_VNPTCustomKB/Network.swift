//
//  Network.swift
//  TVO_VNPTCustomKB
//
//  Created by Ngavt on 5/7/21.
//

import Foundation
import Moya
import ObjectMapper
import Alamofire

extension TargetType {
    var baseURL: URL {
        return URL(string: "http://ip-api.com")!
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        let header = [
            "Content-type": "application/json",
            "OS-type": "ios",
            "OS-version": UIDevice.current.systemVersion
        ]
        return header
    }

    func sendRequest<T: Mappable>(parsingModelType type: T.Type? = nil,
                                          options: NetworkOptions = NetworkOptions(),
                                          success: ((T) -> Void)? = nil,
                                          successRawData: ((Any) -> Void)? = nil,
                                          failure: ((_ errorMsg: String) -> Void)? = nil) {
        
        var logOptions: NetworkLoggerPlugin.Configuration.LogOptions!
        if options.showInputLog && options.showOutputLog {
            logOptions = [.errorResponseBody, .successResponseBody, .requestBody]
        } else if options.showInputLog {
            logOptions = [.errorResponseBody, .requestBody]
        } else if options.showOutputLog {
            logOptions = [.errorResponseBody, .successResponseBody]
        } else {
            logOptions = [.errorResponseBody]
        }
        let config = NetworkLoggerPlugin.Configuration.init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: logOptions)
        let plugins = [NetworkLoggerPlugin(configuration: config)]
        let provider = MoyaProvider<MultiTarget>(plugins: plugins)
        //let vc = options.parentVC ?? UIApplication.topViewController()
        
        if options.showLoading {
            //vc?.showLoading(options.loadingMessage)
        }
        
        let multiTarget = MultiTarget(self)
        provider.request(multiTarget) { result in
            if options.showLoading {
                //vc?.hideLoading()
            }
            
            switch result {
            case let .success(response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any], let object = T(JSON: json) {

                        success?(object)
                    }else {
                        failure?("Kh??ng th??? parse d??? li???u")
                    }
                } catch {
                    failure?("Kh??ng th??? parse d??? li???u")
                }
            case let .failure(error):
                failure?("C?? l???i kh??ng x??c ?????nh x???y ra. Vui l??ng ki???m tra k???t n???i internet v?? b???t t??nh n??ng Cho ph??p truy c???p ?????y ????? c???a b??n ph??m.")
            }
        }
        
    }
    
    private func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
}

struct NetworkOptions {
    var timeout: Double = 30
    var showLoading = true
    var loadingMessage = "??ang l???y d??? li???u..."
    var showOutputLog = true
    var showInputLog = true
    var autoShowErrorAlert = true
    var parentVC: UIViewController?
}

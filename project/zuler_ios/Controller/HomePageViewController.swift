//
//  HomePageViewController.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit
import SwiftyJSON
import WebRTC

class HomePageViewController: BaseViewController {
    
    private let config = RTCConfig.default
    
    lazy var accounTextField: UITextField = {
        
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.hexColor("#7e1671").cgColor
        tf.textColor = UIColor.hexColor("#4f383e")
        tf.attributedPlaceholder = NSAttributedString.init(string:"account", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor("#7a7374")])
        tf.textAlignment = .center
        return tf
        
    }()
    
    lazy var pwdTextField: UITextField = {
        
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.hexColor("#7e1671").cgColor
        tf.textColor = UIColor.hexColor("#4f383e")
        tf.attributedPlaceholder = NSAttributedString.init(string:"password", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexColor("#7a7374")])
        tf.textAlignment = .center
        return tf
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
 
        self.view.backgroundColor = UIColor.hexColor("#2775b6")
        
        self.view.addSubview(   accounTextField)
        self.view.addSubview(pwdTextField)
        
        accounTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        pwdTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        accounTextField.text = "1819533328"
        pwdTextField.text = "989526"
        
        let button = UIButton()
        button.backgroundColor = UIColor.hexColor("#e6d2d5")
        button.setTitle("登陆", for: .normal)
        button.setTitleColor(UIColor.hexColor("#2b1216"), for: .normal)
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(400)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        button.rx.tap.subscribe { [weak self] (event) in
            
            print("acc:\(self?.accounTextField.text) pwd:\(self?.pwdTextField.text)")
            
            self?.getServices()
            
//            self?.toWebRTCDemo()
            
//            NetManager.manager.postRequest(at: "", params: [:]) { result in
//
//            } failure: { error in
//
//            }

        }.disposed(by: bag)
        
//        let view = UIView()
//        view.backgroundColor = .black
//        self.view.addSubview(view)
//        view.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 100))
//        }
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(test))
//        view.addGestureRecognizer(tap)
        
        
        let button1 = UIButton()
        button1.backgroundColor = UIColor.hexColor("#e6d2d5")
        button1.setTitle("test", for: .normal)
        button1.setTitleColor(UIColor.hexColor("#2b1216"), for: .normal)
        self.view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(500)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        button1.rx.tap.subscribe { [weak self] (event) in
                        
            self?.getUid()

        }.disposed(by: bag)
        
        let button2 = UIButton()
        button2.backgroundColor = UIColor.hexColor("#e6d2d5")
        button2.setTitle("connect", for: .normal)
        button2.setTitleColor(UIColor.hexColor("#2b1216"), for: .normal)
        self.view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(600)
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        button2.rx.tap.subscribe { [weak self] (event) in
                        
            self?.connectRemoteDesktop(String(Defaults[.uid]), remoteId: self?.accounTextField.text ?? "", remotePassword: self?.pwdTextField.text ?? "")

        }.disposed(by: bag)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func getUid(){
        
        if Defaults[.uid] > 0{
            
            getRooms(String(Defaults[.uid]))
            
        }else{
            
            let dic = Defaults[.geo]
            
            NetManager.manager.postRequest(at: BaseUrlManager.manager.passportUrl+ApiManager.userGuestuid, isFullUrl: true, params: ["countryCode":dic["CountryCode"] ?? ""]) { [weak self] result in
    
                let json = JSON(result ?? [:])
                
                Defaults[.uid] = json["uid"].intValue
                
                self?.getRooms(String(Defaults[.uid]))
                
            } failure: { error in
                
            }

        }
        
    }
    
    
    func getRooms(_ uid: String){
        
        let dic = ["uid":String(Defaults[.uid]),"role":"presenter","type":"p2p","macID":UIDevice.current.identifierForVendor?.uuidString,"mediaConfiguration":"default"]
        
        NetManager.manager.postRequest(at: Defaults[.service]+ApiManager.rooms, isFullUrl: true, params: dic) { result in
            
            let json = JSON(result ?? [:])
            
            Defaults[.token] = json["token"].string ?? ""
            Defaults[.roomID] = json["roomID"].string ?? ""
            Defaults[.roomPassword] = json["roomPassword"].string ?? ""

//{"tokenId":"612f25ab26e4060111c3344b","host":"ec.izuler.io:30620","secure":true,"signature":"ZWI5MWVhNGRjMmIxY2Y5ZDg4OWE1YzE3N2VkMzkxMjkzN2M0MDM1Mg=="}
            
//            let str = PublicMethods.methods.base64Decoding(encodedString: json["token"].string ?? "")
//            let dataDic = JSON(str.toDictionary())
//
//            let transport = dataDic["secure"].boolValue ? "wss://" : "ws://"
//            let host = dataDic["host"].string ?? ""
//
//            let socketAddress = transport + host
//
//            print(socketAddress)
//
//            let query = ["singlePC":true, "geo":Defaults[.geo], "tokenId":dataDic["tokenId"].string ?? "", "host":dataDic["host"].string ?? "", "secure":true, "signature":dataDic["signature"].string ?? ""] as [String : Any]
//
//            let configDic = ["reconnects":true, "reconnectWait":1000, "reconnectWaitMax":16000, "randomizationFactor":0.001, "secure":dataDic["secure"].boolValue, "forceNew":true, "forceWebsockets":true, "connectParams":query] as [String : Any]
//
//            let webSocketProvider = SocketIO(url: URL(string: socketAddress)!, config: configDic)
//            let signalClient = SignalingClient(webSocket: webSocketProvider)
//
//            signalClient.connect()
            
        } failure: { error in
            
        }

        
    }
    
//    func uodateUid(_ uid:String, role:String, roomID:String){
//
//        let dic = ["uid":String(Defaults[.uid]),"role":"presenter","roomID":Defaults[.roomID]]
//
//        NetManager.manager.patchRequest(at: Defaults[.service]+ApiManager.roomsUid, params: dic) { result in
//
//            let json = JSON(result ?? [:])
//
//            Defaults[.token] = json["token"].string ?? ""
//
//        } failure: { error in
//
//        }
//
//    }
    
    func connectRemoteDesktop(_ uid:String, remoteId:String, remotePassword:String){
        
        let dic = ["uid":uid,"role":"presenter","type":"p2p","remoteId":remoteId,"remotePassword":remotePassword]
        
        NetManager.manager.postRequest(at: Defaults[.service]+ApiManager.roomsJoin, isFullUrl: true, params: dic) { [weak self] result in
            
            guard let sSelf = self else { return }
            
            let json = JSON(result ?? [:])
            
            let str = PublicMethods.methods.base64Decoding(encodedString: json["token"].string ?? "")
            let dataDic = JSON(str.toDictionary())
            
            let transport = dataDic["secure"].boolValue ? "wss://" : "ws://"
            let host = dataDic["host"].string ?? ""
            
            let socketAddress = transport + host
            
            print(socketAddress)
            
            let query = ["singlePC":true, "geo":Defaults[.geo].toJSONStringFromDictionary(), "tokenId":dataDic["tokenId"].string ?? "", "host":dataDic["host"].string ?? "", "secure":true, "signature":dataDic["signature"].string ?? ""] as [String : Any]
            
            let configDic = ["reconnects":true, "reconnectWait":1000, "reconnectWaitMax":16000, "randomizationFactor":0.001, "secure":dataDic["secure"].boolValue, "forceNew":true, "forceWebsockets":true, "connectParams":query] as [String : Any]
            
            let webSocketProvider = SocketIO(url: URL(string: socketAddress)!, config: configDic)
            let signalClient = SignalingClient(webSocket: webSocketProvider)
            
            signalClient.connect()
        
            signalClient.connectMessageCallback = { data in
                let array = data as! Array<Any>
                let dic = JSON(array.first as Any)
                let msgDic = dic["msg"].dictionaryValue
                let streams = msgDic["streams"]?.arrayValue
                let iceServers = msgDic["iceServers"]?.arrayValue
                print(msgDic)
                print(streams)
                print(iceServers)
                
                for dic in streams ?? []{
                    
                    let sId = dic["id"].intValue
                    
                    let infoDic = ["streamId":sId, "metadata":["type":"subscriber"]] as [String : Any]
                    signalClient.sendTypeMessage(message: ["options":infoDic], type: .subscribe)
                    
                }
                
                
                var iceArr = [RTCIceServer]()
                
                for dic in iceServers ?? [] {
                    if dic["username"].stringValue.isEmpty == true{
                        let ice = RTCIceServer(urlStrings: [dic["url"].stringValue])
                        iceArr.append(ice)
                    }else{
                        let ice = RTCIceServer(urlStrings: [dic["url"].stringValue], username: dic["username"].stringValue, credential: dic["credential"].stringValue)
                        iceArr.append(ice)
                    }
                }
                
                let webRTCClient = WebRTCClient(iceServers: iceArr)
                let vc = SignalController(signalClient: signalClient, webRTCClient: webRTCClient)
                sSelf.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        } failure: { error in
            
        }

    }
    
    func getServices(){
        
        NetManager.manager.getRequest(at: ApiManager.lbsServices) { result in
            
            let json = JSON(result ?? [:])
            
            Defaults[.location] = json["location"].string ?? ""
            Defaults[.geo] = json["geo"].dictionaryObject ?? [:]
            Defaults[.service] = "https://"+(json["serviceDomain"].string ?? "")
            
        } failure: { error in
            
        }

    }
    
//    func toWebRTCDemo(){
//        
//        let webRTCClient = WebRTCClient(iceServers: self.config.webRTCIceServers)
//        let signalClient = self.buildSignalingClient()
//        let mainViewController = SignalController(signalClient: signalClient, webRTCClient: webRTCClient)
//        
//        self.navigationController?.pushViewController(mainViewController, animated: true)
//        
//    }
//    
//    private func buildSignalingClient() -> SignalingClient {
//        
//        // iOS 13 has native websocket support. For iOS 12 or lower we will use 3rd party library.
//        let webSocketProvider: WebSocketProvider
//        
//        if #available(iOS 13.0, *) {
//            webSocketProvider = NativeWebSocket(url: self.config.signalingServerUrl)
//        } else {
//            webSocketProvider = StarscreamWebSocket(url: self.config.signalingServerUrl)
//        }
//        
//        return SignalingClient(webSocket: webSocketProvider)
//    }
    
    @objc func test(){
        
//        let vc = WarnAlertViewController()
//        vc.warnType = .joinBlacklist
//        self.show(vc, animation: CenterScaleAnimation(), shouldDismissOnTouchOutside: false, completion: nil)
        
        let vc = TestViewController()
        vc.delegate = self
        vc.testCallBack = { str in
            print(str)
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
//        PublicMethods.methods.test()
//        self.view.makeToast("test", duration: 2.0, position: .center)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomePageViewController: testDelegate{
    
    func testFunc(_ str: String) {
        print(str)
    }
    
}





//[{
//    msg =     {
//        clientId = "9de50ee9-c3af-4ee8-b813-60acb842cf98";
//        defaultVideoBW = 100000;
//        iceServers =         (
//                        {
//                url = "stun:150.138.226.251:3478";
//            },
//                        {
//                credential = zuler0610;
//                url = "turn:150.138.226.251:3478";
//                username = zuler;
//            }
//        );
//        id = 612ca83093b53101118a0805;
//        maxVideoBW = 100000;
//        singlePC = 0;
//        streamPriorityStrategy = 0;
//        streams =         (
//                        {
//                attributes =                 {
//                    type = publisher;
//                };
//                audio = 1;
//                data = 1;
//                height = 1080;
//                id = 756925606837632900;
//                label = u24Tr7iJgc32FeaAKj71sT0DSoAg7FUOI4fU;
//                p2p = 1;
//                screen = 1;
//                video = 1;
//                width = 1920;
//            }
//        );
//    };
//    socketgd = 0;
//}, <null>]


//[{
//    msg =     {
//        msg =         {
//            config =             {
//                maxVideoBW = 100000;
//            };
//            receivedSessionVersion = "-1";
//            sdp = "v=0
//\no=- 913705407041189789 2 IN IP4 127.0.0.1
//\ns=-
//\nt=0 0
//\na=msid-semantic: WMS IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7
//\na=group:BUNDLE 0 1 2
//\nm=audio 9 UDP/TLS/RTP/SAVPF 111 103 104 9 0 8 106 105 13 110 112 113 126
//\nc=IN IP4 0.0.0.0
//\na=rtpmap:111 opus/48000/2
//\na=rtpmap:103 ISAC/16000
//\na=rtpmap:104 ISAC/32000
//\na=rtpmap:9 G722/8000
//\na=rtpmap:0 PCMU/8000
//\na=rtpmap:8 PCMA/8000
//\na=rtpmap:106 CN/32000
//\na=rtpmap:105 CN/16000
//\na=rtpmap:13 CN/8000
//\na=rtpmap:110 telephone-event/48000
//\na=rtpmap:112 telephone-event/32000
//\na=rtpmap:113 telephone-event/16000
//\na=rtpmap:126 telephone-event/8000
//\na=fmtp:111 minptime=10;useinbandfec=1
//\na=rtcp:9 IN IP4 0.0.0.0
//\na=rtcp-fb:111 transport-cc
//\na=extmap:1 urn:ietf:params:rtp-hdrext:ssrc-audio-level
//\na=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
//\na=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
//\na=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
//\na=extmap:5 urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id
//\na=extmap:6 urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id
//\na=setup:actpass
//\na=mid:0
//\na=sendrecv
//\na=ice-ufrag:tZK8
//\na=ice-pwd:X93RJ0C78Izf74zVYuSRgewI
//\na=fingerprint:sha-256 65:9B:E3:25:4B:77:91:92:1F:52:EB:96:AF:CD:96:FA:55:6A:F1:D0:06:DD:EC:54:29:31:6F:58:80:65:1E:83
//\na=ice-options:trickle
//\na=ssrc:925282227 cname:WNW8YZug17chREHD
//\na=ssrc:925282227 msid:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7 944d86d8-01f8-418c-a7ca-74269e8faf43
//\na=ssrc:925282227 mslabel:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7
//\na=ssrc:925282227 label:944d86d8-01f8-418c-a7ca-74269e8faf43
//\na=rtcp-mux
//\nm=video 9 UDP/TLS/RTP/SAVPF 96 97 114 115 116
//\nc=IN IP4 0.0.0.0
//\nb=AS:100000
//\na=rtpmap:96 VP8/90000
//\na=rtpmap:97 rtx/90000
//\na=rtpmap:114 red/90000
//\na=rtpmap:115 rtx/90000
//\na=rtpmap:116 ulpfec/90000
//\na=fmtp:97 apt=96
//\na=fmtp:115 apt=114
//\na=rtcp:9 IN IP4 0.0.0.0
//\na=rtcp-fb:96 goog-remb
//\na=rtcp-fb:96 transport-cc
//\na=rtcp-fb:96 ccm fir
//\na=rtcp-fb:96 nack
//\na=rtcp-fb:96 nack pli
//\na=extmap:14 urn:ietf:params:rtp-hdrext:toffset
//\na=extmap:2 http://www.webrtc.org/experiments/rtp-hdrext/abs-send-time
//\na=extmap:13 urn:3gpp:video-orientation
//\na=extmap:3 http://www.ietf.org/id/draft-holmer-rmcat-transport-wide-cc-extensions-01
//\na=extmap:12 http://www.webrtc.org/experiments/rtp-hdrext/playout-delay
//\na=extmap:11 http://www.webrtc.org/experiments/rtp-hdrext/video-content-type
//\na=extmap:7 http://www.webrtc.org/experiments/rtp-hdrext/video-timing
//\na=extmap:8 http://www.webrtc.org/experiments/rtp-hdrext/color-space
//\na=extmap:4 urn:ietf:params:rtp-hdrext:sdes:mid
//\na=extmap:5 urn:ietf:params:rtp-hdrext:sdes:rtp-stream-id
//\na=extmap:6 urn:ietf:params:rtp-hdrext:sdes:repaired-rtp-stream-id
//\na=setup:actpass
//\na=mid:1
//\na=sendrecv
//\na=ice-ufrag:tZK8
//\na=ice-pwd:X93RJ0C78Izf74zVYuSRgewI
//\na=fingerprint:sha-256 65:9B:E3:25:4B:77:91:92:1F:52:EB:96:AF:CD:96:FA:55:6A:F1:D0:06:DD:EC:54:29:31:6F:58:80:65:1E:83
//\na=ice-options:trickle
//\na=ssrc:3293764917 cname:WNW8YZug17chREHD
//\na=ssrc:3293764917 msid:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7 f44d8259-0726-423d-9ef4-25162a266811
//\na=ssrc:3293764917 mslabel:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7
//\na=ssrc:3293764917 label:f44d8259-0726-423d-9ef4-25162a266811
//\na=ssrc:66427213 cname:WNW8YZug17chREHD
//\na=ssrc:66427213 msid:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7 f44d8259-0726-423d-9ef4-25162a266811
//\na=ssrc:66427213 mslabel:IPvIGKMXfgT3PZONunkgn2ZZYg6bxWb73rK7
//\na=ssrc:66427213 label:f44d8259-0726-423d-9ef4-25162a266811
//\na=ssrc-group:FID 3293764917 66427213
//\na=rtcp-mux
//\nm=application 9 UDP/DTLS/SCTP webrtc-datachannel
//\nc=IN IP4 0.0.0.0
//\na=setup:actpass
//\na=mid:2
//\na=sendrecv
//\na=ice-ufrag:tZK8
//\na=ice-pwd:X93RJ0C78Izf74zVYuSRgewI
//\na=fingerprint:sha-256 65:9B:E3:25:4B:77:91:92:1F:52:EB:96:AF:CD:96:FA:55:6A:F1:D0:06:DD:EC:54:29:31:6F:58:80:65:1E:83
//\na=ice-options:trickle
//\na=rtcp-mux
//\n";
//            type = offer;
//        };
//        peerSocket = "ce15e3aa-7000-4610-9cb7-4a687eed4ac9";
//        streamId = 280606485095633180;
//    };
//    socketgd = 1;
//}, <null>]

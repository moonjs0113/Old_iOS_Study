//
//  Category.swift
//  StudyUI
//
//  Created by Moon Jongseek on 2022/04/29.
//

// MARK: - Import
import Foundation

// MARK: - Struct
struct TitleCategory: Hashable {
    var name: String
    var childCategory: [Category]?
    var uiComponent: [UIComponent]?
}

struct Category: Hashable {
    var name: String
    var childTitleCategory: [TitleCategory]
}

struct UIComponent: Hashable {
    var name: String
    var script: String
    var url: URL?
}

// MARK: - Category
let swiftUICategory: Category = Category(name: "SwiftUI",
                                         childTitleCategory: [
                                            TitleCategory(name: "View Containers",
                                                          childCategory: [
                                                            layoutContainers,
                                                            Category(name: "Collection Containers",
                                                                     childTitleCategory: [
                                                                        
                                                                     ]),
                                                            Category(name: "Presentation Containers",
                                                                     childTitleCategory: [
                                                                        
                                                                     ])
                                                          ]),
                                            TitleCategory(name: "User Interface Elements",
                                                          childCategory: [
                                                            
                                                          ])
                                         ])

let layoutContainers = Category(name: "Layout Containers",
                                childTitleCategory: [
                                    TitleCategory(name: "Stack",
                                                  uiComponent: [
                                                    UIComponent(name: "VStack",
                                                                script: vStackScript),
                                                    UIComponent(name: "HStack",
                                                                script: "A view that arranges its children in a horizontal line."),
                                                    UIComponent(name: "ZStack",
                                                                script: "A view that overlays its children, aligning them in both axes.")
                                                  ])
                                ])

// MARK: - Script
let vStackScript = """
A view that arranges its children in a vertical line.
문단으로 편하게
"""


//
//  HomeViewController.swift
//  PerfectDay-iOS
//
//  Created by 문종식 on 2020/10/04.
//  Copyright © 2020 문종식. All rights reserved.
//
//import UIKit
//import Kingfisher
//import Alamofire
//import ImageSlideshow
//import MaterialDesignWidgets
//import Material
//import CoreLocation
//import RxCocoa
//import RxSwift
//import SafariServices
//
//class HomeViewController: UIViewController {
//    // MARK: - Properties
//    var listBannerInfo: [BannerDTO] = []
//    var notificationDTOObservable: Observable<NotificationContentDTO>!
//
//    let cornerRadius:CGFloat = 15
//
//    let viewModel = HomeViewModel()
//    var disposeBag = DisposeBag()
//
//    // MARK: - Methods
//    func setFirebaseToken() {
//        if let firebaseToken = firebaseToken {
//            PerfectDayAPI.shared.requestUserInfoUpdate(firebaseToken: firebaseToken) { (resultDTO, error) in
//                if let resultDTO = resultDTO {
//                    if resultDTO.result == "1" {
//                        USER_VO.firebaseToken = firebaseToken
//                    }
//                } else if let error = error {
//                    self.alertAPIError(error)
//                }
//            }
//        } else {
//            // 여기에 토큰 재발급 코드 작성
//        }
//    }
//
//    func getQueryStringParameter(url: String, param: String) -> String? {
//        guard let url = URLComponents(string: url) else { return nil }
//        return url.queryItems?.first(where: { $0.name == param })?.value
//    }
//
//    func checkKakaoShareUrl() {
//        if let url = kakaoUrl {
//            let urlStr = "\(url)"
//            kakaoUrl = nil
//
//            //가게 공유
//            if let storeSn = self.getQueryStringParameter(url: urlStr, param: "storeSn") {
//                requestStoreInfo(storeSn)
//            }
//
//            //코스 공유
//            if let courseSn = self.getQueryStringParameter(url: urlStr, param: "courseSn") {
//                let storyboard = UIStoryboard(name: "Home", bundle: nil)
//                let courseVC = storyboard.instantiateViewController(withIdentifier: "courseView") as! CourseViewController
//                courseVC.modalPresentationStyle = .fullScreen
//                courseVC.courseSn = courseSn
//                self.navigationController?.pushViewController(courseVC, animated: true)
//            }
//
//            // 퍼펙트딜 쿠폰정보 공유
//            if let couponSn = self.getQueryStringParameter(url: urlStr, param: "couponSn") {
//                PerfectDayAPI.shared.requestCouponInfo(couponSn: couponSn) { (couponDTO, error) in
//                    if let couponDTO = couponDTO {
//                        let storyboard = UIStoryboard(name: "PerfectDeal", bundle: nil)
//                        let perfectDealDetailVC = storyboard.instantiateViewController(withIdentifier: "perfectDealDetailView") as! PerfectDealDetailViewController
//                        perfectDealDetailVC.couponDTO = couponDTO
//                        self.navigationController?.pushViewController(perfectDealDetailVC, animated: true)
//                    } else if let error = error {
//                        self.alertAPIError(error)
//                    }
//                }
//            }
//        }
//    }
//
//    func checkPushNotiData() {
//        if let pushNotiData = pushNotiData {
//            self.completeClickedPushNotification(data: pushNotiData)
//        }
//    }
//
//    func completeClickedPushNotification(data: [AnyHashable: Any]) {
//        if let storeSn = data["storeSn"] as? String {
//            PerfectDayAPI.shared.requestStoreInfo(storeSn) { (storeDTO, error) in
//                if let storeDTO = storeDTO {
//                    PerfectDayAPI.shared.requestSelectedStoreCouponsInfo(storeSn: storeSn) { (couponDTOs, error) in
//                        if let couponDTOs = couponDTOs {
//                            let storyboard = UIStoryboard(name: "Place", bundle: nil)
//                            let placeCotainerVC = storyboard.instantiateViewController(withIdentifier: "placeCotainerView") as! PlaceCotainerViewController
//                            placeCotainerVC.couponDTOs = couponDTOs
//                            placeCotainerVC.storeDTO = storeDTO
//                            self.navigationController?.pushViewController(placeCotainerVC, animated: true)
//                        } else if let error = error {
//                            self.alertAPIError(error)
//                        }
//                    }
//                } else if let error = error {
//                    self.alertAPIError(error)
//                }
//            }
//        } else if let couponSn = data["couponSn"] as? String {
//            PerfectDayAPI.shared.requestCouponInfo(couponSn: couponSn) { (couponDTO, error) in
//                if let couponDTO = couponDTO {
//                    let storyboard = UIStoryboard(name: "PerfectDeal", bundle: nil)
//                    let perfectDealDetailVC = storyboard.instantiateViewController(withIdentifier: "perfectDealDetailView") as! PerfectDealDetailViewController
//                    perfectDealDetailVC.couponDTO = couponDTO
//
//                    self.navigationController?.pushViewController(perfectDealDetailVC, animated: true)
//                } else if let error = error {
//                    self.alertAPIError(error)
//                }
//            }
//        } else if let noticeSn = data["boardSn"] as? String {
//            PerfectDayAPI.shared.requestNotice(boardSn: noticeSn) { (noticeDTO, error) in
//                if let noticeDTO = noticeDTO {
//                    let noticeVC = NoticeViewController()
//                    noticeVC.noticeDTO = noticeDTO
//                    self.present(noticeVC, animated: true, completion: nil)
//                } else if let error = error {
//                    self.alertAPIError(error)
//                }
//            }
//        }
//
//        pushNotiData = nil
//    }
//
//    func setAttributeOfView() {
//        self.navigationController?.navigationBar.isHidden = true
//        self.tabBarController?.tabBar.isHidden = false
//    }
//
//    func setAttributePopUpView() {
//        if let hiddingDate = UserDefaults.standard.value(forKey: SET_HIDE_HOME_POPUP_GUIDE_KEY) as? Date {
//            let currentDate = Date()
//            let timeInterval = Int(hiddingDate.timeIntervalSince(currentDate))
//            if timeInterval > 0 {
//                self.popUpView.isHidden = true
//            }
//        }
//
//        self.popUpImageView.layer.cornerRadius = 13
//        self.popUpImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.TapPopUpImageView(_:)))
//        self.popUpImageView.addGestureRecognizer(tapGestureRecognizer)
//        self.closePopUpButton.addTarget(self, action: #selector(self.touchUpClosePopUpButton(_:)), for: .touchUpInside)
//        self.closePopUpForOneDayButton.addTarget(self, action: #selector(self.touchUpClosePopUpButton(_:)), for: .touchUpInside)
//    }
//
//    func createNoticeDTOObservable() {
//        self.notificationDTOObservable = Observable<NotificationContentDTO>.create { emitter in
//            let _ = PerfectDayAPI.shared.requestNotificationList{ (notificationDTO, error) in
//                if let notificationDTO = notificationDTO {
//                    emitter.onNext(notificationDTO)
//                } else if let error = error {
////                    emitter.onError(error)
//                    self.alertAPIError(error)
//                }
//            }
//            return  Disposables.create()
//        } // Observable을 만들어서
//        .observe(on: MainScheduler.instance) // Main 스레드에서 실행할 것(UI 수정이니까)
//
//    }
//
//    func setAttributeOfTopView(){
//        self.setAttributeOfLogoView()
//        self.setUpSearchButtonView()
//        self.setAttributeOfBannerView()
//        self.setUpMainMenuButtons()
//        self.setPlaceRegisterView()
//
//        //rx
//        self.getBlogListInfo()
//        self.getCouponListInfo()
//    }
//
//    func setAttributeOfLogoView() {
//        logoView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            logoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            logoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            logoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            logoView.heightAnchor.constraint(equalToConstant: self.navigationController!.navigationBar.frame.height)
//        ])
//        self.noticeButton.addTarget(self, action: #selector(self.touchUpNoticeButton(_:)), for: .touchUpInside)
//    }
//
//    func setUpSearchButtonView() {
//        searchButton.setViewBorder(cornerRadius: 10)
//        searchButton.imageView!.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            searchButton.imageView!.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: -20),
//            searchButton.imageView!.centerYAnchor.constraint(equalTo: searchButton.centerYAnchor)
//        ])
//        self.searchButton.addTarget(self, action: #selector(self.touchUpSearchButton(_:)), for: .touchUpInside)
//    }
//
//    func setAttributeOfBannerView() {
//        self.bannerContainerView.dropShadow()
//        var localSource:Array<ImageSource> = listBannerInfo.map{ _ in ImageSource(image: UIImage()) }
//        for (index, bannerDTO) in listBannerInfo.enumerated() {
//            let urlQueryString = bannerDTO.bannerUrl.getUrlQueryString()
//            if let imageURL = URL(string: urlQueryString) {
//                KingfisherManager.shared.retrieveImage(with: imageURL, completionHandler: { result in
//                    switch(result) {
//                    case .success(let imageResult):
//                        localSource[index] = ImageSource(image: imageResult.image)
//                    case .failure:
//                        localSource[index] = ImageSource(image: UIImage(named: "TempImage")!)
//                    }
//                    self.bannerImageSlideShowView.setImageInputs(localSource)
//                })
//            }
//        }
//
//
//        self.bannerImageSlideShowView.layer.cornerRadius = 15
//        self.bannerImageSlideShowView.slideshowInterval = 5.0
//        self.bannerImageSlideShowView.contentScaleMode = .scaleAspectFill
//        self.bannerImageSlideShowView.activityIndicator = DefaultActivityIndicator()
//        let labelPageIndicator = LabelPageIndicator()
//        self.bannerImageSlideShowView.pageIndicator = labelPageIndicator
//        self.bannerImageSlideShowView.pageIndicatorPosition = .init(horizontal: .right(padding: 20), vertical: .customBottom(padding: 10))
//
//        let indicatorBackgroundView = UIView().then {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            self.bannerImageSlideShowView.addSubview($0)
//            $0.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7019402712)
//            $0.layer.cornerRadius = 9
//
//            NSLayoutConstraint.activate([
//                $0.centerYAnchor.constraint(equalTo: labelPageIndicator.centerYAnchor),
//                $0.centerXAnchor.constraint(equalTo: labelPageIndicator.centerXAnchor),
//                $0.heightAnchor.constraint(equalTo: labelPageIndicator.heightAnchor, multiplier: 1.3),
//                $0.widthAnchor.constraint(equalTo: labelPageIndicator.widthAnchor, multiplier: 1.5),
//            ])
//        }
//
//        self.bannerImageSlideShowView.bringSubviewToFront(labelPageIndicator)
//
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapBannerImageSlideShow(_:)))
//        self.bannerImageSlideShowView.addGestureRecognizer(tapGestureRecognizer)
//        self.bannerImageSlideShowView.delegate = self
//    }
//
//    func setUpMainMenuButtons() {
//        self.mainMenuButton1.dropShadow()
//        self.mainMenuButton1.makeImageFilled()
//
//        self.mainMenuButton2.dropShadow()
//        self.mainMenuButton2.makeImageFilled()
//
//        self.mainMenuButton3.dropShadow()
//        self.mainMenuButton3.makeImageFilled()
//
//        self.mainMenuButton4.dropShadow()
//        self.mainMenuButton4.makeImageFilled()
//
//        viewModel.onTouchedCommunityButton = { [weak self] in
//            self?.tabBarController?.selectedIndex = 1
//        }
//
//        viewModel.onTouchedPerfectDealButton = { [weak self] in
//            self?.goToPerfectDealView()
//        }
//
//        viewModel.onTouchedSearchPlaceSeoulButton = { [weak self] in
//            self?.goToSearchSeoulView()
//        }
//
//        viewModel.onTouchedSearchPlaceCountryButton = { [weak self] in
//            self?.goToSearchCountryView()
//        }
//
//        viewModel.onTouchedSearchPlaceCustomButton = { [weak self] in
//            self?.getFindAroundLocation()
//        }
//
//        viewModel.onTouchedRecommendCourseCustomButton = { [weak self] in
//            self?.goToRecommendCourseCustomView()
//        }
//
//        viewModel.onTouchedRecommendCourseAIButton = { [weak self] in
//            self?.goToAIRecommendationCourseView()
//        }
//
//        viewModel.onTouchedRecommendPlaceCountryButton = { [weak self] in
//            self?.goToBlogListView()
//        }
//
//        viewModel.mainMenuButtonsSubject
//            .subscribe(onNext: { [weak self] in
//                let imageName = $0[0].imageName
//
//                guard let self = self else  {
//                    return
//                }
//
//                if self.mainMenuButton1.imageView?.image == nil {
//                    self.mainMenuButton1.setImage(UIImage(named: imageName), for: .normal)
//                } else {
//                    UIView.transition(with: self.mainMenuButton1, duration: 0.25, options: .curveEaseOut) {
//                        self.mainMenuButton1.imageView?.image = nil
//                    } completion: { sucess in
//                        UIView.transition(with: self.mainMenuButton1, duration: 0.25, options: .transitionCrossDissolve) {
//                            self.mainMenuButton1.setImage(UIImage(named: imageName), for: .normal)
//                        }
//                    }
//                }
//
//
//                $0[0].action?()
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.mainMenuButtonsSubject
//            .subscribe(onNext: { [weak self] in
//                let imageName = $0[1].imageName
//
//                guard let self = self else  {
//                    return
//                }
//
//                if self.mainMenuButton2.imageView?.image == nil {
//                    self.mainMenuButton2.setImage(UIImage(named: imageName), for: .normal)
//                } else {
//                    UIView.transition(with: self.mainMenuButton2, duration: 0.25, options: .curveEaseOut) {
//                        self.mainMenuButton2.imageView?.image = nil
//                    } completion: { sucess in
//                        UIView.transition(with: self.mainMenuButton2,  duration: 0.25, options: .transitionCrossDissolve) {
//                            self.mainMenuButton2.setImage(UIImage(named: imageName), for: .normal)
//                        }
//                    }
//                }
//
//
//                $0[1].action?()
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.mainMenuButtonsSubject
//            .subscribe(onNext: { [weak self] in
//                let imageName = $0[2].imageName
//
//                guard let self = self else  {
//                    return
//                }
//
//                if self.mainMenuButton3.imageView?.image == nil {
//                    self.mainMenuButton3.setImage(UIImage(named: imageName), for: .normal)
//                } else {
//                    UIView.transition(with: self.mainMenuButton3, duration: 0.25, options: .curveEaseOut) {
//                        self.mainMenuButton3.imageView?.image = nil
//                    } completion: { sucess in
//                        UIView.transition(with: self.mainMenuButton3, duration: 0.25, options: .transitionCrossDissolve) {
//                            self.mainMenuButton3.setImage(UIImage(named: imageName), for: .normal)
//                        }
//                    }
//                }
//
//
//                $0[2].action?()
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.mainMenuButtonsSubject
//            .subscribe(onNext: { [weak self] in
//                let imageName = $0[3].imageName
//
//                guard let self = self else  {
//                    return
//                }
//
//                if self.mainMenuButton4.imageView?.image == nil {
//                    self.mainMenuButton4.setImage(UIImage(named: imageName), for: .normal)
//                } else {
//                    UIView.transition(with: self.mainMenuButton4, duration: 0.25, options: .curveEaseOut) {
//                        self.mainMenuButton4.imageView?.image = nil
//                    } completion: { sucess in
//                        UIView.transition(with: self.mainMenuButton4, duration: 0.25, options: .transitionCrossDissolve) {
//                            self.mainMenuButton4.setImage(UIImage(named: imageName), for: .normal)
//                        }
//                    }
//                }
//
//                $0[3].action?()
//            })
//            .disposed(by: disposeBag)
//    }
//
//    func setPlaceRegisterView() {
//        self.placeRegisterView.dropShadow(bgColor: THEME_COLOR)
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapPlaceRegisterView(_:)))
//        self.placeRegisterView.addGestureRecognizer(tapGestureRecognizer)
//    }
//
//    func addBlogCard(blogDTOList: [BlogDTO]) {
//        for blogDTO in blogDTOList {
//            let blogSimpleCardView = BlogSimpleCard(blogDTO: blogDTO).then {
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.requestBlogInfo(_:)))
//                $0.addGestureRecognizer(tapGestureRecognizer)
//            }
//            self.blogSimpleCardStackView.addArrangedSubview(blogSimpleCardView)
//        }
//    }
//
//    func addCouponCard(couponDTOList: [CouponDTO]) {
//        for couponDTO in couponDTOList {
//            let couponSimpleCardView = CouponSimpleCard(couponDTO: couponDTO).then {
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.requestCouponInfo(_:)))
//                $0.addGestureRecognizer(tapGestureRecognizer)
//            }
//            self.couponSimpleCardStackView.addArrangedSubview(couponSimpleCardView)
//        }
//    }
//
//    // Get Data Function
//    func getBlogListInfo() {
//            Observable<[BlogDTO]>.create { emitter in
//                let _ = PerfectDayAPI.shared.requestBlogListInfo(limit: 5) { (blogDTOs, error) in
//                    if let blogDTOs = blogDTOs {
//                        emitter.onNext(blogDTOs)
//                    } else if let error = error {
//                        self.alertAPIError(error)
////                        emitter.onError(error)
//                    }
//                }
//
//                return  Disposables.create()
//            } // Observable을 만들어서
//            .observe(on: MainScheduler.instance) // Main 스레드에서 실행할 것(UI 수정이니까
//            .subscribe(onNext: { (blogDTOs) in
//                (self.blogSimpleCardStackView.arrangedSubviews.first as! UIActivityIndicatorView).stopAnimating()
//                self.addBlogCard(blogDTOList: blogDTOs)
//            })
//            .disposed(by: self.disposeBag)
//
//    }
//
//    func getNotificationCount() {
//        self.notificationDTOObservable?
//            .subscribe(onNext: { (notificationDTOArray) in
//                if let notificationDTOArray = notificationDTOArray.content {
//                    let notificationRead = notificationDTOArray.map { $0.read }
//                    let notificationCount = notificationRead.filter{ $0 == false }.count
//                    UIApplication.shared.applicationIconBadgeNumber = notificationCount
//                    self.noticeButton.setImage(UIImage(named: notificationRead.contains(false) ? "NoticeIcon_On" : "NoticeIcon_Off"))
//                }
//            })
//        .disposed(by: self.disposeBag)
//    }
//
//    func getCouponListInfo() {
//            Observable<[CouponDTO]>.create { emitter in
//                PerfectDayAPI.shared.requestCoupons(couponFilter: nil, couponSort: nil, offset: 0, limit: 5, longitude: 0, latitude: 0) { (couponDTOs, error) in
//                    if let couponDTOs = couponDTOs {
//                        emitter.onNext(couponDTOs)
//                    } else if let error = error {
//                        self.alertAPIError(error)
//                    }
//                }
//                return  Disposables.create()
//            } // Observable을 만들어서
//            .observe(on: MainScheduler.instance) // Main 스레드에서 실행할 것(UI 수정이니까
//            .subscribe(onNext: { (couponDTOs) in
//                (self.couponSimpleCardStackView.arrangedSubviews.first as! UIActivityIndicatorView).stopAnimating()
//                self.addCouponCard(couponDTOList: couponDTOs)
//            })
//            .disposed(by: self.disposeBag)
//    }
//
//    // 페이지 이동 함수
//    func goToRegisterPlaceView() {
//        let registerPlaceVC = UIStoryboard(name: "RegisterPlace", bundle: nil).instantiateViewController(withIdentifier: "registerPlaceView") as! RegisterPlaceViewController
//
//        let navigationVC = UINavigationController(rootViewController: registerPlaceVC)
//        navigationVC.modalPresentationStyle = .fullScreen
//        navigationVC.navigationBar.tintColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
//
//        present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToSearchView() {
//        let storyboard = UIStoryboard(name: "Search", bundle: nil)
//        guard let searchVC = storyboard.instantiateViewController(withIdentifier: "searchView") as? SearchViewController else { return }
//
//        LOCATION_INFO_VO.getCurrentUserLocation { [weak self] _ in
//            self?.navigationController?.pushViewController(searchVC, animated: false)
//        }
//    }
//
//    func goToNoticeListView(noticeSn: String? = nil) {
//        // 페이지 내에서 불러오는거로 변경
//        let noticeListVC = NoticePagerViewController()
//        self.navigationController?.pushViewController(noticeListVC, animated: true)
//    }
//
//    func goToNoticeView(noticeSn: String) {
//        PerfectDayAPI.shared.requestNotice(boardSn: noticeSn) { (noticeDTO, error) in
//            if let noticeDTO = noticeDTO {
//                let noticeVC = NoticeViewController()
//                noticeVC.noticeDTO = noticeDTO
//                self.present(noticeVC, animated: true, completion: nil)
//            } else if let error = error {
//                self.alertAPIError(error)
//            }
//        }
//    }
//
//    func goToAIRecommendationCourseView() {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let goToVC = storyboard.instantiateViewController(withIdentifier: "AIRecommendationCourseView") as? AIRecommendationCourseViewController else { return }
//
//        let navigationVC = UINavigationController(rootViewController: goToVC)
//
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToTermsOfServiceView(title: String, contentIndex: Int) {
//        let termViewController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "termOfServiceView") as! TermsOfServiceViewController
//        termViewController.titleString = title
//        termViewController.contentIndex = contentIndex
//        let navigationVC = UINavigationController(rootViewController: termViewController)
//        navigationVC.navigationBar.tintColor = .white
//        navigationVC.navigationBar.barTintColor = .white
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToRecommendCourseCustomView() {
//        let mainStoryBoard = UIStoryboard(name: "Home", bundle: nil)
//        let recommendCourseVC = mainStoryBoard.instantiateViewController(withIdentifier: "recommendCourseView") as! RecommendCourseViewController
//
//        let navigationVC = UINavigationController(rootViewController: recommendCourseVC)
//
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToSearchSeoulView() {
//        let storyboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let seoulVC = storyboard.instantiateViewController(withIdentifier: "seoulView") as? SeoulHomeViewController else { return }
//
//        let navigationVC = UINavigationController(rootViewController: seoulVC)
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToSearchCountryView() {
//        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        guard let nationalVC = mainStoryboard.instantiateViewController(withIdentifier: "nationalView") as? NationalHomeViewController else { return }
//
//        let navigationVC = UINavigationController(rootViewController: nationalVC)
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func getFindAroundLocation() {
//        let storyboard = UIStoryboard(name: "Location", bundle: nil)
//        guard let searchLocationVC = storyboard.instantiateViewController(withIdentifier: "searchLocationView") as? SearchLocationViewController else { return }
//        searchLocationVC.isCustomSearchLocation = true
//        let navigationVC = UINavigationController(rootViewController: searchLocationVC)
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToBlogListView() {
//        let storyboard = UIStoryboard(name: "Blog", bundle: nil)
//        guard let goToVC = storyboard.instantiateViewController(withIdentifier: "BlogListView") as? BlogListViewController else { return }
//
//        let navigationVC = UINavigationController(rootViewController: goToVC)
//
//        navigationVC.modalPresentationStyle = .fullScreen
//
//        self.present(navigationVC, animated: true, completion: nil)
//    }
//
//    func goToBlogInfoView(blogDTO: BlogDTO){
//        let storyboard = UIStoryboard(name: "Blog", bundle: nil)
//        guard let goToVC = storyboard.instantiateViewController(withIdentifier: "BlogTabView") as? BlogTabParentViewController else { return }
//        goToVC.blogDTO = blogDTO
//        self.navigationController?.pushViewController(goToVC, animated: true)
//    }
//
//    func goToPerfectDealView() {
//        let perfectDealVC = UIStoryboard(name: "PerfectDeal", bundle: nil).instantiateViewController(withIdentifier: "perfectDealView") as! PerfectDealViewController
//
//        self.navigationController?.pushViewController(perfectDealVC, animated: true)
//    }
//
//    func goToCouponDetailView(couponDTO: CouponDTO) {
//        let storyboard = UIStoryboard(name: "PerfectDeal", bundle: nil)
//        guard let goToVC = storyboard.instantiateViewController(withIdentifier: "perfectDealDetailView") as? PerfectDealDetailViewController else { return }
//        goToVC.couponDTO = couponDTO //self.couponDTOs[couponIndex]
//
//        self.navigationController?.pushViewController(goToVC, animated: true)
//    }
//
//    func goToAttendanceView() {
//        let attendanceCheckVC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "attendanceCheckView") as! AttendanceCheckViewController
//        attendanceCheckVC.modalPresentationStyle = .fullScreen
//        present(attendanceCheckVC, animated: true, completion: nil)
//    }
//
//    // MARK: - IBOutlets
//    @IBOutlet weak var bannerContainerView: UIView!
//    @IBOutlet weak var logoView: UIView!
//    @IBOutlet weak var searchButton: UIButton!
//    @IBOutlet weak var noticeButton: IconButton!
//    @IBOutlet weak var bannerImageSlideShowView: ImageSlideshow!
//
//    @IBOutlet weak var mainMenuButton1: UIButton!
//    @IBOutlet weak var mainMenuButton2: UIButton!
//    @IBOutlet weak var mainMenuButton3: UIButton!
//    @IBOutlet weak var mainMenuButton4: UIButton!
//
//    @IBOutlet weak var blogSimpleCardStackView: UIStackView!
//    @IBOutlet weak var couponSimpleCardStackView: UIStackView!
//
//    @IBOutlet weak var placeRegisterView: UIView!
//
//    @IBOutlet weak var businessInfoButton: UIButton!
//    @IBOutlet weak var businessInfoLabel: UILabel!
//    @IBOutlet weak var TermsButtonStackView: UIStackView!
//
//    @IBOutlet weak var indicLoading: UIActivityIndicatorView!
//
//    @IBOutlet weak var popUpView: UIView!
//    @IBOutlet weak var popUpImageView: UIImageView!
//    @IBOutlet weak var closePopUpButton: UIButton!
//    @IBOutlet weak var closePopUpForOneDayButton: UIButton!
//
//    // MARK: - IBActions
//    //###########################
//    //       사업자 정보
//    //###########################
//    @IBAction func touchUpBusinessInfoButton(_ sender: UIButton) {
//        businessInfoLabel.isHidden = !businessInfoLabel.isHidden
//        let imageName = businessInfoLabel.isHidden ? "DownArrow" : "UpArrow"
//        sender.setImage(UIImage(named: imageName))
////        print("Firebase Token: \(firebaseToken)")
//    }
//
//    @IBAction func touchUpTermsOfServiceButton(_ sender: UIButton) {
//        let contentIndex = sender.tag
//        let title = sender.currentTitle!
//
//        goToTermsOfServiceView(title: title, contentIndex: contentIndex)
//    }
//
//    @IBAction func touchUpMainMenu1Button(_ sender: UIButton) {
//        viewModel.touchUpMainMenu1Button()
//    }
//
//    @IBAction func touchUpMainMenu2Button(_ sender: UIButton) {
//        viewModel.touchUpMainMenu2Button()
//    }
//
//    @IBAction func touchUpMainMenu3Button(_ sender: UIButton) {
//        viewModel.touchUpMainMenu3Button()
//    }
//
//    @IBAction func touchUpMainMenu4Button(_ sender: UIButton) {
//        viewModel.touchUpMainMenu4Button()
//    }
//
//    @IBAction func touchUpMoreBlogList(_ sender: UIButton) {
//        self.goToBlogListView()
//    }
//
//    @IBAction func touchUpMorePerfectDealList(_ sender: UIButton) {
//        self.goToPerfectDealView()
//    }
//
//    // MARK: - Objcs
//    @objc func TapPopUpImageView(_ sender: UITapGestureRecognizer) {
//        goToPerfectDealView()
//        self.popUpView.isHidden = true
//    }
//
//    @objc func touchUpClosePopUpButton(_ sender: UIButton) {
//        if sender == self.closePopUpForOneDayButton {
//            var component = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//            component.timeZone = TimeZone.current
//            let dateWithoutTime = Calendar.current.date(from: component)!
//
//            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: dateWithoutTime)
//
//            UserDefaults.standard.set(nextDate, forKey: SET_HIDE_HOME_POPUP_GUIDE_KEY)
//        }
//
//        self.popUpView.isHidden = true
//    }
//
//    @objc func touchUpSearchButton(_ sender:IconButton) {
//        self.goToSearchView()
//    }
//
//    @objc func touchUpNoticeButton(_ sender: IconButton) {
//        self.goToNoticeListView()
//    }
//
//    @objc func tapBannerImageSlideShow(_ sender: UITapGestureRecognizer) {
//        let currentBannerDTO = listBannerInfo[bannerImageSlideShowView.currentPage]
//
//        //임시방편 -> 추후 수정필요
//        switch currentBannerDTO.bannerCategory {
//        case "DEFAULT":
//            break
//        case "APP_PAGE":
//            switch currentBannerDTO.content {
//            case "INSERT_STORE":
//                self.goToRegisterPlaceView()
//            case "DEAL_TAB":
//                self.goToPerfectDealView()
//            case "Attendance":
//                self.goToAttendanceView()
//            default:
//                break
//            }
//        case "NOTICE":
//            let noticeSn = currentBannerDTO.content
//            self.goToNoticeView(noticeSn: noticeSn)
//        case "WEB":
//            let urlStr = currentBannerDTO.content
//            let url = URL(string: urlStr)
//            let safariViewController = SFSafariViewController(url: url!)
//            safariViewController.modalPresentationStyle = .popover
//
//            self.present(safariViewController, animated: true, completion: nil)
//        default:
//            break
//        }
//    }
//
//    @objc func tapPlaceRegisterView(_ sender: UITapGestureRecognizer) {
//        self.goToRegisterPlaceView()
//    }
//
//    @objc func requestBlogInfo(_ sender: UIGestureRecognizer) {
//        let blogSn = String((sender.view as! BlogSimpleCard).blogDTO.blogSn ?? 0)
//        PerfectDayAPI.shared.requestBlogInfo(blogSn: blogSn) { (blogDTO, error) in
//            if let blogDTO = blogDTO {
//                self.goToBlogInfoView(blogDTO: blogDTO)
//            } else if let error = error {
//                self.alertAPIError(error)
//            }
//        }
//    }
//
//    @objc func requestCouponInfo(_ sender: UIGestureRecognizer) {
//        let couponSn = String((sender.view as! CouponSimpleCard).couponDTO.couponSn ?? 0)
//        PerfectDayAPI.shared.requestCouponInfo(couponSn: couponSn) { (couponDTO, error) in
//            if let couponDTO = couponDTO {
//                self.goToCouponDetailView(couponDTO: couponDTO)
//            } else if let error = error {
//                self.alertAPIError(error)
//            }
//        }
//    }
//
//    // MARK: - Delegates And DataSources
//
//    // MARK: - Life Cycles
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationController?.navigationBar.tintColor = .black
//
//        self.setFirebaseToken()
//        self.setAttributeOfTopView()
//        self.setAttributePopUpView()
//
//        self.checkKakaoShareUrl()
//        self.createNoticeDTOObservable()
//
//        self.checkPushNotiData()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.setAttributeOfView()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//        self.getNotificationCount()
//    }
//}
//
//extension HomeViewController: ImageSlideshowDelegate {
//
//}
//
//extension LabelPageIndicator {
//    public func setCustomLabel() {
//        self.textColor = .white
//        let systemFont = UIFont.systemFont(ofSize: 12.0)
//        self.attributedText = NSAttributedString(string: self.text ?? "",
//                                                 attributes: [NSAttributedString.Key.font : systemFont])
//    }
//
//    public override func sizeToFit() {
//        let maximumString = String(repeating: "16", count: numberOfPages) as NSString
//        self.frame.size = maximumString.size(withAttributes: [.font: font as Any])
//        setCustomLabel()
//    }
//}

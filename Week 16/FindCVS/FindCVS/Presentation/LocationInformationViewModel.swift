//
//  LocationInformationViewModel.swift
//  FindCVS
//
//  Created by 이재웅 on 2022/02/10.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    //viewModel -> view
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    
    //view -> viewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    
    init() {
        //MARK: 지도 중심점 설정
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                currentLocation.take(1),
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        errorMessage = mapViewError.asObservable()
            .asSignal(onErrorJustReturn: "잠시 후 다시 시도해주세요.")
    }
}

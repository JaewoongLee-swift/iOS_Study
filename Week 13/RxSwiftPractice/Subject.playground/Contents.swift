import RxSwift

let disposeBag = DisposeBag()

print("-------publishSubject-------")
let publishSubject = PublishSubject<String>()

publishSubject.onNext("1. 여러분 안녕하세욤")

let 구독자1 = publishSubject
    .subscribe(onNext: {
        print("첫번째 구독자: \($0)")
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.on(.next("3. 안들리시나용?"))

구독자1.dispose()

let 구독자2 = publishSubject
    .subscribe(onNext: {
        print("두번째 구독자: \($0)")
    })

publishSubject.onNext("4. 여보세요!!")
publishSubject.onCompleted()

publishSubject.onNext("5. 끝입니다.")

구독자2.dispose()
// 구독자1은 1번이벤트가 방출된 다음 구독을 하였기 때문에 2,3번 이벤트만 가능하였고 이후 dispose됨
// 구독자2는 3번이벤트가 방출된 다음 구독을 하였기 때문에 4번 이벤트가 가능했는데 4번 이후 publishSubject가 completed되었기 때문에 5번을 받을 수 없음

publishSubject
    .subscribe {
        print("세번째 구독:", $0.element ?? $0)
    }
    .disposed(by: disposeBag)

publishSubject.onNext("6. 찍힐것인지 확인")
// 세번째 구독은 당연히 찍히지 않음. 바라보는 subject가 이미 completed되었기 때문.
// completed 이후에 구독을 하고, onNext를 하였다고 해서 그 다음걸 받을 수는 없음.

print("-------behaviorSubject-------")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "초기값")

behaviorSubject.onNext("1. 첫번째값")

behaviorSubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

//behaviorSubject.onError(SubjectError.error1)  // value값 예시를 위해 주석처리

behaviorSubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)
// 첫번째 구독자는 1번값이 방출된 직후에 구독을 하였지만 behaviorSubject는 구독자가 직전에 방출된 값을 받을 수 있음. 다만 초기값은 못 얻는 모습.
// 자신이 구독한 시점 이후에 에러가 발생되어서 에러도 잘 받음
// 두번째 구독자는 구독을 한 시점 이후엔 아무런 이벤트가 발생하지 않음. 하지만 에러를 받고 있음. 구독 직전에 발생했던 이벤트이기 때문에 에러를 받을 수 있음.

// behaviorSubject의 장점은 어떠한 형태로 값을 받을 수 있다는 것
// Observable은 구독한 내에서 , onNext클로저 내에서만 값을 가지고 이용할 수 있음. 하지만 behaviorSubject는 값을 꺼내볼 수 있음.

let value = try? behaviorSubject.value()        // try문을 이용해서 value값을 꺼낼 수 있음.
print(value)
// 아직 종료되지 않았기 때문에 가장 최신의 onNext값을 Value로 꺼내줌.

// behaviorSubject에서 값을 뽑아낼 수 있는 value라는 throw가 있는데 Rx에선 잘 사용하지 않음. 있다 정도만 알고 넘어가도 될듯.

print("-------ReplaySubject-------")
// replaySubject는 선언, 초기화가 아닌 create로 만들어줘야함
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject.subscribe {
    print("첫번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.subscribe {
    print("두번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

replaySubject.onNext("4. 할 수 있어요")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("세번째 구독:", $0.element ?? $0)
}
.disposed(by: disposeBag)

//첫번째, 두번째 구독자 모두 같은 시점에 구독을 시작했기때문에 bufferSize 2만큼 구독 전에 2개의 이벤트를 받음. 마지막 에러까지도 잘 받음
//세번째 구독자는 에러를 받긴 받았는데 우리가 만든 에러가 아닌 RxSwift에서 만든 에러임. 이미 dispose했는데 구독을 하니까 발생시킨 에러.

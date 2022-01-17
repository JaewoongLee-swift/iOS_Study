import RxSwift

let disposeBag = DisposeBag()

print("--------ignoreElements--------")
let 취침모드😪 = PublishSubject<String>()

취침모드😪
    .ignoreElements()
    .subscribe { _ in
        print("☀️")
    }
    .disposed(by: disposeBag)

취침모드😪.onNext("🔈")
취침모드😪.onNext("🔈")
취침모드😪.onNext("🔈")

//ignoreElement는 nextElement를 무시하는 녀석임

취침모드😪.onCompleted()
// onNext는 무시하나 onCompleted는 받음

print("--------elemnetAt--------")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

두번울면깨는사람.onNext("🔈")
두번울면깨는사람.onNext("🔈")
두번울면깨는사람.onNext("😳")
두번울면깨는사람.onNext("🔈")

// element(at:)은 해당 인덱스의 값만 방출함

print("--------filter--------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)   //[1, 2, 3, 4, 5, 6, 7, 8] 순서대로 방출하게 될것
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// filter 내에 조건에 대해 true에 해당하는 경우의 엘레멘트만 방출하게 됨
// filter는 클로저 구문 내에 요청사항에 맞는 엘레멘트 값만 방출하게 만들 수 있음

print("--------skip--------")
Observable.of("😡", "🥶", "😐", "🤢", "👿", "👽", "🤡")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// skip에 표현한 Count(5)만큼 무시하고 그 다음 값을 방출함

print("--------skipWhile--------")
Observable.of("😡", "🥶", "😐", "🤢", "👿", "👽", "🤡", "👁", "🧠", "👮‍♀️", "🧕🏽")
    .skip(while: {
        $0 != "👽"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// skip, skipWhile 연산자는 어떠한 값이 나올때 까지 스킵하고 그 이후는 스킵하지 않는 연산자
// skipWhile은 skip할 로직을 구성하고 해당 로직이 False가 되었을 때 부터 방출함

print("--------skipUntil--------")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님  // 현재 Observable
    .skip(until: 문여는시간) // 다른 Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손님.onNext("😡")
손님.onNext("🥶")
손님.onNext("🤢")

문여는시간.onNext("땡!")
손님.onNext("👿")

// 이전의 onNext는 방출하지 않다가 '문여는시간'의 onNext가 전달된 후의 '손님'은 onNext를 방출하기 시작함
// 현재의 Observable이 값을 방출하더라도 다른 until의 Observable이 방출하지 않으면 값을 내보내지 못함

print("--------take--------")
Observable.of("🥇", "🥈", "🥉", "😡", "🥶")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// take(3)은 처음부터 3개만 출력되고 다음은 출력되지 않음. skip과 반대되는 개념. skip이였다면 3개가 무시되고 다음부터 나왔을것

print("--------takeWhile--------")
Observable.of("🥇", "🥈", "🥉", "😡", "🥶")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// takeWhile은 정확히 skipWhile과는 반대되게 true가 방출되면 onNext 이벤트를 방출함.

print("--------enumerated--------")
Observable.of("🥇", "🥈", "🥉", "😡", "🥶")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// index가 3 미만일때까지 방출함. 기존엔 element만 방출했다면 enumerated()는 index도 같이 방출함.
// 따라서 enumerated는 방출된 요소의 index를 참고하고 싶을 때 사용 가능. 방출된 요소의 튜플을 생성하게 됨

print("--------takeUntil--------")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

수강신청.onNext("🙆‍♀️")
수강신청.onNext("🙆")

신청마감.onNext("끝!")
수강신청.onNext("🙆🏻‍♂️")

// takeUntil은 다른 until의 Observable이 element가 구독되기 전까지의 값만 받게됨

print("--------distinctUntilChanged--------")
Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "입니다", "입니다", "입니다", "입니다", "저는", "앵무새", "일까요?", "일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 여러번 같은 말을 반복했음에도 불구하고 반복되는 말들은 모두 제거가됨. 단, 연속해서 같은 값일때만 중복되는 것을 막아줌.

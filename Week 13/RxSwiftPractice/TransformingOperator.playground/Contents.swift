import RxSwift

let disposeBag = DisposeBag()

print("--------toArray--------")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposeBag)

// Observable의 독립적인 요소들을 array형태의 Single로 만들어줌.

print("--------map--------")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--------flatMap--------")
// 예를들어, 마치 [[String]]처럼 Observable<Observable<String>>과 같은 상황에선 어떻게 사용할까?
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 🇰🇷국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 🇺🇸국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<선수>()    // '올림픽경기'는 '선수'타입을 가지는 Observable이기 때문에 중첩된 Observable이라는 것을 알 수 있음

올림픽경기
    .flatMap { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

올림픽경기.onNext(🇰🇷국가대표)
🇰🇷국가대표.점수.onNext(10)

올림픽경기.onNext(🇺🇸국가대표)
🇰🇷국가대표.점수.onNext(10)
🇺🇸국가대표.점수.onNext(9)

// 올림픽경기의 PublishObservable, 선수가 가지는 점수 BehaviorObservable이 중첩되어 있음. flatMap을 통해 꺼내어서 사용할 수 있음.

print("--------flatMapLatest--------")
struct 높이뛰기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 제주 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

전국체전.onNext(서울)
서울.점수.onNext(9)
서울.점수.onNext(11)

전국체전.onNext(제주)
서울.점수.onNext(10)
제주.점수.onNext(8)

// 서울선수의 점수 Sequence를 가장 최신의 값으로 갱신하고 내뱉은 뒤 구독해제함. 서울이 전국체전의 sequence일 땐 점수가 갱신되면 값을 내뱉지만
// 제주선수로 전국체전의 sequence가 갱신되면 서울선수는 구독해제되어 점수반영이 안됨.
// flatMapLatest는 네트워킹 조작에서 가장 흔하게 사용됨.
// 사전으로 단어를 찾을때, s-w-i-f-t를 입력하면 새 검색을 실행하면서 새로운 검색값을 나타내는데 사용됨.

print("--------materialize and dematerialize--------")
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리기100m = BehaviorSubject<선수>(value: 토끼)

달리기100m
    .flatMapLatest { 선수 in
        선수.점수
            .materialize()
    }
    .filter {
        guard let error = $0.error else { return true }
        print(error)
        return false
    }
    .dematerialize()
    .subscribe(onNext:{
        print($0)
    })
    .disposed(by: disposeBag)

토끼.점수.onNext(1)
토끼.점수.onError(반칙.부정출발)
토끼.점수.onNext(2)

달리기100m.onNext(치타)

// materialize 전엔 에러발생 이후로 어떠한 응답도 받지 않음. flatMapLatest에 materialize를 넣어주면?
// materialize()를 해주면 값과 그에 대한 이벤트를 같이 전달해줌. 자연스럽게 이벤트와 이벤트가 가지고 있는 element를 포함해서 보내줌.
// dematerialize()는 materialize를 통해서 포함되서 보내진 이벤트를 원래의 값으로 변형시켜줌.

print("--------전화번호 11자리--------")
let input = PublishSubject<Int?>()

let list: [Int] = [1]

input
    .flatMap {                  // nil이면 빈 Observable을 내보내고 아니면 그 element를 내보냄
        $0 == nil
        ? Observable.empty()
        : Observable.just($0)
    }
    .map { $0! }                // 옵셔널값이 나올거라 강제언래핑해줌
    .skip(while: { $0 != 0 })   // 0이 나오기 전엔 스킵(전화번호는 0으로 시작하니까)
    .take(11)                   // 010-1111-2222 << 11자리임
    .toArray()                  // array로 묶어줌
    .asObservable()             // toArray는 Single로 만들어지니까 다시 Observable로 변환
    .map {                      // array내의 값(Int)을 String으로 변환
        $0.map { "\($0)"}
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)   // 010- << 3번째 index에 - 들어감
        numberList.insert("-", at: 8)   // 010-1234- << 8번째 index에 - 들어감
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(1)

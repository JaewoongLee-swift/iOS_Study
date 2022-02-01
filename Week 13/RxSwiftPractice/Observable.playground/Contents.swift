import UIKit
import RxSwift

//Just는 단 하나의 엘레멘트만 방출하는 Operator
print("----Just----")
Observable<Int>.just(1)
    .subscribe(onNext: {
            print($0)
    })


//Of는 여러개의 엘레멘트(이벤트?)를 방출하는 Operator
print("----Of1----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

//Array 전체를 of연산자 안에 넣으면 하나의 array를 내뿜는 Observable이 완성됨(just 연산자를 쓴것과 동일해짐)
//여러개의 Element를 내보내고 싶을 경우엔 Array 형태로 내보내면 안됨.(쉼표로만 구분해서 넣어줘야함)
print("----Of2----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

//From은 Array형태만 받음. Of와 달리 Array형태 내에 있는 element들을 하나씩 방출함
print("----From----")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// Observable이 어떠한 이벤트를 내보낸다는 것은 어떻게 알까?
//Observable는 실제로는 sequence 정의일 뿐임. subscribe 되기 전에는 어떠한 이벤트도 내보내지 않는 정의일 뿐임.
//실제로 잘 작동하는지 확인하기 위해선 반드시 subscribe 해야함

print("--------subscribe1--------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
// 어떠한 이벤트를 입력해주지 않았으므로 next(1)과 같이 어떠한 이벤트에 어떠한 값이 싸여저 있고, 마지막에 completed 되었다고 나타냄

print("--------subscribe2--------")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }
// 전달받은 element 값을 프린트하게됨

print("--------subscribe3--------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("-------empty--------")
Observable.empty()
    .subscribe {
        print($0)
    }
// element도 없고 아무런 이벤트도 없는 observable을 만들때 empty를 사용

print("-------empty2--------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

print("-------empty3--------")
// empty2는 다음과 동일하다고 볼 수 있음
Observable<Void>.empty()
    .subscribe(onNext: {
        
    },
    onCompleted: {
        print("completed")
    })

//empty에는 타입이 없기 때문에 타입추론을 할 수 없어 어떠한 이벤트도 발생하지 않음. 하지만 Void를 하였을 경우 completed는 발생
//그렇담 Void의 빈 Observable은 어디에 사용할까?
//즉시 종료할 수 있는 Observable을 리턴하고 싶을 때, 또는 의도적으로 0개의 값을 가지는 Observable을 리턴하고 싶을 때 사용 가능

print("--------never--------")
Observable<Void>.never()
    .subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("completed")
    })
// 이렇게 하면 completed조차도 표현되지 않음. 타입추론을 해주기 위해 <Void>를 넣어도 아무것도 나타나지 않음.
// 그렇담 제대로 작동하는지 어떻게 확인할까? 바로 .debug를 이용해서 확인

print("--------never2--------")
Observable.never()
    .debug("안녕")
    .subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("completed")
    })
// 이렇게 하면 never가 subscribe 되었다고 알려줌. 이렇게 아무런 이벤트를 내뱉지 않는 것이 never 연산자.

print("--------range--------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2*\($0)=\(2*$0)")
    })
//start값부터 count값까지 하나씩 늘려가면서 내보냄

//Observable은 subscribe되기 전까진 어떠한 이벤트도 발생하지 않음. subscribe가 일종의 방아쇠 역할. 그렇다면 subscribe를 다시 취소할 수 있지 않을까?
// dispose는 subscribe된 것을 취소하여 종료시키는 역할

print("--------dispose--------")
Observable.of(1, 2, 3)  //Observable 생성
    .subscribe(onNext: {    //subscribe를 통해 이벤트 생성
        print($0)
    })
    .dispose()          //dispose 후에는 이벤트 방출 안됨

// 코드 상으로는 티가 나지 않지만 무한한 element가 있을 경우에는 반드시 dispose를 해야 이벤트가 종료됨
// 메모리누수를 위해 항상 dispose 해주어야함. 일종의 생명주기

print("--------disposeBag--------")
let disposeBag = DisposeBag()

Observable.of(1, 2, 3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

//disposeBag은 disposable을 가지고 있음(타입 자체가 그러함). 따라서 disposable은 disposaBag이 할당해제 하려 할 때마다 이 dispose를 호출하게 됨
// 코드를 보면 disposeBag을 선언하고 Obsevable을 선언함. 그리고 발생하는 이벤트를 print하고, subscribe로부터 방출된 return값을 disposeBag에 추가하는것
//disposeBag은 잘 가지고 있다가 할당해제 할 때 모든 subscribe에 대해 dispose를 날리는 것
// - 어떻게 보면 subscribe할 때마다 할당하는것 같아서 불편해 보이는데 왜 이렇게 하는 것일까?
// 만일 disposeBag을 호출하거나 dispose하는 것을 까먹게 되면 일단 메모리 누수가 일어남(Observable이 끝나지 않기 때문). 따라서 매번 observable을 만들고 disposeBag을 만드는게 무조건 필요함.

print("--------create1--------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
//    observer.on(.next(1)) 위와 동일한 코드
    observer.onCompleted()
//    observer.on(.completed)
    observer.onNext(2)
//    observer.on(.next(2)) 이 이벤트는 방출되지 않음.
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)
// create는 escaping 클로저. 1 만 방출되고 2는 방출되지 않음. onCompleted되어 observable이 종료되었기 때문. 종료된 다음에 아무리 next이벤트를 날려도 두번째 onNext는 방출되지 않음

print("--------create2--------")
enum MyError: Error {
    case anError
}

Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print("에러발생 : \($0.localizedDescription)")
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed!")
    }
)
.disposed(by: disposeBag)

// completed까지 가지 않고 Error에서 observable이 종료되었음. error이후는 방출되지 않음.

//만일 error, completed, disposeBag에도 추가하지 않고 구독만 한다면 어떻게 될까?
print("--------create3--------")
Observable<Int>.create { observer -> Disposable in
    observer.onNext(1)
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
//이렇게 되면 당연히 1, 2 모두 찍히고 종료가 아무것도 되지 않고(Completed, Error) Disposed도 되지 않기 때문에 결과적으로 메모리 누수가 발생하게 될것.
//따라서 반드시 disposed 코드를 넣어줘야 할 것임

print("------deferred1------")
//subscribe를 기다리는 Observable를 만드는 대신에 각 subscribe들에게 새롭게 observable항목을 제공하는 observable Factory 방식
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

print("------deferred2------")
var 뒤집기: Bool = false

let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("👍")
    } else {
        return Observable.of("👎")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
        .disposed(by: disposeBag)
}
// 뒤집기에 따라서 deferred내에(Factory내에) 있는 Observable묶음 중에서 조건문에 따라 나올 수 있음
// Observable deferred로는 Observable Factory를 통해서 Observable sequence를 생성할 수 있는 연산자

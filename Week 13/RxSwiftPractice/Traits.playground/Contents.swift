import RxSwift
import Dispatch

let disposeBag = DisposeBag()

enum TraitsError: Error {
    case single
    case maybe
    case completable
}

print("-------Single1-------")
Single<String>.just("✅")
    .subscribe(
        // single은 next와 completed가 합쳐져 있는 것을 볼 수 있음
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0.localizedDescription)")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)

print("-------Single2-------")
Observable<String>.just("✅")
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0.localizedDescription)")
        },
        onDisposed: {
            print("disposed")
        }
    )
.disposed(by: disposeBag)

print("-------Single3-------")
Observable<String>
    .create { observer -> Disposable in
    observer.onError(TraitsError.single)
    return Disposables.create()
}
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("error: \($0.localizedDescription)")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)
// Single의 오류를 발생함


print("-------Single4-------")
//네트워크 환경(json을 주고받는 환경)에서 성공/실패로 사용할 때
struct SomeJSON: Decodable {
    let name: String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
    {"name":"park"}
    """

let json2 = """
    {"my_name":"young"}
    """

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data)
        else {
            // 실패했을때 observer에 failure를 담아 보냄
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        
        //성공했을 때 success를 담아 보냄
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
// 아무일도 일어나지 않음. Single sequence를 만들었을 뿐이지 구독을 하지 않아 아무일도 일어나지 않음.
decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)
// 디코딩 잘 된것을 확인!

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: disposeBag)
//에러가 남. 잘못됨 key값이 들어왔기 때문에 디코딩에러가 발생함.

// 단순하게 하나의 이벤트를 발생시키고 observerble이 종료되는 Single


//Maybe도 유사하지만 아무것도 발생하지 않는 Completed클로저가 있는것 뿐
print("------Maybe1------")
Maybe<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onError: {
            print($0)
        },
        onCompleted: {
            print("completed")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: disposeBag)

print("------Maybe2------")
Observable<String>.create { observer -> Disposable in
    observer.onError(TraitsError.maybe)
    return Disposables.create()
}
.asMaybe()
.subscribe(
    onSuccess: {
        print("성공: \($0)")
    },
    onError: {
        print("에러: \($0)")
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)


//Completable은 asSingle, asMaybe와 같은것이 없음
print("------Completable1------")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    return Disposables.create()
}
.subscribe(
    onCompleted: {
        print("completed")
    },
    onError: {
        print("error: \($0)")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: disposeBag)

print("------Completable2------")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: disposeBag)

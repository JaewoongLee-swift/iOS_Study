import RxSwift

let disposeBag = DisposeBag()

print("--------ignoreElements--------")
let ์ทจ์นจ๋ชจ๋๐ช = PublishSubject<String>()

์ทจ์นจ๋ชจ๋๐ช
    .ignoreElements()
    .subscribe { _ in
        print("โ๏ธ")
    }
    .disposed(by: disposeBag)

์ทจ์นจ๋ชจ๋๐ช.onNext("๐")
์ทจ์นจ๋ชจ๋๐ช.onNext("๐")
์ทจ์นจ๋ชจ๋๐ช.onNext("๐")

//ignoreElement๋ nextElement๋ฅผ ๋ฌด์ํ๋ ๋์์

์ทจ์นจ๋ชจ๋๐ช.onCompleted()
// onNext๋ ๋ฌด์ํ๋ onCompleted๋ ๋ฐ์

print("--------elemnetAt--------")
let ๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋ = PublishSubject<String>()

๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋.onNext("๐")
๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋.onNext("๐")
๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋.onNext("๐ณ")
๋๋ฒ์ธ๋ฉด๊นจ๋์ฌ๋.onNext("๐")

// element(at:)์ ํด๋น ์ธ๋ฑ์ค์ ๊ฐ๋ง ๋ฐฉ์ถํจ

print("--------filter--------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)   //[1, 2, 3, 4, 5, 6, 7, 8] ์์๋๋ก ๋ฐฉ์ถํ๊ฒ ๋ ๊ฒ
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// filter ๋ด์ ์กฐ๊ฑด์ ๋ํด true์ ํด๋นํ๋ ๊ฒฝ์ฐ์ ์๋ ๋ฉํธ๋ง ๋ฐฉ์ถํ๊ฒ ๋จ
// filter๋ ํด๋ก์  ๊ตฌ๋ฌธ ๋ด์ ์์ฒญ์ฌํญ์ ๋ง๋ ์๋ ๋ฉํธ ๊ฐ๋ง ๋ฐฉ์ถํ๊ฒ ๋ง๋ค ์ ์์

print("--------skip--------")
Observable.of("๐ก", "๐ฅถ", "๐", "๐คข", "๐ฟ", "๐ฝ", "๐คก")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// skip์ ํํํ Count(5)๋งํผ ๋ฌด์ํ๊ณ  ๊ทธ ๋ค์ ๊ฐ์ ๋ฐฉ์ถํจ

print("--------skipWhile--------")
Observable.of("๐ก", "๐ฅถ", "๐", "๐คข", "๐ฟ", "๐ฝ", "๐คก", "๐", "๐ง ", "๐ฎโโ๏ธ", "๐ง๐ฝ")
    .skip(while: {
        $0 != "๐ฝ"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// skip, skipWhile ์ฐ์ฐ์๋ ์ด๋ ํ ๊ฐ์ด ๋์ฌ๋ ๊น์ง ์คํตํ๊ณ  ๊ทธ ์ดํ๋ ์คํตํ์ง ์๋ ์ฐ์ฐ์
// skipWhile์ skipํ  ๋ก์ง์ ๊ตฌ์ฑํ๊ณ  ํด๋น ๋ก์ง์ด False๊ฐ ๋์์ ๋ ๋ถํฐ ๋ฐฉ์ถํจ

print("--------skipUntil--------")
let ์๋ = PublishSubject<String>()
let ๋ฌธ์ฌ๋์๊ฐ = PublishSubject<String>()

์๋  // ํ์ฌ Observable
    .skip(until: ๋ฌธ์ฌ๋์๊ฐ) // ๋ค๋ฅธ Observable
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

์๋.onNext("๐ก")
์๋.onNext("๐ฅถ")
์๋.onNext("๐คข")

๋ฌธ์ฌ๋์๊ฐ.onNext("๋ก!")
์๋.onNext("๐ฟ")

// ์ด์ ์ onNext๋ ๋ฐฉ์ถํ์ง ์๋ค๊ฐ '๋ฌธ์ฌ๋์๊ฐ'์ onNext๊ฐ ์ ๋ฌ๋ ํ์ '์๋'์ onNext๋ฅผ ๋ฐฉ์ถํ๊ธฐ ์์ํจ
// ํ์ฌ์ Observable์ด ๊ฐ์ ๋ฐฉ์ถํ๋๋ผ๋ ๋ค๋ฅธ until์ Observable์ด ๋ฐฉ์ถํ์ง ์์ผ๋ฉด ๊ฐ์ ๋ด๋ณด๋ด์ง ๋ชปํจ

print("--------take--------")
Observable.of("๐ฅ", "๐ฅ", "๐ฅ", "๐ก", "๐ฅถ")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// take(3)์ ์ฒ์๋ถํฐ 3๊ฐ๋ง ์ถ๋ ฅ๋๊ณ  ๋ค์์ ์ถ๋ ฅ๋์ง ์์. skip๊ณผ ๋ฐ๋๋๋ ๊ฐ๋. skip์ด์๋ค๋ฉด 3๊ฐ๊ฐ ๋ฌด์๋๊ณ  ๋ค์๋ถํฐ ๋์์๊ฒ

print("--------takeWhile--------")
Observable.of("๐ฅ", "๐ฅ", "๐ฅ", "๐ก", "๐ฅถ")
    .take(while: {
        $0 != "๐ฅ"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// takeWhile์ ์ ํํ skipWhile๊ณผ๋ ๋ฐ๋๋๊ฒ true๊ฐ ๋ฐฉ์ถ๋๋ฉด onNext ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํจ.

print("--------enumerated--------")
Observable.of("๐ฅ", "๐ฅ", "๐ฅ", "๐ก", "๐ฅถ")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// index๊ฐ 3 ๋ฏธ๋ง์ผ๋๊น์ง ๋ฐฉ์ถํจ. ๊ธฐ์กด์ element๋ง ๋ฐฉ์ถํ๋ค๋ฉด enumerated()๋ index๋ ๊ฐ์ด ๋ฐฉ์ถํจ.
// ๋ฐ๋ผ์ enumerated๋ ๋ฐฉ์ถ๋ ์์์ index๋ฅผ ์ฐธ๊ณ ํ๊ณ  ์ถ์ ๋ ์ฌ์ฉ ๊ฐ๋ฅ. ๋ฐฉ์ถ๋ ์์์ ํํ์ ์์ฑํ๊ฒ ๋จ

print("--------takeUntil--------")
let ์๊ฐ์ ์ฒญ = PublishSubject<String>()
let ์ ์ฒญ๋ง๊ฐ = PublishSubject<String>()

์๊ฐ์ ์ฒญ
    .take(until: ์ ์ฒญ๋ง๊ฐ)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

์๊ฐ์ ์ฒญ.onNext("๐โโ๏ธ")
์๊ฐ์ ์ฒญ.onNext("๐")

์ ์ฒญ๋ง๊ฐ.onNext("๋!")
์๊ฐ์ ์ฒญ.onNext("๐๐ปโโ๏ธ")

// takeUntil์ ๋ค๋ฅธ until์ Observable์ด element๊ฐ ๊ตฌ๋๋๊ธฐ ์ ๊น์ง์ ๊ฐ๋ง ๋ฐ๊ฒ๋จ

print("--------distinctUntilChanged--------")
Observable.of("์ ๋", "์ ๋", "์ต๋ฌด์", "์ต๋ฌด์", "์ต๋ฌด์", "์๋๋ค", "์๋๋ค", "์๋๋ค", "์๋๋ค", "์ ๋", "์ต๋ฌด์", "์ผ๊น์?", "์ผ๊น์?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// ์ฌ๋ฌ๋ฒ ๊ฐ์ ๋ง์ ๋ฐ๋ณตํ์์๋ ๋ถ๊ตฌํ๊ณ  ๋ฐ๋ณต๋๋ ๋ง๋ค์ ๋ชจ๋ ์ ๊ฑฐ๊ฐ๋จ. ๋จ, ์ฐ์ํด์ ๊ฐ์ ๊ฐ์ผ๋๋ง ์ค๋ณต๋๋ ๊ฒ์ ๋ง์์ค.

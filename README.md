# CJ-NaverAPI-Example

## 참고 포스팅
- [Swift 기반 Naver 지도 API 사용법](https://blog.naver.com/PostView.naver?blogId=soojin_2604&logNo=222402500216&parentCategoryNo=&categoryNo=39&viewDate=&isShowPopularPosts=true&from=search)

## Requirement
- Simulator: iPhone 13 Pro
- `clone` 후 `CJ-NaverAPI-Example.xcworkspace`로 개발
- pod에 'NMapsMap'와 'SnapKit' 설치되어 있음
- `SnapKit`과 `UIKit` 으로 UI 제작
- `git-lfs` 설치
- `Info.plist`에 정보 등록 후 

## Naver Cloud Flatform 등록
- [Naver Cloud Flatfrom](https://www.ncloud.com/product/applicationService/maps) 접속 후 이용신청
- `Services` > `AI Naver API` > `결제 방식 선택`
- 회원정보 전화번호 인증할 때 오류 있음 > 전화번호 010xxxxxxxx을 10xxxxxxxx 으로 변경 후 진행
- 결제 수단 등록
- `Services` > `AI Naver API` > 'Application 등록` > `Mobile Dynamic Map`
- iOS Bundle id 입력 `wonjune.CJ-NaverAPI-Example`

## 주의사항
- 반드시 `branch` 생성 후 작업 할 것
- `main`에 `push` 및 `PR` 금지

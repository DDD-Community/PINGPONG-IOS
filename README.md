# PINGPONG-IOS
About DDD 9기 IOS 3팀 IOS



## Tuist Usage
1. Install tuist
 
```swift
curl -Ls https://install.tuist.io | bash 
```
2. Generate project

```swift
tuist clean // optional
tuist fetch // optional
tuist generate
```

## 🌟 Team
|Team mentor|Developer|Designer|Designer|Developer|Developer|
|:---:|:---:|:---:|:---:|:---:|:---:|
|<a href="https://github.com/"><img height="130px" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/b2e9feaa-faf6-450d-9fad-753fe086d1d5"/></a>| <a href="https://github.com/Hyesooo"><img height="130px" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/bc02ac38-c9fe-4122-bed8-e1fbfb588567"/></a>|<a href=""><img height="130px" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/41bc501c-a144-4886-95c8-2d9fcc5815f2"/></a>|<a href=""><img height="130px" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/f0bf90cf-5464-45db-9362-ec3f2fa3411b"/></a>|<a href="https://github.com/Byeonjinha"><img height="130" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/8874c20c-06d4-4ea2-b069-29a32bbd8e4b"/></a>|<a href="https://github.com/Roy-wonj"><img height="130" width="130px" src="https://github.com/DDD-Community/PINGPONG-IOS/assets/87685946/07d3fa91-c702-4204-b0e9-00b554870675"/></a>|
|<a href="https://github.com/DDD-Community">안예지</a>|<a href="https://github.com/Hyesooo">김혜수</a>|<a href="">남윤지</a>|<a href="">박주미</a>|<a href="https://github.com/Byeonjinha">변진하</a>|<a href="https://github.com/Roy-wonji">서원지</a>|

## 기술 스택 
- iOS  
  <img src="https://img.shields.io/badge/fastlane-00F200?style=for-the-badge&logo=fastlane&logoColor=white">
  <img src="https://img.shields.io/badge/swift-F05138?style=for-the-badge&logo=swift&logoColor=white">
  <img src="https://img.shields.io/badge/xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white">  
  Tuist, WidgetKit, SwiftUI

- Server  
  <img src="https://img.shields.io/badge/amazonec2-FF9900?style=for-the-badge&logo=amazonec2&logoColor=white">
  <img src="https://img.shields.io/badge/amazonaws-232F3E?style=for-the-badge&logo=amazonaws&logoColor=white">
  <img src="https://img.shields.io/badge/swagger-85EA2D?style=for-the-badge&logo=swagger&logoColor=white">  
  Java
- Design  
  <img src="https://img.shields.io/badge/figma-F24E1E?style=for-the-badge&logo=figma&logoColor=white">
  <img src="https://img.shields.io/badge/adobe-FF0000?style=for-the-badge&logo=adobe&logoColor=white">
  <img src="https://img.shields.io/badge/adobecreativecloud-DA1F26?style=for-the-badge&logo=adobecreativecloud&logoColor=white">


- Communication  
  <img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
  <img src="https://img.shields.io/badge/jira-0052CC?style=for-the-badge&logo=jira&logoColor=white">
  <img src="https://img.shields.io/badge/slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">
- VCS  
  <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"> 
  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white"> 

## 🐈‍⬛ Git

### 1️⃣ Git branching Strategy

- Origin(main branch)
- Origin(dev branch)
- Local(feature branch)

- Branch
- Main
- Dev
- Feature
- Fix

- 방법
- 1. Pull the **Dev** branch of the Origin
- 2. Make a **Feature** branch in the Local area
- 3. Developed by **Feature** branch
- 4. Push the **Feature** from Local to Origin
- 5. Send a pull request from the origin's **Feature** to the Origin's **Dev**
- 6. In Origin **Dev**, resolve conflict and merge
- 7. Fetch and rebase Origin **Dev** from Local **Dev**





## Commit 규칙
> 커밋 제목은 최대 50자 입력 </br>
본문은 한 줄 최대 72자 입력 </br>
Commit 메세지 </br>

🪛[chore]: 코드 수정, 내부 파일 수정. </br>
✨[feat]: 새로운 기능 구현. </br>
🎨[style]: 스타일 관련 기능.(코드의 구조/형태 개선) </br>
➕[add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가 </br>
🔧[file]: 새로운 파일 생성, 삭제 시 </br>
🐛[fix]: 버그, 오류 해결. </br>
🔥[del]: 쓸모없는 코드/파일 삭제. </br>
📝[docs]: README나 WIKI 등의 문서 개정. </br>
💄[mod]: storyboard 파일,UI 수정한 경우. </br>
✏️[correct]: 주로 문법의 오류나 타입의 변경, 이름 변경 등에 사용합니다. </br>
🚚[move]: 프로젝트 내 파일이나 코드(리소스)의 이동. </br>
⏪️[rename]: 파일 이름 변경이 있을 때 사용합니다. </br>
⚡️[improve]: 향상이 있을 때 사용합니다. </br>
♻️[refactor]: 전면 수정이 있을 때 사용합니다. </br>
🔀[merge]: 다른브렌치를 merge 할 때 사용합니다. </br>
✅ [test]: 테스트 코드를 작성할 때 사용합니다. </br>

<br>

### Commit Body 규칙
> 제목 끝에 마침표(.) 금지 </br>
한글로 작성 </br>
브랜치 이름 규칙

- `STEP1`, `STEP2`, `STEP3`

<br>

## Git flow
- `main` 브랜 치는 앱 출시 
- `Dev`는 테스트 및 각종 파일 merge
- 각 스텝 뱔로 브런치 생성해서 관리 


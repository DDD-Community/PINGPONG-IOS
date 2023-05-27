# PINGPONG-IOS
About DDD 9기 IOS 3팀 IOS


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


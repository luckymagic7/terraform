# terraform

## 개요
테라폼으로 AWS 인프라 구축 및 Nginx 를 가동한다.

## 사전 준비
- 개인 AWS 계정 필요
- IAM 사용을 위해 `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` 가 필요하다.
- 상기 값은 `절대로` 외부에 노출되면 안되니 환경변수 등으로 관리한다.
  - `export AWS_ACCESS_KEY_ID="keykeykey"`
- AWS 인스턴스에 접근하기 위한 ssh 키 직접 생성
  - `ssh-keygen -t rsa -b 4096 -f "$HOME/.ssh/web_admin" -N ""`
  - 상기 명령은 사용자의 홈 디렉토리의 `.ssh`안에 `web_admin`이라는 프라이빗 및 퍼블릭 키를 생성한다.

## 테라폼 실행
- 소스 코드를 다운받아 `terraform init` 실행
  - terraform 작동에 필요한 provider를 파악하고 필요한 플러그인들을 다운로드 한다.
- `exe.sh plan`으로 변경 될 사항들 체크
- `exe.sh apply`로 인프라 생성

## 접속 테스트
- 생성 완료 후, ALB의 DNS로 접근해서 Nginx 페이지가 뜨는지 확인한다.

## 삭제
- `exe.sh destroy` 명령으로 모든 리소스를 삭제한다.

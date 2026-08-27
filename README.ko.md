# Codex ChatGPT 브라우저 확장 프로그램 설치 도우미

[简体中文](README.md) | [繁體中文](README.zh-TW.md) | [English](README.en.md) | [日本語](README.ja.md) | [한국어](README.ko.md)

Chrome 웹 스토어의 지역 제한으로 확장 프로그램을 받을 수 없는 환경에서 Codex용 ChatGPT 브라우저 확장 프로그램(“Control your browser with ChatGPT”)을 로컬에 불러오기 위한 Windows 스크립트입니다.

## 배경

Codex의 브라우저 제어 기능은 “ChatGPT” 브라우저 확장 프로그램과 native messaging을 통해 통신합니다. 일부 지역에서는 Chrome 웹 스토어에 확장 프로그램이 표시되지 않아 Codex가 Chrome 브라우저 확장 프로그램을 감지하지 못할 수 있습니다.

Microsoft Edge와 같은 다른 브라우저에 확장 프로그램이 이미 설치되어 있다면 로컬 파일을 추출한 뒤 Chrome의 “압축해제된 확장 프로그램을 로드” 기능으로 사용할 수 있습니다.

## 주요 기능

- Edge／Chrome 프로필을 자동으로 검사하여 설치된 ChatGPT 브라우저 확장 프로그램 검색
- 최신 버전의 확장 프로그램 디렉터리를 추출하고 스토어 서명 메타데이터(`_metadata`) 제거
- manifest의 `key` 필드를 유지하여 Codex native messaging host와 확장 프로그램 ID의 일치 보장
- Chrome에서 로드할 수 있는 디렉터리와 명확한 안내 출력
- 확장 프로그램 바이너리를 포함하거나 재배포하지 않음

## 사용 방법

1. Microsoft Edge 등 지원 브라우저에 ChatGPT 브라우저 확장 프로그램이 설치되어 있는지 확인합니다.
2. PowerShell에서 실행합니다.

~~~powershell
.\install.ps1
~~~

출력 디렉터리를 지정하려면:

~~~powershell
.\install.ps1 -Destination "D:\codex-chatgpt-extension"
~~~

3. Chrome에서 `chrome://extensions`를 열고 “개발자 모드”를 켠 다음 “압축해제된 확장 프로그램을 로드”를 선택하여 출력 디렉터리를 지정합니다.
4. Codex → Settings → Computer use → Chrome browser extension으로 돌아가 감지되었는지 확인합니다.

## 제한 사항

- 사용자가 이미 설치했고 사용할 권한이 있는 확장 프로그램만 추출합니다.
- 확장 프로그램의 저작권은 OpenAI에 있습니다. 이 프로젝트는 로컬 추출 및 설치 절차만 제공합니다.
- 로그인, 유료 콘텐츠, 기타 접근 제어를 우회하지 않습니다.
- Chrome 웹 스토어, OpenAI 및 현지 법률과 규정을 준수해야 합니다.

## 저장소 구조

~~~text
codex-chatgpt-extension-installer/
├── install.ps1              # Windows용 추출 스크립트
├── README.md                # 简体中文说明
├── README.zh-TW.md          # 繁體中文說明
├── README.en.md             # English documentation
├── README.ja.md             # 日本語ドキュメント
├── README.ko.md             # 한국어 문서
└── .gitignore               # 추출된 확장 프로그램 디렉터리 제외
~~~

## 책임 고지

이 프로젝트는 확장 프로그램을 로컬에서 추출하고 설치하는 절차를 설명합니다. 확장 프로그램의 권리 귀속이나 재배포 권한을 변경하지 않습니다. 사용자는 자신의 사용 권한과 관련 약관을 직접 확인해야 합니다.

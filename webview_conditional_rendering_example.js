// 웹사이트에서 Flutter 웹뷰 식별 및 조건부 렌더링 예시

// Flutter 웹뷰 감지 함수
function isFlutterWebView() {
  return (
    window.isFlutterWebView === true ||
    window.flutterApp === true ||
    window.isMobileApp === true ||
    window.platform === "flutter" ||
    (typeof window.isFlutterWebView === "function" && window.isFlutterWebView())
  );
}

// 웹뷰 환경 감지
function detectWebViewEnvironment() {
  const isWebView = isFlutterWebView();
  const isMobile =
    /Android|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(
      navigator.userAgent
    );

  console.log("Environment detection:", {
    isFlutterWebView: isWebView,
    isMobile: isMobile,
    userAgent: navigator.userAgent,
  });

  return {
    isFlutterWebView: isWebView,
    isMobile: isMobile,
    shouldHideElements: isWebView,
  };
}

// 조건부 렌더링 함수
function applyConditionalRendering() {
  const env = detectWebViewEnvironment();

  if (env.shouldHideElements) {
    // Flutter 웹뷰에서 숨길 요소들
    const elementsToHide = [
      ".footer", // 푸터
      ".header-nav", // 헤더 네비게이션
      ".sidebar", // 사이드바
      ".ads", // 광고
      ".social-share", // 소셜 공유 버튼
      ".newsletter-signup", // 뉴스레터 가입
      ".related-posts", // 관련 게시물
      ".comments-section", // 댓글 섹션
      ".floating-cta", // 플로팅 CTA
      ".web-only", // 웹 전용 요소
    ];

    elementsToHide.forEach((selector) => {
      const elements = document.querySelectorAll(selector);
      elements.forEach((element) => {
        element.style.display = "none";
      });
    });

    // 모바일 앱에 맞는 스타일 적용
    document.body.classList.add("flutter-webview");
    document.body.classList.add("mobile-app");

    console.log("Applied Flutter WebView conditional rendering");
  }
}

// 페이지 로드 시 조건부 렌더링 적용
document.addEventListener("DOMContentLoaded", function () {
  // 즉시 적용
  applyConditionalRendering();

  // 약간의 지연 후 다시 확인 (동적 콘텐츠를 위해)
  setTimeout(applyConditionalRendering, 1000);
});

// 동적 콘텐츠 변경 감지 (MutationObserver 사용)
const observer = new MutationObserver(function (mutations) {
  mutations.forEach(function (mutation) {
    if (mutation.type === "childList" && mutation.addedNodes.length > 0) {
      // 새로운 요소가 추가되면 조건부 렌더링 다시 적용
      setTimeout(applyConditionalRendering, 100);
    }
  });
});

// DOM 변경 감지 시작
observer.observe(document.body, {
  childList: true,
  subtree: true,
});

// React 컴포넌트에서 사용할 수 있는 훅 예시
function useFlutterWebView() {
  const [isFlutterWebView, setIsFlutterWebView] = useState(false);

  useEffect(() => {
    const checkWebView = () => {
      const isWebView =
        window.isFlutterWebView === true ||
        window.flutterApp === true ||
        window.isMobileApp === true ||
        window.platform === "flutter";
      setIsFlutterWebView(isWebView);
    };

    checkWebView();

    // 주기적으로 확인 (웹뷰 로딩 지연을 위해)
    const interval = setInterval(checkWebView, 500);

    return () => clearInterval(interval);
  }, []);

  return isFlutterWebView;
}

// React 컴포넌트 예시
function ConditionalComponent({
  children,
  webOnly = false,
  mobileOnly = false,
}) {
  const isFlutterWebView = useFlutterWebView();

  if (webOnly && isFlutterWebView) {
    return null; // Flutter 웹뷰에서는 숨김
  }

  if (mobileOnly && !isFlutterWebView) {
    return null; // 웹에서만 표시
  }

  return children;
}

// 사용 예시:
// <ConditionalComponent webOnly>
//   <div>이 요소는 웹에서만 표시됩니다</div>
// </ConditionalComponent>
//
// <ConditionalComponent mobileOnly>
//   <div>이 요소는 Flutter 앱에서만 표시됩니다</div>
// </ConditionalComponent>

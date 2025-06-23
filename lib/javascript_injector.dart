class JavaScriptInjector {
  static String getInjectionCode() {
    return '''
      window.flutterFileUploaded = false;
      
      function interceptFileInput() {
        const fileInputs = document.querySelectorAll('input[type="file"]');
        fileInputs.forEach(function(input) {
          input.removeEventListener('click', handleFileClick);
          input.addEventListener('click', handleFileClick);
        });
      }
      
      function handleFileClick(e) {
        e.preventDefault();
        e.stopPropagation();
        window.FlutterFileUpload.postMessage('pickFile');
      }
      
      // "다시 분석하기" 버튼 클릭 감지
      function interceptResetButton() {
        // 기존 이벤트 리스너가 있는 버튼들을 찾아서 래핑
        const buttons = document.querySelectorAll('button');
        buttons.forEach(function(button) {
          if (button.textContent && button.textContent.includes('analyze')) {
            button.removeEventListener('click', handleResetClick);
            button.addEventListener('click', handleResetClick);
          }
        });
      }
      
      function handleResetClick(e) {
        window.flutterFileUploaded = false;
        setTimeout(() => {
          window.FlutterFileUpload.postMessage('resetComplete');
        }, 100);
      }
      
      // 웹뷰용 파일 설정 함수
      window.setFlutterFile = function(fileName, fileData, fileType) {
        
        const fileInput = document.querySelector('input[type="file"]#instagram-data');
        if (!fileInput) {
          return false;
        }
        
        try {
          const binaryString = atob(fileData);
          const bytes = new Uint8Array(binaryString.length);
          for (let i = 0; i < binaryString.length; i++) {
            bytes[i] = binaryString.charCodeAt(i);
          }
          
          const blob = new Blob([bytes], { type: fileType });
          const file = new File([blob], fileName, { type: fileType });
          
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(file);
          fileInput.files = dataTransfer.files;
          
          const changeEvent = new Event('change', { bubbles: true });
          fileInput.dispatchEvent(changeEvent);
          
          window.flutterFileUploaded = true;
          return true;
        } catch (error) {
          return false;
        }
      };
      
      const observer = new MutationObserver(function(mutations) {
        let shouldIntercept = false;
        mutations.forEach(function(mutation) {
          if (mutation.addedNodes.length > 0) {
            shouldIntercept = true;
          }
        });
        
        if (shouldIntercept) {
          setTimeout(() => {
            interceptFileInput();
            interceptResetButton();
          }, 100);
        }
      });
      
      observer.observe(document.body, {
        childList: true,
        subtree: true
      });
      
      setTimeout(() => {
        interceptFileInput();
        interceptResetButton();
      }, 500);
    ''';
  }
}

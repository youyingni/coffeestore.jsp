
        let lastScrollY = window.scrollY; // 儲存上一次滾動位置
    const nav = document.querySelector("nav"); // 選取你的 NAV 元素

    window.addEventListener("scroll", () => {
        if (window.scrollY > lastScrollY) {
            // 向下滾動，隱藏 NAV
            nav.classList.add("hidden");
        } else {
            // 向上滾動，顯示 NAV
            nav.classList.remove("hidden");
        }
        lastScrollY = window.scrollY; // 更新滾動位置
    });

/********************************************************/

// 初始化幻燈片
function initializeSlides(containerClass) {
  const containers = document.querySelectorAll(`.${containerClass}`);

  containers.forEach((container, index) => {
      let slideIndex = 1; // 每個容器有自己的 slideIndex
      const slides = container.querySelectorAll('.singleSlide');
      const prevButton = container.querySelector('.prev');
      const nextButton = container.querySelector('.next');

      // 顯示特定幻燈片
      function showSlides(n) {
          if (n > slides.length) slideIndex = 1; // 從第一張重新開始
          if (n < 1) slideIndex = slides.length; // 回到最後一張

          // 隱藏所有幻燈片
          slides.forEach(slide => (slide.style.display = 'none'));

          // 顯示當前幻燈片
          slides[slideIndex - 1].style.display = 'flex';
      }

      // 前後按鈕功能
      function plusSlides(n) {
          showSlides((slideIndex += n));
      }

      // 綁定按鈕事件
      if (prevButton) prevButton.addEventListener('click', () => plusSlides(-1));
      if (nextButton) nextButton.addEventListener('click', () => plusSlides(1));

      // 初始化時顯示第一張
      showSlides(slideIndex);

      // 自動播放（可選）
       setInterval(() => plusSlides(1), 4000); // 每2秒自動切換
  });
}

// 初始化所有幻燈片容器
initializeSlides('slideshow-container');

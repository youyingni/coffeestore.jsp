
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
/******************************/
$(function () {
  const items = $('.carousel-item'); // 所有幻燈片
  const total = items.length; // 總數量
  let current = 0;
  let autoPlayInterval;

  // 初始化自動播放
  startAutoPlay();

  $('#moveRight').on('click', function () {
      moveSlide(1); // 向右滑動
      resetAutoPlay(); // 重置自動播放
  });

  $('#moveLeft').on('click', function () {
      moveSlide(-1); // 向左滑動
      resetAutoPlay(); // 重置自動播放
  });

  function moveSlide(step) {
      const prev = current;
      current = (current + step + total) % total; // 計算新索引
      items.removeClass('active prev next'); // 清除所有狀態
      items.eq(prev).addClass(step > 0 ? 'prev' : 'next'); // 設定滑出方向
      items.eq(current).addClass('active'); // 設定當前顯示項

      // 清除其他不必要的類別
      setTimeout(() => {
          items.removeClass('prev next');
      }, 1000); // 過渡時間 1 秒
  }

  function startAutoPlay() {
      autoPlayInterval = setInterval(() => {
          moveSlide(1); // 每次向右滑動
      }, 5000); // 每 3 秒切換一次
  }

  function resetAutoPlay() {
      clearInterval(autoPlayInterval); // 停止目前計時器
      startAutoPlay(); // 重新開始自動播放
  }
});
/******************************/
document.addEventListener("DOMContentLoaded", () => {
  // 設定動畫結束後的滾動時間
  const animationDuration = 3000; // 動畫時間 (毫秒)

  setTimeout(() => {
      // 動畫結束後自動滾動到下一段內容，讓 HELLO 完全消失
      window.scrollTo({
          top: window.innerHeight + 50, // 滾動到比畫面底部更多一些的位置
          behavior: "smooth", // 平滑滾動效果
      });
  }, animationDuration);
});



let active = 1;
    const cardCount = $('.card-container').length;
    
    function prevSlide() {
      active = (active - 1 + cardCount) % cardCount;
      updateCarousel();
    }
    
    function nextSlide() {
      active = (active + 1) % cardCount;
      updateCarousel();
    }
    
    function updateCarousel() {
        $('.card-container').each(function(i) {
          // 確保 offset 正確處理卡片的位置
          const offset = ((i - active + cardCount) % cardCount) - Math.floor(cardCount / 2);
          const absOffset = Math.abs(offset);
          const isActive = offset === 0 ? 1 : 0;
          const opacity = absOffset <= 1 ? 1 : 0;
      
          // 使用正確的 CSS 變數更新
          $(this).css({
            '--offset': offset,
            '--direction': offset > 0 ? 1 : -1,
            '--abs-offset': absOffset,
            '--active': isActive,
            '--opacity': opacity
          });
        });
      }
      $(document).ready(function() {
        updateCarousel(); // 初始化輪播
        $('.nav.left').click(prevSlide); // 綁定按鈕事件
        $('.nav.right').click(nextSlide);
      });


      document.addEventListener("DOMContentLoaded", () => {
        const favoriteIcons = document.querySelectorAll(".favorite i");
      
        favoriteIcons.forEach(icon => {
          icon.addEventListener("click", () => {
            icon.classList.toggle("active"); // 切換紅色和灰色
          });
        });
      });
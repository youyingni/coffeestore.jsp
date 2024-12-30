document.addEventListener("DOMContentLoaded", () => {
  const cards = document.querySelectorAll(".hot-sale-card");
  const buttons = document.querySelectorAll(".carousel-indicators button");

  if (cards.length === 0 || buttons.length === 0) {
      console.error("Missing .hot-sale-card or .carousel-indicators button elements in DOM.");
      return;
  }

  let currentIndex = 0;

  // 切換卡片的函數
  const switchCard = () => {
      // 隱藏當前卡片
      cards[currentIndex].classList.remove("active");
      buttons[currentIndex].classList.remove("active");

      // 更新索引
      currentIndex = (currentIndex + 1) % cards.length;

      // 顯示下一張卡片
      cards[currentIndex].classList.add("active");
      buttons[currentIndex].classList.add("active");
  };

  // 每5秒自動切換卡片
  let timer = setInterval(switchCard, 5000);

  // 重置計時器
  const resetTimer = () => {
      clearInterval(timer);
      timer = setInterval(switchCard, 5000);
  };

  // 綁定按鈕點擊事件
  buttons.forEach((btn, index) => {
      btn.addEventListener("click", () => {
          // 清除所有卡片和按鈕的 active 樣式
          cards.forEach(card => card.classList.remove("active"));
          buttons.forEach(button => button.classList.remove("active"));

          // 為點擊的按鈕和對應的卡片添加 active 樣式
          cards[index].classList.add("active");
          btn.classList.add("active");

          // 更新當前索引並重置計時器
          currentIndex = index;
          resetTimer();
      });
  });
});

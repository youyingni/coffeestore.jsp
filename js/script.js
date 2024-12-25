/*購物車*/
document.querySelectorAll("[data-group]").forEach((button) => {
  button.addEventListener("click", (event) => {
    const group = event.target.getAttribute("data-group");
    document
      .querySelectorAll(`[data-group="${group}"]`)
      .forEach((btn) => btn.classList.remove("selected"));
    event.target.classList.add("selected");
  });
});

// 評分邏輯
document.querySelectorAll(".rating span").forEach((star) => {
  star.addEventListener("click", (event) => {
    const rating = event.target.getAttribute("data-rating");
    document
      .querySelectorAll(".rating span")
      .forEach((s) => s.classList.remove("selected"));
    for (let i = 1; i <= rating; i++) {
      document.querySelector(`.rating span[data-rating="${i}"]`).classList.add("selected");
    }
  });
});

// 購物車
$(document).ready(function() {
  $('#addtocart').on('click', function() {
    // 檢查是否選擇了甜度和冰塊
    var sweetnessSelected = $('.sweetness button.selected').length > 0;
    var iceSelected = $('.ice button.selected').length > 0;

    if (!sweetnessSelected || !iceSelected) {
      alert('請先選擇甜度和冰塊再加入購物車！');
      return; // 停止執行特效
    }

    // 如果條件符合，啟動加入購物車特效
    var button = $(this);
    var cart = $('#cart');
    var cartTotal = cart.attr('data-totalitems');
    var newCartTotal = parseInt(cartTotal) + 1;

    button.addClass('sendtocart');
    setTimeout(function() {
      button.removeClass('sendtocart');
      cart.addClass('shake').attr('data-totalitems', newCartTotal);
      setTimeout(function() {
        cart.removeClass('shake');
      }, 500);
    }, 1000);
  });

  // 點擊甜度或冰塊按鈕時，添加選中狀態
  $('.sweetness button, .ice button').on('click', function() {
    var group = $(this).data('group');
    $(`button[data-group="${group}"]`).removeClass('selected');
    $(this).addClass('selected');
  });
});

//add to my favourite



$(document).ready(function () {
  let heart = $('#heart'); // nav 裡的愛心圖標
  let isFavorited = false; // 收藏狀態 (初始為未收藏)

  $('#addtoheart').on('click', function () {
      let button = $(this); // 按鈕
      let heartTotal = parseInt(heart.attr('data-totalitems')) || 0;

      if (!isFavorited) {
          // 第一次按下：愛心飛到 nav，數量加 1
          animateHeart(button, heart, 1);
          isFavorited = true; // 設定為已收藏
      } else {
          // 第二次按下：數量變回 0，並顯示飛回按鈕
          animateHeartBack(heart, button, 0);
          isFavorited = false; // 設定為未收藏
      }
  });

  // 愛心飛向 nav
  function animateHeart(button, heart, newTotal) {
      let heartItem = $('<div class="heart-item">❤️</div>');
      $('body').append(heartItem);

      let buttonOffset = button.offset();
      let heartOffset = heart.offset();

      heartItem.css({
          position: 'absolute',
          top: buttonOffset.top + 'px',
          left: buttonOffset.left + 'px',
          zIndex: 9999,
          fontSize: '20px'
      });

      heartItem.animate({
          top: heartOffset.top + 'px',
          left: heartOffset.left + 'px',
          opacity: 0
      }, 1000, function () {
          heartItem.remove();
          heart.addClass('shake');
          setTimeout(() => heart.removeClass('shake'), 500);
          updateHeartCount(heart, newTotal);
      });
  }

  // 愛心飛回按鈕
  function animateHeartBack(heart, button, newTotal) {
      let heartItem = $('<div class="heart-item">❤️</div>');
      $('body').append(heartItem);

      let buttonOffset = button.offset();
      let heartOffset = heart.offset();

      heartItem.css({
          position: 'absolute',
          top: heartOffset.top + 'px',
          left: heartOffset.left + 'px',
          zIndex: 9999,
          fontSize: '20px'
      });

      heartItem.animate({
          top: buttonOffset.top + 'px',
          left: buttonOffset.left + 'px',
          opacity: 0
      }, 1000, function () {
          heartItem.remove();
          button.addClass('shake');
          setTimeout(() => button.removeClass('shake'), 500);
          updateHeartCount(heart, newTotal);
      });
  }

  // 更新數字
  function updateHeartCount(heart, total) {
      heart.attr('data-totalitems', total);
      heart.find('.count').text(total); // 更新數字顯示
  }
});
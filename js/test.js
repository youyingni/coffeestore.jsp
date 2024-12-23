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
  $(document).ready(function(){
    $('#addtocart').on('click',function(){
      console.log(311)
      var button = $(this);
      var cart = $('#cart');
      var cartTotal = cart.attr('data-totalitems');
      var newCartTotal = parseInt(cartTotal) + 1;
      
      button.addClass('sendtocart');
      setTimeout(function(){
        button.removeClass('sendtocart');
        cart.addClass('shake').attr('data-totalitems', newCartTotal);
        setTimeout(function(){
          cart.removeClass('shake');
        },500)
      },1000)
    })
  })



  $(document).ready(function(){
    $('#addtoheart').on('click',function(){
      console.log(5222)
      var button = $(this);
      var heart = $('#heart');
      var heartTotal = heart.attr('data-totalitems');
      var newheartTotal = parseInt(heartTotal) + 1;
      
      button.addClass('sendtoheart');
      setTimeout(function(){
        button.removeClass('sendtoheart');
        heart.addClass('shake').attr('data-totalitems', newheartTotal);
        setTimeout(function(){
          heart.removeClass('shake');
        },500)
      },1000)
    })
  })




/*
  $(document).ready(function () {
    let heart = $('#heart'); // 愛心圖標
    let isFavorited = false; // 收藏狀態

    $('#addtoheart').on('click', function () {
        let button = $(this); // 按鈕
        let heartTotal = parseInt(heart.attr('data-totalitems')) || 0; // 目前數量

        if (!isFavorited) {
            // 新增愛心特效
            addHeartEffect(button, heart, heartTotal + 1);
            isFavorited = true;
        } else {
            // 移除愛心
            updateHeartCount(heart, heartTotal - 1);
            isFavorited = false;
        }
    });

    function addHeartEffect(button, heart, newTotal) {
        // 克隆一個飛行的 icon
        let heartItem = $('<div class="heart-item">❤️</div>');
        $('body').append(heartItem);

        // 設定飛行動畫的初始位置
        let buttonOffset = button.offset();
        heartItem.css({
            position: 'absolute',
            top: buttonOffset.top,
            left: buttonOffset.left,
            zIndex: 9999
        });

        // 執行動畫：飛向 nav 的愛心圖標
        heartItem.animate({
            top: heart.offset().top,
            left: heart.offset().left,
            opacity: 0
        }, 1000, function () {
            heartItem.remove(); // 動畫結束後移除元素
            heart.addClass('shake'); // 愛心抖動
            setTimeout(() => heart.removeClass('shake'), 500);

            // 更新數字
            updateHeartCount(heart, newTotal);
        });
    }

    function updateHeartCount(heart, total) {
        heart.attr('data-totalitems', total);
        heart.find('.count').text(total); // 確保數字顯示
    }
});

*/
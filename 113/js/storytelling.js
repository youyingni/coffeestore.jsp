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

//Based on the Scroller function from @sallar
var $content = $('header .content')
  , $blur    = $('header .overlay')
  , wHeight  = $(window).height();

$(window).on('resize', function(){
  wHeight = $(window).height();
});

window.requestAnimFrame = (function()
{
  return  window.requestAnimationFrame       ||
          window.webkitRequestAnimationFrame ||
          window.mozRequestAnimationFrame    ||
          function( callback ){
            window.setTimeout(callback, 1000 / 60);
          };
})();

function Scroller()
{
  this.latestKnownScrollY = 0;
  this.ticking            = false;
}

Scroller.prototype = {
 
  init: function() {
    window.addEventListener('scroll', this.onScroll.bind(this), false);
    $blur.css('background-image',$('header:first-of-type').css('background-image'));
  },


  onScroll: function() {
    this.latestKnownScrollY = window.scrollY;
    this.requestTick();
  },

  
  requestTick: function() {
    if( !this.ticking ) {
      window.requestAnimFrame(this.update.bind(this));
    }
    this.ticking = true;
  },

  update: function() {
    var currentScrollY = this.latestKnownScrollY;
    this.ticking = false;
    
    
    var slowScroll = currentScrollY / 2,
        blurScroll = currentScrollY * 2, 
        opaScroll = 1.4 - currentScrollY / 400;

    if(currentScrollY > wHeight)
      $('nav').css('position','fixed');
    else
      $('nav').css('position','absolute');
      
    $content.css({
      'transform'         : 'translateY(' + slowScroll + 'px)',
      '-moz-transform'    : 'translateY(' + slowScroll + 'px)',
      '-webkit-transform' : 'translateY(' + slowScroll + 'px)',
      'opacity' : opaScroll
    });
    
    $blur.css({
      'opacity' : blurScroll / wHeight
    });
  }
};

var scroller = new Scroller();  
scroller.init();


$(function() {
  var row = $('.zlhomeAnimate');
  var $window = $(window);
  
  $window.on('scroll', function() {
    var pad = Math.max(0, $window.height() - 100);
    var scrollTop = $window.scrollTop();

    if (!row.hasClass('visible') &&
        $window.scrollTop() + pad > row.offset().top) {
      row.addClass('visible');
      return;
    }
    
    // if (row.hasClass('visible') &&
    //     $window.scrollTop() + pad < row.offset().top) {
    //   row.removeClass('visible');
    //   return;
    // }
  });
  
  var row2 = $('.zlhomeAnimate2');
  var $window = $(window);
  
  $window.on('scroll', function() {
    var pad = Math.max(0, $window.height() - 100);
    var scrollTop = $window.scrollTop();

    if (!row2.hasClass('visible') &&
        $window.scrollTop() + pad > row2.offset().top) {
      row2.addClass('visible');
      return;
    }
    
    // if (row2.hasClass('visible') &&
    //     $window.scrollTop() + pad < row2.offset().top) {
    //   row2.removeClass('visible');
    //   return;
    // }
  });
});

document.addEventListener("scroll", function () {
    const header = document.querySelector("header");
    const scrollY = window.scrollY;
    const headerHeight = header.offsetHeight;

    // 透明度逐漸減少
    const opacity = Math.max(0.85, 1 - scrollY / headerHeight);
    header.style.opacity = opacity;
});

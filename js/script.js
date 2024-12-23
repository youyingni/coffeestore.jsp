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



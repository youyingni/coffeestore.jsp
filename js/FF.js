var shippingRate = 60.00; // 運費設定為 60
var fadeTime = 300;

/* Assign actions */
$('.product-quantity input').change(function () {
  updateQuantity(this);
});

$('.product-removal button').click(function () {
  removeItem(this);
});

/* Recalculate cart */
function recalculateCart() {
  var subtotal = 0;

  /* Sum up row totals */
  $('.product').each(function () {
    subtotal += parseFloat($(this).children('.product-line-price').text());
  });

  /* Calculate totals */
  var shipping = subtotal > 0 ? shippingRate : 0; // 如果小計大於 0，則運費為 60；否則為 0
  var total = subtotal + shipping; // 總金額 = 小計 + 運費

  /* Update totals display */
  $('.totals-value').fadeOut(fadeTime, function () {
    $('#cart-subtotal').html(subtotal.toFixed(2)); // 更新小計
    $('#cart-shipping').html(shipping.toFixed(2)); // 更新運費
    $('#cart-total').html(total.toFixed(2)); // 更新總計

    if (total === 0) {
      $('.checkout').fadeOut(fadeTime); // 如果總金額為 0，隱藏結帳按鈕
    } else {
      $('.checkout').fadeIn(fadeTime); // 否則顯示結帳按鈕
    }
    $('.totals-value').fadeIn(fadeTime);
  });
}

/* Update quantity */
function updateQuantity(quantityInput) {
  /* Calculate line price */
  var productRow = $(quantityInput).parent().parent();
  var price = parseFloat(productRow.children('.product-price').text());
  var quantity = $(quantityInput).val();
  var linePrice = price * quantity;

  /* Update line price display and recalc cart totals */
  productRow.children('.product-line-price').each(function () {
    $(this).fadeOut(fadeTime, function () {
      $(this).text(linePrice.toFixed(2));
      recalculateCart();
      $(this).fadeIn(fadeTime);
    });
  });
}

/* Remove item from cart */
function removeItem(removeButton) {
  /* Remove row from DOM and recalc cart total */
  var productRow = $(removeButton).parent().parent();
  productRow.slideUp(fadeTime, function () {
    productRow.remove();
    recalculateCart();
  });
}
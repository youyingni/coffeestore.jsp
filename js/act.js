
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

/*************/

let slideIndex = 1; //先設預設變數為1

function showSlides(props) {
let i;
//取得所有的mySlides 因為他是取class 而不是id 所以要用getElementsByClassName
let slides = document.getElementsByClassName("singleSlide");

//如果n大於slides的長度，代表已經到最後一張，所以要從第一張開始
if (props > slides.length) {
slideIndex = 1;
}

if (props < 1) {
slideIndex = slides.length;
}


//將所有圖片隱藏
for (i = 0; i < slides.length; i++) {
slides[i].style.display = "none";
}

//將新的圖片顯示
//   console.log(slideIndex - 1, 25);

//array都從0開始，所以要減一，因為我們的slideIndex是從1開始 ，已經賦予值
slides[slideIndex - 1].style.display = "flex";
}

function plusSlides(a) {
showSlides((slideIndex += a));
}
//使用者點擊左右按鈕時，並傳入參數1或-1，代表下一張或上一張
plusSlides(slideIndex);

// 設定自動播放，每3秒切換一次
setInterval(function() {
plusSlides(1); // 每3秒自動切換到下一張幻燈片
}, 2000); // 3000毫秒 = 3秒

/************************************/



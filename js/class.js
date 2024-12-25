let active = 0;
const cards = document.querySelectorAll(".card-container");
const totalCards = cards.length;

function updateCarousel() {
    cards.forEach((card, index) => {
        const offset = (index - active + totalCards) % totalCards - Math.floor(totalCards / 2);
        const absOffset = Math.abs(offset);

        card.style.setProperty("--offset", offset);
        card.style.setProperty("--abs-offset", absOffset);
    });
}

function prevSlide() {
    active = (active - 1 + totalCards) % totalCards;
    updateCarousel();
}

function nextSlide() {
    active = (active + 1) % totalCards;
    updateCarousel();
}

// Initialize carousel on page load
updateCarousel();







// 獲取按鈕與彈跳視窗元素
const filterModal = document.getElementById("filterModal");
const openFilterModal = document.getElementById("openFilterModal");
const closeModal = document.querySelector(".close");
const applyFilters = document.getElementById("applyFilters");

// 顯示彈跳視窗
openFilterModal.addEventListener("click", () => {
  filterModal.style.display = "block";
});

// 關閉彈跳視窗
closeModal.addEventListener("click", () => {
  filterModal.style.display = "none";
});

// 點擊視窗外部隱藏彈跳視窗
window.addEventListener("click", (event) => {
  if (event.target === filterModal) {
    filterModal.style.display = "none";
  }
});

// 應用篩選條件
applyFilters.addEventListener("click", () => {
  const selectedLevel = document.querySelector('input[name="level"]:checked').value;
  alert(`已選擇篩選條件：${selectedLevel}`);
  filterModal.style.display = "none";
});



applyFilters.addEventListener("click", () => {
    const selectedLevel = document.querySelector('input[name="level"]:checked').value;
    const startDate = document.getElementById("startDate").value;
    const endDate = document.getElementById("endDate").value;

    // 篩選條件提示
    console.log(`篩選條件：難度 = ${selectedLevel}, 開始日期 = ${startDate}, 結束日期 = ${endDate}`);

    filterModal.style.display = "none";

    // 示例：在此處根據選擇的日期篩選課程表格
    const rows = document.querySelectorAll(".course-table tr");
    for (let i = 1; i < rows.length; i++) {
        const dateCell = rows[i].cells[2]; // 假設日期在第3列
        const courseDate = new Date(dateCell.textContent || dateCell.innerText);

        // 檢查日期是否在篩選範圍內
        if (startDate && endDate) {
            const start = new Date(startDate);
            const end = new Date(endDate);
            rows[i].style.display = courseDate >= start && courseDate <= end ? "" : "none";
        } else {
            rows[i].style.display = ""; // 沒有選擇日期時顯示所有
        }
    }
});

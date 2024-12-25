// 切換顯示/隱藏區塊
function toggleSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section.style.display === "none" || section.style.display === "") {
        section.style.display = "block"; // 顯示
    } else {
        section.style.display = "none"; // 隱藏
    }
}

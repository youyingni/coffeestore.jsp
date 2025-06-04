<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page isELIgnored="true" %>
<!DOCTYPE html>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>留言板</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
        rel="stylesheet">

    <style>
        @import url("../css/comment.css");
        @import url("../css/navBar.css");
    </style>
    <script src="https://code.iconify.design/iconify-icon/2.2.0/iconify-icon.min.js"></script>
</head>

<body>

    <nav id="primary_nav_wrap">
        <ul>
            <li><a href="index.jsp"><img class="logo" src='../img/OIP.jpg'></a></li>
            <li><a href="#">紓咖商品</a>
                <ul>
                    <li>
                        <a href="Product_interface.html">紓咖咖啡</a>
                    </li>
                </ul>
            </li>
            <li><a href="class.html">紓咖瑜珈</a>
                <ul>
                    <li>
                        <a href="class.html#yoga10">初階課程</a>
                    </li>
                    <li>
                        <a href="class.html#yoga20">進階課程</a>
                    </li>
                </ul>
            </li>

            <li><a href="act.html">紓咖活動</a>
                <ul>
                    <li><a href="act.html#oil">精油</a></li>
                    <li><a href="act.html#sounds">頌缽</a></li>
                    <li><a href="act.html#words">書法</a></li>
                    <li><a href="act.html#Xmas">聖誕</a></li>
                </ul>
            </li>
            <li><a href="storytelling.html">紓咖說書</a>
            </li>
            <li><a href="aboutus.html">關於我們</a>
                <ul>
                    <li><a href="aboutus.html#cats">店貓介紹</a></li>
                    <li><a href="aboutus.html#qa">Q & A</a></li>
                </ul>
            </li>
            <li><a href="#">留言意見</a>
                <ul>
                    <li><a href="comment.html">留言板</a></li>
                    <li><a href="contact.html">意見箱</a></li>
                </ul>
            </li>
        </ul>
        <div class="icon">
            <ul>
                <li>
                    <a href="login.html">
                        <iconify-icon icon="bi:people-circle" width="30px" height="30px"></iconify-icon>
                    </a>
                </li>

                <li>
                    <a href="cart.html">
                        <iconify-icon icon="guidance:shop" width="30px" height="30px"></iconify-icon>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="txt">
        <div class="container">
            <!-- 左側：總評價 -->
            <div class="rating-summary">
                <div>5則評價</div>
                <div class="stars" id="averageRating">★★★★★ 4.8星</div>
                <button class="btn" id="openModal">發表</button>
            </div>
            <!-- 右側：星等分布 -->
            <div class="rating-bar">
                <div>
                    5星
                    <div class="bar">
                        <div class="bar-fill" data-star="5"></div>
                    </div>
                    <span class="percentage">0%</span>
                </div>
                <div>
                    4星
                    <div class="bar">
                        <div class="bar-fill" data-star="4"></div>
                    </div>
                    <span class="percentage">0%</span>
                </div>
                <div>
                    3星
                    <div class="bar">
                        <div class="bar-fill" data-star="3"></div>
                    </div>
                    <span class="percentage">0%</span>
                </div>
                <div>
                    2星
                    <div class="bar">
                        <div class="bar-fill" data-star="2"></div>
                    </div>
                    <span class="percentage">0%</span>
                </div>
                <div>
                    1星
                    <div class="bar">
                        <div class="bar-fill" data-star="1"></div>
                    </div>
                    <span class="percentage">0%</span>
                </div>
            </div>
        </div>
        <!-- 彈出留言表單 -->
        <div class="modal" id="modal">
            <div class="modal-content">
                <button class="close-btn" id="closeModal">&times;</button>
                <h3>發表留言及評分</h3>
                <div>留言內容</div>
                <textarea id="comment" placeholder="輸入留言"></textarea>
                <div>評價</div>
                <div class="stars-rating" id="starRating">
                    <span data-value="1">★</span>
                    <span data-value="2">★</span>
                    <span data-value="3">★</span>
                    <span data-value="4">★</span>
                    <span data-value="5">★</span>
                </div>
                <button class="btn" id="submit">分享</button>
            </div>
        </div>
        <div id="thankYouModal" class="thank-you-modal">
            <div class="thank-you-content">
                <p>分享完成，感謝您寶貴的評論!!</p>
            </div>
        </div>
        <div id="comments-board" class="comments-board">
            <div class="nav">
                <div class="comment-count" id="comment-count">0 則留言</div>
                <button class="sort-button" onclick="toggleDropdown()">排序依據</button>
                <div id="sort-dropdown" class="sort-dropdown">
                    <a href="javascript:void(0)" onclick="sortComments('newest')">最新至最舊</a>
                    <a href="javascript:void(0)" onclick="sortComments('oldest')">最舊至最新</a>
                    <a href="javascript:void(0)" onclick="sortComments('popular')">熱門留言</a>
                </div>
            </div>
            <div class="comment" data-likes="24" data-date="2024-11-27">
                <div class="comment-header">
                    <div class="user">
                        <img src="https://images.unsplash.com/photo-1728577740843-5f29c7586afe?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            alt="阿志">
                        <span>阿志</span>
                    </div>
                    <div class="stars">★★★★</div>
                </div>
                <div class="comment-body">讚讚讚!!!!!!!!!!!!</div>
                <div class="comment-footer">
                    <button class="like-button" onclick="toggleLike(this)">
                        <span class="like-icon">
                            <iconify-icon icon="material-symbols:thumb-up-outline" width="28"
                                height="28"></iconify-icon>
                        </span>
                        <span class="like-count">24</span>
                    </button>
                    <div class="comment-date">2024/11/27</div>
                </div>
            </div>
            <div class="comment" data-likes="55" data-date="2024-10-27">
                <div class="comment-header">
                    <div class="user">
                        <img src="https://images.unsplash.com/photo-1728887823143-d92d2ebbb53a?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            alt="阿浩">
                        <span>阿浩</span>
                    </div>
                    <div class="stars">★★★★★</div>
                </div>
                <div class="comment-body">貓咪好勾追 </div>
                <div class="comment-footer">
                    <button class="like-button" onclick="toggleLike(this)">
                        <span class="like-icon">
                            <iconify-icon icon="material-symbols:thumb-up-outline" width="28"
                                height="28"></iconify-icon>
                        </span>
                        <span class="like-count">55</span>
                    </button>
                    <div class="comment-date">2024/10/27</div>
                </div>
            </div>
            <div class="comment" data-likes="8" data-date="2023-01-27">
                <div class="comment-header">
                    <div class="user">
                        <img src="https://plus.unsplash.com/premium_photo-1731404830883-67fffdba8339?q=80&w=2077&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            alt="小林">
                        <span>小林</span>
                    </div>
                    <div class="stars">★★★★★</div>
                </div>
                <div class="comment-body">咖啡有料 5顆星!!</div>
                <div class="comment-footer">
                    <button class="like-button" onclick="toggleLike(this)">
                        <span class="like-icon">
                            <iconify-icon icon="material-symbols:thumb-up-outline" width="28"
                                height="28"></iconify-icon>
                        </span>
                        <span class="like-count">8</span>
                    </button>
                    <div class="comment-date">2024/1/27</div>
                </div>
            </div>
            <div class="comment" data-likes="32" data-date="2024-05-20">
                <div class="comment-header">
                    <div class="user">
                        <img src="https://plus.unsplash.com/premium_photo-1731404830878-97dc26e0941f?q=80&w=2077&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            alt="小志">
                        <span>小志</span>
                    </div>
                    <div class="stars">★★★★★</div>
                </div>
                <div class="comment-body">瑜珈課程好有趣!</div>
                <div class="comment-footer">
                    <button class="like-button" onclick="toggleLike(this)">
                        <span class="like-icon">
                            <iconify-icon icon="material-symbols:thumb-up-outline" width="28"
                                height="28"></iconify-icon>
                        </span>
                        <span class="like-count">32</span>
                    </button>
                    <div class="comment-date">2024/5/20</div>
                </div>
            </div>
            <div class="comment" data-likes="2" data-date="2024-12-8">
                <div class="comment-header">
                    <div class="user">
                        <img src="https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
                            alt="Lin">
                        <span>Lin</span>
                    </div>
                    <div class="stars">★★★★★</div>
                </div>
                <div class="comment-body">店員很親切很好聊天</div>
                <div class="comment-footer">
                    <button class="like-button" onclick="toggleLike(this)">
                        <span class="like-icon">
                            <iconify-icon icon="material-symbols:thumb-up-outline" width="28"
                                height="28"></iconify-icon>
                        </span>
                        <span class="like-count">2</span>
                    </button>
                    <div class="comment-date">2024/12/8</div>
                </div>
            </div>
        </div>
        <script>
            function sortComments(order) {
                const board = document.getElementById("comments-board");
                const comments = Array.from(board.getElementsByClassName("comment"));

                // 保留當前按讚狀態
                comments.forEach(comment => {
                    const likeButton = comment.querySelector('.like-button');
                    const isLiked = likeButton.classList.contains('liked');
                    comment.setAttribute('data-liked', isLiked);
                });

                // 根據排序條件進行排列
                if (order === "newest") {
                    comments.sort((a, b) => new Date(b.getAttribute("data-date")) - new Date(a.getAttribute("data-date")));
                } else if (order === "oldest") {
                    comments.sort((a, b) => new Date(a.getAttribute("data-date")) - new Date(b.getAttribute("data-date")));
                } else if (order === "popular") {
                    comments.sort((a, b) => b.getAttribute("data-likes") - a.getAttribute("data-likes"));
                }

                // 清空當前留言內容，只清空留言部分
                comments.forEach(comment => comment.remove());

                // 重新插入排序後的留言，並恢復按讚狀態
                comments.forEach(comment => {
                    board.appendChild(comment);
                    const isLiked = comment.getAttribute('data-liked') === 'true';
                    const likeButton = comment.querySelector('.like-button');
                    const iconElement = likeButton.querySelector('iconify-icon');

                    if (isLiked) {
                        likeButton.classList.add('liked');
                        iconElement.setAttribute('icon', 'material-symbols:thumb-up');
                    } else {
                        likeButton.classList.remove('liked');
                        iconElement.setAttribute('icon', 'material-symbols:thumb-up-outline');
                    }
                });

                // 隱藏下拉選單
                const dropdown = document.getElementById('sort-dropdown');
                dropdown.style.display = 'none';
            }

            // 修正點擊下拉選單時的事件綁定
            function toggleDropdown() {
                const dropdown = document.getElementById('sort-dropdown');
                dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
            }
            // 確保點擊排序選項後隱藏下拉選單
            document.querySelectorAll('#sort-dropdown a').forEach(option => {
                option.addEventListener('click', () => {
                    const dropdown = document.getElementById('sort-dropdown');
                    dropdown.style.display = 'none';
                });
            });
            function toggleLike(button) {
                const likeCountElement = button.querySelector('.like-count');
                const currentLikes = parseInt(likeCountElement.textContent);
                const iconElement = button.querySelector('iconify-icon');
                if (button.classList.contains('liked')) {
                    // 已按讚 -> 取消讚
                    likeCountElement.textContent = currentLikes - 1;
                    button.classList.remove('liked');
                    iconElement.setAttribute('icon', 'material-symbols:thumb-up-outline'); // 取消讚變為空心
                } else {
                    // 未按讚 -> 按讚
                    likeCountElement.textContent = currentLikes + 1;
                    button.classList.add('liked');
                    iconElement.setAttribute('icon', 'material-symbols:thumb-up'); // 按讚變為實心
                }
            }
            // 更新留言數量
            function updateCommentCount() {
                const commentCount = document.getElementsByClassName('comment').length;
                document.getElementById('comment-count').textContent = `${commentCount} 則留言`;
            }
            // 初始化留言數量
            updateCommentCount();
            const modal = document.getElementById('modal');
            const successMessage = document.getElementById('successMessage');
            const averageRating = document.getElementById('averageRating');
            const starRating = document.querySelectorAll('#starRating span');
            let selectedStars = 0;
            // 開啟視窗
            document.getElementById('openModal').onclick = () => {
                modal.style.display = 'flex'
                console.log(2511)
            };
            // 星星互動
            starRating.forEach(star => {
                star.onclick = () => {
                    selectedStars = parseInt(star.dataset.value);
                    starRating.forEach(s => s.classList.remove('selected'));
                    for (let i = 0; i < selectedStars; i++) starRating[i].classList.add('selected');
                };
            });
            // 顯示感謝彈窗
            function showThankYouModal() {
                const thankYouModal = document.getElementById('thankYouModal');
                thankYouModal.style.display = 'flex';
                // 3 秒後自動隱藏
                setTimeout(() => {
                    thankYouModal.style.display = 'none';
                }, 3000);
            }
            document.getElementById('submit').onclick = () => {
                const commentInput = document.getElementById('comment');
                const newComment = commentInput.value.trim();
                if (selectedStars > 0 && newComment) {
                    // 隱藏彈窗與顯示成功訊息
                    modal.style.display = 'none';
                    showThankYouModal(); // 顯示感謝彈窗
                    // 更新星級數據
                    ratings[5 - selectedStars]++;
                    totalReviews++;
                    // 更新長條圖和平均星級
                    updateRating();
                    // 新增評論到排序區塊下方
                    addComment(newComment, selectedStars);
                    // 清空輸入框與星星選擇
                    commentInput.value = '';
                    selectedStars = 0;
                    starRating.forEach(star => star.classList.remove('selected'));
                } else {
                    alert('請輸入評論並選擇評分！');
                }
            };




            








               //一定是這邊有問題幫我對著上面程式一起看
            function updateRating() {
    const avg = ratings.reduce((sum, count, i) => sum + count * (5 - i), 0) / totalReviews;
    const averageRating = document.getElementById('averageRating');
    averageRating.textContent = "★★★★★ " + avg.toFixed(1) + "星";

    const totalReviewsElement = document.querySelector('.rating-summary > div');
    totalReviewsElement.textContent = totalReviews + "則評價";

    document.querySelectorAll('.bar-fill').forEach(bar => {
        const star = parseInt(bar.getAttribute('data-star'));
        const index = 5 - star;
        const percentage = (ratings[index] / totalReviews) * 100;
        bar.style.width = percentage + "%";
        const percentageText = bar.parentElement.nextElementSibling;
        percentageText.textContent = Math.round(percentage) + "%";
    });

    console.log('Updated Ratings:', ratings);
    console.log('Total Reviews:', totalReviews);
}

            function addComment(commentText, stars) {
                const board = document.getElementById('comments-board');
                const sortSection = board.querySelector('.nav'); // 取得排序依據的區塊
                const newComment = document.createElement('div');
                newComment.className = 'comment';
                newComment.setAttribute('data-likes', '0');
                newComment.setAttribute('data-date', new Date().toISOString().split('T')[0]);
                // 預設的頭像 URL 集合
                const avatars = [
                    "https://images.unsplash.com/photo-1638803040283-7a5ffd48dad5?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3",
                    "https://images.unsplash.com/photo-1728887823143-d92d2ebbb53a?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3",
                    "https://images.unsplash.com/photo-1728577740843-5f29c7586afe?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3",
                    "https://plus.unsplash.com/premium_photo-1731404830878-97dc26e0941f?q=80&w=2077&auto=format&fit=crop&ixlib=rb-4.0.3",
                    "https://plus.unsplash.com/premium_photo-1731404830883-67fffdba8339?q=80&w=2077&auto=format&fit=crop&ixlib=rb-4.0.3"
                ];
                // 隨機選取一個頭像
                const randomAvatar = avatars[Math.floor(Math.random() * avatars.length)];
                // 新評論的 HTML 結構
                newComment.innerHTML = `
                    <div class="comment-header">
                        <div class="user">
                            <img src="${randomAvatar}" alt="新用戶">
                            <span>新用戶</span>
                        </div>
                        <div class="stars">` + "★".repeat(stars) + `</div>
                    </div>
                    <div class="comment-body">${commentText}</div>
                    <div class="comment-footer">
                        <button class="like-button" onclick="toggleLike(this)">
                            <span class="like-icon">
                                <iconify-icon icon="material-symbols:thumb-up-outline" width="28" height="28"></iconify-icon>
                            </span>
                            <span class="like-count">0</span>
                        </button>
                        <div class="comment-date">` + new Date().toLocaleDateString() + `</div>
                    </div>
                `;
                // 插入到排序依據區塊的後面
                board.insertBefore(newComment, sortSection.nextSibling);
                // 更新留言數量
                updateCommentCount();
            }
            let ratings = [4, 1, 0, 0, 0]; // 預設評價分佈：5星有4個，4星有1個
            let totalReviews = 0; // 會在初始化函式中重新計算
            function initializeRating() {
                // 計算總評論數
                totalReviews = ratings.reduce((sum, count) => sum + count, 0);
                // 初始化長條圖
                document.querySelectorAll('.bar-fill').forEach(bar => {
                    const star = parseInt(bar.getAttribute('data-star')); // 取得星級
                    const index = 5 - star; // 對應到 `ratings` 陣列的索引
                    const percentage = (ratings[index] / totalReviews) * 100;
                    // 設定初始寬度
                    bar.style.width = `${percentage}%`;
                    // 更新旁邊的百分比文字
                    const percentageText = bar.parentElement.nextElementSibling;
                    percentageText.textContent = `${Math.round(percentage)}%`;
                });
                // 初始化平均星級
                const avg = ratings.reduce((sum, count, i) => sum + count * (5 - i), 0) / totalReviews;
                const averageRating = document.getElementById('averageRating');
                averageRating.textContent = `★★★★★ ${avg.toFixed(1)}星`;
            }
            document.addEventListener('DOMContentLoaded', () => {
                initializeRating(); // 初始化長條圖與平均星級
            });
            // 關閉表單的功能
            document.getElementById('closeModal').onclick = () => {
                const modal = document.getElementById('modal');
                modal.style.display = 'none';
            };
            // 仍保留開啟表單的功能
            document.getElementById('openModal').onclick = () => {
                const modal = document.getElementById('modal');
                modal.style.display = 'flex';
            };
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
        </script>
    </div>
    <footer>

        <div class="footer-container">
            <div class="left-section">
                <div class="social-icons">
                    <a href="https://www.facebook.com/relaxshuca">
                        <iconify-icon class="icon1" icon="entypo-social:facebook" width="50" height="50"></iconify-icon>
                    </a>
                    <span>紓咖</span>
                    <a href="https://www.instagram.com/cominghsu_/?hl=zh-tw">
                        <iconify-icon class="icon1" icon="formkit:instagram" width="50" height="50"></iconify-icon>
                    </a>
                    <span>cominghsu</span>
                    <iconify-icon class="icon1" icon="el:phone-alt" width="50" height="50"></iconify-icon>
                    <span>0911305010</span>
                </div>
                <div>
                    <iconify-icon icon="maki:marker" style="color: #d22c0d" width="30" height="30"></iconify-icon>
                    地址：320桃園市中壢區環中東路357-1號
                </div>

            </div>
            <div class="right-section">
                <iframe
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.138166658024!2d121.25174567499147!3d24.961413377863547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468232a47f00ba3%3A0xa4ae5602976d050a!2z57ST5ZKWIOS_ruaBr-ajpw!5e0!3m2!1szh-TW!2stw!4v1733113194746!5m2!1szh-TW!2stw"
                    allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                </iframe>
                <div>
                    <img src="../img/fb.png" alt="Facebook QR" width="100">
                    <p>facebook</p>
                </div>
                <div>
                    <img src="../img/ig.png" alt="Instagram QR" width="100">
                    <p>instagram</p>
                </div>
            </div>
        </div>


        <div class="marquee">
            <div>
                © 2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT&emsp;&emsp;&emsp;&emsp;&emsp;©
                2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT
            </div>
        </div>
    </footer>
</body>

</html>
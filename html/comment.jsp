<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>

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
	
		.pagination {
			margin: 20px;
			text-align: center;
		}
		.pagination a {
			padding: 1px 12px;
			margin: 0 4px;
			border: 1px solid #ccc;
			text-decoration: none;
			color: #333;
		}
		.pagination a.current-page {
			background-color: #333;
			color: white;
		}
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
                        <a href="Product_interface.jsp">紓咖咖啡</a>
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
                    <li><a href="comment.jsp">留言板</a></li>
                    <li><a href="contact.html">意見箱</a></li>
                </ul>
            </li>
        </ul>
        <div class="icon">
            <ul>
                <li>
                    <a href="login.jsp">
                        <iconify-icon icon="bi:people-circle" width="30px" height="30px"></iconify-icon>
                    </a>
                </li>

                <li>
                    <a href="cart.jsp">
                        <iconify-icon icon="guidance:shop" width="30px" height="30px"></iconify-icon>
                    </a>
                </li>
            </ul>
        </div>
    </nav>
	
<%
    String membersDB = "jdbc:mysql://localhost:3306/coffee?useUnicode=true&characterEncoding=UTF-8";
    String commentDB = "jdbc:mysql://localhost:3306/coffee?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234";

    String username = (String) session.getAttribute("memberID");
    String email = null;

    if (username != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(membersDB, dbUser, dbPassword);
            PreparedStatement ps = conn.prepareStatement("SELECT email FROM members WHERE id = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p style='color:red;'>錯誤：" + e.getMessage() + "</p>");
        }
    }

    if ("POST".equalsIgnoreCase(request.getMethod()) && username != null && email != null) {
        String content = request.getParameter("content");
        int rate = Integer.parseInt(request.getParameter("rate"));

        try {
            Connection conn = DriverManager.getConnection(commentDB, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO comment (commentName, email, rate, content, date) VALUES (?, ?, ?, ?, NOW())");
            stmt.setString(1, username);
            stmt.setString(2, email);
            stmt.setInt(3, rate);
            stmt.setString(4, content);
            stmt.executeUpdate();
            stmt.close();
            conn.close();
            out.println("<p style='color:green;'>留言成功！</p>");
        } catch (Exception e) {
            out.println("<p style='color:red;'>留言失敗：" + e.getMessage() + "</p>");
        }
    }

    int totalCount = 0;
    Map<Integer, Integer> starCounts = new HashMap<>();
    for (int i = 1; i <= 5; i++) starCounts.put(i, 0);
    double avgRate = 0.0;

    try {
        Connection conn = DriverManager.getConnection(commentDB, dbUser, dbPassword);

        PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS total FROM comment");
        ResultSet rs = ps.executeQuery();
        if (rs.next()) totalCount = rs.getInt("total");
        rs.close();
        ps.close();

        ps = conn.prepareStatement("SELECT rate, COUNT(*) AS count FROM comment GROUP BY rate");
        rs = ps.executeQuery();
        while (rs.next()) {
            int rate = rs.getInt("rate");
            int count = rs.getInt("count");
            starCounts.put(rate, count);
        }
        rs.close();
        ps.close();

        ps = conn.prepareStatement("SELECT AVG(rate) AS avgRate FROM comment");
        rs = ps.executeQuery();
        if (rs.next()) avgRate = rs.getDouble("avgRate");
        rs.close();
        ps.close();

        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>錯誤：" + e.getMessage() + "</p>");
    }

    Map<Integer, Double> starPercent = new HashMap<>();
    for (int i = 1; i <= 5; i++) {
        int count = starCounts.get(i);
        double percent = totalCount == 0 ? 0 : (count * 100.0 / totalCount);
        starPercent.put(i, percent);
    }
	
    int pageParam = 1;
	int pageSize = 5;
	int offset = 0;

	try {
		pageParam = Integer.parseInt(request.getParameter("page"));
	} catch (Exception e) {
		pageParam = 1;
	}
	offset = (pageParam - 1) * pageSize;
	
	if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("likeCommentId") != null) {
    String userId = (String) session.getAttribute("memberID");
    int likedCommentId = Integer.parseInt(request.getParameter("likeCommentId"));

		if (userId != null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection(commentDB, dbUser, dbPassword);
				PreparedStatement ps = conn.prepareStatement(
					"INSERT IGNORE INTO `like` (comment_id, user_id) VALUES (?, ?)"
				);
				ps.setInt(1, likedCommentId);
				ps.setString(2, userId);
				ps.executeUpdate();
				ps.close();
				conn.close();
			} catch (Exception e) {
				out.println("<p style='color:red;'>按讚失敗：" + e.getMessage() + "</p>");
			}
		}
	}
%>
    <div class="txt">
        <div class="container">
            <!-- 左側：總評價 -->
            <div class="rating-summary">
                <div><%= totalCount %>則評價</div>
                <div class="stars" id="averageRating">
					<%= "★★★★★".substring(0, (int)Math.round(avgRate)) %> 
					<%= String.format("%.1f", avgRate) %>星
				</div>
                <button class="btn" id="openModal" onclick="showCommentForm()">發表</button>
            </div>
			
            <!-- 右側：星等分布 -->
            <div class="rating-bar">
				<% for (int i = 5; i >= 1; i--) { %>
                <div>
                    <%= i %>星
                    <div class="bar">
                        <div class="bar-fill" data-star="<%= i %>" style="width:<%= String.format("%.0f", starPercent.get(i)) %>%"></div>
                    </div>
                    <span class="percentage"><%= String.format("%.0f", starPercent.get(i)) %>%</span>
                </div>
            <% } %>
            </div>
        </div>
        <!-- 彈出留言表單 -->
        <div class="modal" id="modal">
			<div class="modal-content">
				<button class="close-btn" id="closeModal">&times;</button>

				<% if (username != null && email != null) { %>
					<h3>發表留言及評分</h3>
					<form method="post" action="comment.jsp?submitted=true">
						<label>留言內容</label><br>
						<textarea name="content" rows="5" cols="50" placeholder="輸入留言" required></textarea><br>

						<label>評價</label><br>
						<div class="stars-rating" id="starRating">
						  <span data-value="1">★</span>
						  <span data-value="2">★</span>
						  <span data-value="3">★</span>
						  <span data-value="4">★</span>
						  <span data-value="5">★</span>
						</div>
						<input type="hidden" name="rate" id="rateInput" required><br><br>

						<input type="submit" class="btn" value="分享">
					</form>
				<% } else { %>
					<p style="font-size: 18px; text-align: center">⚠️ 請先 <a href="login.jsp">登入</a> 才能留言。</p>
				<% } %>
			</div>
		</div>

<%
    String showModal = request.getParameter("showModal");
    boolean showModalBool = "true".equals(showModal);
%>


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
				</div>
            </div>

			<div id="comments-list" class="comments">
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = DriverManager.getConnection(commentDB, dbUser, dbPassword);
				PreparedStatement stmt = conn.prepareStatement("SELECT * FROM comment ORDER BY date DESC LIMIT ?, ?");
				stmt.setInt(1, offset);
				stmt.setInt(2, pageSize);
				ResultSet rs = stmt.executeQuery();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				while (rs.next()) {
					int rate = rs.getInt("rate");
					int commentID = rs.getInt("commentID"); 
					String stars = "★★★★★".substring(0, rate);
					String dateOnly = sdf.format(rs.getTimestamp("date"));
		%>
				<div class="comment" data-comment-id="<%= commentID %>" data-date="<%= rs.getTimestamp("date").toInstant().toString() %>">
					<div class="comment-header">
						<div class="user">
							<strong><%= rs.getString("commentName") %></strong>
						</div>
						<div class="stars"><%= stars %></div>
					</div>
					<div class="comment-body">
						<%= rs.getString("content") %>
					</div>
					<div class="comment-footer">
						<div></div>
						<div class="comment-date"><%= dateOnly %></div>
					</div>
				</div>
		<%
				}
				rs.close();
				stmt.close();
				conn.close();
			} catch (Exception e) {
				out.println("<p style='color:red;'>留言顯示錯誤：" + e.getMessage() + "</p>");
			}
		%>
		</div>

		<%
			int totalPages = (int) Math.ceil(totalCount / (double) pageSize);
		%>
		<div class="pagination">
			<% for (int i = 1; i <= totalPages; i++) { %>
				<a href="comment.jsp?page=<%= i %>" class="<%= (i == pageParam) ? "current-page" : "" %>"><%= i %></a>
			<% } %>
		</div>

        <script>
			const isLoggedIn = <%= (session.getAttribute("memberID") != null) ? "true" : "false" %> === "true";


			function showCommentForm() {
				if (!isLoggedIn) {
					alert("請先登入帳號才能留言！");
					const redirectUrl = "comment.jsp?showModal=true";
					window.location.href = "login.jsp?redirect=" + encodeURIComponent(redirectUrl);
				} else {
					document.getElementById("modal").style.display = "flex";
				}
			}

			document.addEventListener("DOMContentLoaded", function () {
				const urlParams = new URLSearchParams(window.location.search);
				const showModal = urlParams.get("showModal");

				if (showModal === "true" && isLoggedIn) {
					document.getElementById("modal").style.display = "flex";
				}

				const modal = document.getElementById('modal');
				document.getElementById('closeModal').onclick = () => {
					modal.style.display = 'none';
				};
				document.getElementById('openModal').onclick = () => {
					modal.style.display = 'flex';
				};
			});

            function sortComments(criteria) {
				const board = document.getElementById('comments-board');
				const commentsList = document.getElementById('comments-list'); // 改用這個容器
				const comments = Array.from(commentsList.querySelectorAll('.comment'));

				const sorted = comments.sort((a, b) => {
					if (criteria === 'newest') {  // 對應HTML
						return new Date(b.getAttribute('data-date')) - new Date(a.getAttribute('data-date'));
					} else if (criteria === 'oldest') {
						return new Date(a.getAttribute('data-date')) - new Date(b.getAttribute('data-date'));
					} else if (criteria === 'likes') {
						return parseInt(b.getAttribute('data-likes')) - parseInt(a.getAttribute('data-likes'));
					}
					return 0;
				});

				// 清空comments-list，再依排序結果加入
				commentsList.innerHTML = '';
				sorted.forEach(comment => {
					commentsList.appendChild(comment);
				});
			}

            // 修正點擊下拉選單時的事件綁定
            function toggleDropdown() {
				const dropdown = document.getElementById('sort-dropdown');
				dropdown.style.display = dropdown.style.display === 'block' ? 'none' : 'block';
			}
			// 確保點擊排序選項後隱藏下拉選單
			document.querySelectorAll('#sort-dropdown a').forEach(option => {
				option.addEventListener('click', () => {
					document.getElementById('sort-dropdown').style.display = 'none';
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
            const stars = document.querySelectorAll('#starRating span');
			const rateInput = document.getElementById('rateInput');

			stars.forEach(star => {
			  star.addEventListener('click', () => {
				const value = star.getAttribute('data-value');
				rateInput.value = value;

				// 清除原有選取
				stars.forEach(s => s.classList.remove('selected'));
				// 加上選取效果
				for (let i = 0; i < value; i++) {
					stars[i].classList.add('selected');
				}
			  });
			});
			
			function validateStar() {
			  if (rateInput.value === "") {
			    alert("請選擇評價星等！");
			    return false;
			  }
			  return true;
		    }
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
            function updateRating() {
                // 計算新的平均星級
                const avg = ratings.reduce((sum, count, i) => sum + count * (5 - i), 0) / totalReviews;
                // 更新平均星級文字
                const averageRating = document.getElementById('averageRating');
                averageRating.textContent = `★★★★★ ${avg.toFixed(1)}星`;
                // 更新「總評價數量」
                const totalReviewsElement = document.querySelector('.rating-summary > div');
                totalReviewsElement.textContent = `${totalReviews}則評價`;
                // 更新長條圖
                document.querySelectorAll('.bar-fill').forEach(bar => {
                    const star = parseInt(bar.getAttribute('data-star')); // 取得星級
                    const index = 5 - star; // 對應到 `ratings` 陣列的索引
                    const percentage = (ratings[index] / totalReviews) * 100;
                    // 更新寬度
                    bar.style.width = `${percentage}%`;
                    // 更新旁邊的百分比文字
                    const percentageText = bar.parentElement.nextElementSibling;
                    percentageText.textContent = `${Math.round(percentage)}%`;
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
                newComment.setAttribute('data-date', new Date().toISOString());
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
                        <div class="stars">${'★'.repeat(stars)}</div>
                    </div>
                    <div class="comment-body">${commentText}</div>
                    <div class="comment-footer">
                        <button class="like-button" onclick="toggleLike(this)">
                            <span class="like-icon">
                                <iconify-icon icon="material-symbols:thumb-up-outline" width="28" height="28"></iconify-icon>
                            </span>
                            <span class="like-count">0</span>
                        </button>
                        <div class="comment-date">${new Date().toLocaleDateString()}</div>
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
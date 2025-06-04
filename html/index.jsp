<%@page contentType="text/html" %>
    <%@ page import="java.sql.*" %>
        <%@ page import="java.util.Random" %>

            <%@page pageEncoding="utf-8" %>
                <%@page import="java.util.*" %>
                    <% int counter=0; String strNo="" ; if (application.getAttribute("counter")==null) {
                        counter=9999990; application.setAttribute("counter", String.valueOf(counter)); } else {
                        strNo=(String) application.getAttribute("counter"); counter=Integer.parseInt(strNo); } if
                        (session.isNew()) { counter++; application.setAttribute("counter", String.valueOf(counter)); }
                        %>

                        <!DOCTYPE html>
                        <html lang="en">

                        <head>
                            <meta charset="UTF-8">

                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>紓咖修息棧</title>
                            <script src="https://code.iconify.design/iconify-icon/2.1.0/iconify-icon.min.js"></script>
                            <link href="https://fonts.googleapis.com/css2?family=Tajawal:wght@500&display=swap"
                                rel="stylesheet">
                            <link href="https://fonts.googleapis.com/css2?family=Russo+One&display=swap"
                                rel="stylesheet">
                            <link href="https://fonts.googleapis.com/css2?family=Kalam:wght@700&display=swap"
                                rel="stylesheet">
                            <link href="https://fonts.googleapis.com/css2?family=Jura:wght@600&display=swap"
                                rel="stylesheet">
                            <link
                                href="https://fonts.googleapis.com/css2?family=Arima:wght@100..700&family=LXGW+WenKai+Mono+TC&family=Ma+Shan+Zheng&display=swap"
                                rel="stylesheet">
                            <meta name="viewport" content="width=device-width, initial-scale=1">
                            <style>
                                @import url("../css/navBar.css");
                                @import url('../css/coffee.css');
                            </style>
                            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                            <style>
                                .text {
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    height: 70px;
                                    width: 400px;
                                    background-color: #532119;
                                    font-size: 28px;
                                    font-weight: bolder;
                                    font-family: 'Kalam', cursive;
                                    border-radius: 10px;
                                    color: white;
                                    margin: 30px auto;
                                    /* ✅ 關鍵：水平置中 */
                                    gap: 10px;
                                }

                                .text2 {
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    height: 70px;
                                    width: 400px;
                                    background-color: #532119;
                                    font-size: 28px;
                                    font-weight: bolder;
                                    font-family: 'Kalam', cursive;
                                    border-radius: 10px;
                                    color: white;
                                    margin-top: 80px;
                                    margin-left: 10px;

                                }

                                .marquee-wrapper {
                                    position: relative;
                                    width: 80%;
                                    margin: 20px auto;
                                    height: 40px;
                                }

                                .marquee-icon {
                                    position: absolute;
                                    left: -40px;
                                    top: 50%;
                                    transform: translateY(-50%);
                                    z-index: 2;
                                }

                                .marquee1 {
                                    background-color: #fcfcfc;
                                    height: 100%;
                                    overflow: hidden;
                                    display: flex;
                                    align-items: center;
                                    position: relative;
                                    z-index: 1;
                                    padding-left: 10px;
                                }

                                .marquee-track {
                                    display: inline-flex;
                                    min-width: 200%;
                                    white-space: nowrap;
                                    animation: scroll-loop 15s linear infinite;
                                }

                                .marquee-track span {
                                    padding-right: 80px;
                                    font-size: 22px;
                                    color: rgb(5, 21, 113);
                                    font-family: 'Kalam', cursive;
                                }

                                @keyframes scroll-loop {
                                    0% {
                                        transform: translateX(0);
                                    }

                                    100% {
                                        transform: translateX(-50%);
                                    }
                                }
                            </style>

                        </head>

                        <body>

                            <div class="hello-parent">
                                <svg class="hello-word" width="365" height="365" viewBox="0 0 365 365">
                                    <g id="H-letter">
                                        <line class="H-left-stroke" x1="17" y1="0" x2="17" y2="124" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="H-mid-stroke" x1="33" y1="62" x2="68" y2="62" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="H-right-stroke" x1="84" y1="0" x2="84" y2="124" stroke="#000"
                                            fill="none" stroke-width="34" />
                                    </g>

                                    <g id="E-letter">
                                        <line class="E-left-stroke" x1="138" y1="0" x2="138" y2="124" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="E-top-stroke" x1="154" y1="17" x2="201" y2="17" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="E-mid-stroke" x1="154" y1="62" x2="196" y2="62" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="E-bottom-stroke" x1="154" y1="107" x2="201" y2="107" stroke="#000"
                                            fill="none" stroke-width="34" />
                                    </g>

                                    <g id="L-one-letter">
                                        <line class="L-one-long-stroke" x1="17" y1="153" x2="17" y2="277" stroke="#000"
                                            fill="none" stroke-width="34" />
                                        <line class="L-one-short-stroke" x1="33" y1="260" x2="77" y2="260" stroke="#000"
                                            fill="none" stroke-width="34" />
                                    </g>

                                    <g id="L-two-letter">
                                        <line class="L-two-long-stroke" x1="104" y1="153" x2="104" y2="277"
                                            stroke="#000" fill="none" stroke-width="34" />
                                        <line class="L-two-short-stroke" x1="120" y1="260" x2="164" y2="260"
                                            stroke="#000" fill="none" stroke-width="34" />
                                    </g>

                                    <g id="O-letter">
                                        <circle class="O-stroke" cx="231" cy="215" r="48" stroke="#000" fill="none"
                                            stroke-width="31" />
                                    </g>
                                </svg>
                            </div>

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
                                            <li><a href="comment.html">留言板</a></li>
                                            <li><a href="contact.html">意見箱</a></li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="icon">
                                    <ul>
                                        <li>
                                            <a href="login.jsp">
                                                <iconify-icon icon="bi:people-circle" width="30px"
                                                    height="30px"></iconify-icon>
                                            </a>
                                        </li>

                                        <li>
                                            <a href="cart.jsp">
                                                <iconify-icon icon="guidance:shop" width="30px"
                                                    height="30px"></iconify-icon>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </nav>

                            <div>
                                <div class="text">
                                    <iconify-icon icon="ic:baseline-home" width="28" height="28"></iconify-icon>
                                    您是第<%=counter %>位貴客！
                                </div>


                                <div class="marquee-wrapper">
                                    <div class="marquee-icon">
                                        <iconify-icon icon="noto-v1:new-button" width="40" height="40" color:
                                            #fe0000;></iconify-icon>
                                    </div>
                                    <div class="marquee1">
                                        <div class="marquee-track">
                                            <span>☕ 咖啡買一送一限時開跑，邀你與摯友共享每日的第一口香醇，在繁忙中也能找到專屬於彼此的溫柔片刻。</span>
                                            <span>🎉 母親節場地預約熱烈進行中，用一場精心準備的相聚時光，向那位始終如一守護我們的媽媽，說聲謝謝。</span>
                                            <span>🧘‍♀️ 瑜珈課程買五送一，無論是初次踏入或已熟悉這份靜定，都邀請你為身心開啟一段溫柔且持續的自我對話。</span>
                                            <!-- ✅ 重複一次 -->
                                            <span>☕ 咖啡買一送一限時開跑，邀你與摯友共享每日的第一口香醇，在繁忙中也能找到專屬於彼此的溫柔片刻。</span>
                                            <span>🎉 母親節場地預約熱烈進行中，用一場精心準備的相聚時光，向那位始終如一守護我們的媽媽，說聲謝謝。</span>
                                            <span>🧘‍♀️ 瑜珈課程買五送一，無論是初次踏入或已熟悉這份靜定，都邀請你為身心開啟一段溫柔且持續的自我對話。</span>
                                        </div>
                                    </div>
                                </div>

                            </div>

                            </div>
                            <div class="dm">
                                <div class="ldm">
                                    <div class="text">
                                        <iconify-icon icon="ic:baseline-home" width="28" height="28"></iconify-icon>
                                        最新活動
                                    </div>
                                    <div class="carousel">
                                        <!-- 導航按鈕 -->
                                        <div class="carousel__nav">
                                            <span id="moveLeft" class="carousel__arrow">
                                                <svg class="carousel__icon" viewBox="0 0 24 24">
                                                    <path
                                                        d="M20,11V13H8L13.5,18.5L12.08,19.92L4.16,12L12.08,4.08L13.5,5.5L8,11H20Z">
                                                    </path>
                                                </svg>
                                            </span>
                                            <span id="moveRight" class="carousel__arrow">
                                                <svg class="carousel__icon" viewBox="0 0 24 24">
                                                    <path
                                                        d="M4,11V13H16L10.5,18.5L11.92,19.92L19.84,12L11.92,4.08L10.5,5.5L16,11H4Z">
                                                    </path>
                                                </svg>
                                            </span>
                                        </div>
                                        <!-- 幻燈片 -->
                                        <div class="carousel-item active">
                                            <div class="carousel-item__image"
                                                style="background-image: url(../img/0028.png);">
                                            </div>
                                            <div class="carousel-item__info">
                                                <h2 class="carousel-item__subtitle">12/19（四） 19:00-20:30</h2>
                                                <a href="act.html#Xmas2">
                                                    <h1 class="carousel-item__title">瑜伽聖誕聚會</h1>
                                                </a>
                                                <p class="carousel-item__description">歡迎紓咖瑜伽課學員一起來玩喔！
                                                    來場輕鬆歡樂的一堂課，我們有小小的禮物送給參與的同學喔！課後一起吃小點心、喝喝茶飲、聊聊天。
                                                </p>
                                                <p class="carousel-item__btn">參與費用$350元（週四班同學另計）</p>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="carousel-item__image"
                                                style="background-image: url('../img/0029.png');">
                                            </div>
                                            <div class="carousel-item__info">
                                                <h2 class="carousel-item__subtitle">12/24（二）19:30</h2>
                                                <a href="act.html#Xmas3">
                                                    <h1 class="carousel-item__title">聖誕舞會</h1>
                                                </a>
                                                <p class="carousel-item__description">上完課下來吃吃喝喝，大家也可以帶小點心來分享～ <br>
                                                    還有還有，會抽小禮物喔！ 觀望當代舞很久的左鄰右舍快來玩～</p>
                                                <p class="carousel-item__btn">當天體驗課程只收350元噢！</p>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="carousel-item__image"
                                                style="background-image: url('../img/0091.png');">
                                            </div>
                                            <div class="carousel-item__info">
                                                <h2 class="carousel-item__subtitle">12/27（五）21:00-23:00</h2>
                                                <a href="act.html#Xmas4">
                                                    <h1 class="carousel-item__title">解憂咖啡</h1>
                                                </a>
                                                <p class="carousel-item__description">
                                                    我相信，每個人身上的傷需要的時間都不一樣，所以我認為，你知道你好了，你能夠坦然跟大家說了，那再分享就可以了。</p>
                                                <p class="carousel-item__btn">400元/人</p>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="carousel-item__image"
                                                style="background-image: url('../img/0040.PNG');">
                                            </div>
                                            <div class="carousel-item__info">
                                                <h2 class="carousel-item__subtitle">12/29（日） 14:00-16:30</h2>
                                                <a href="storytelling.html#book">
                                                    <h1 class="carousel-item__title">紓咖說書</h1>
                                                </a>
                                                <p class="carousel-item__description">
                                                    生存的十二條法則
                                                    以深刻洞見與實用建議，揭示面對混亂世界的指引。書中十二條原則，幫助讀者找到秩序、意義與自我成長的方向。
                                                </p>
                                                <p class="carousel-item__btn">$250元/人</p>
                                            </div>
                                        </div>
                                        <div class="carousel-item">
                                            <div class="carousel-item__image"
                                                style="background-image: url('../img/0021.png');">
                                            </div>
                                            <div class="carousel-item__info">
                                                <h2 class="carousel-item__subtitle">12/14（六）10:30~17:00</h2>
                                                <h2 class="carousel-item__subtitle">12/15（日） 10:30~13:00</h2>
                                                <a href="act.html#Xmas1">
                                                    <h1 class="carousel-item__title">耶誕花藝</h1>
                                                </a>
                                                <p class="carousel-item__description">一起動手打造屬於自己的聖誕</p>
                                                <p class="carousel-item__btn">3280元/人</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="rdm">
                                    <div class="text">
                                        <iconify-icon icon="ic:baseline-home" width="28" height="28"></iconify-icon>
                                        最新優惠
                                    </div>
                                    <div class="ad-image">
                                        <% String adHTML="" ; try { Class.forName("com.mysql.cj.jdbc.Driver"); String
                                            url="jdbc:mysql://localhost:3306/ad?serverTimezone=UTC" ; Connection
                                            con=DriverManager.getConnection(url, "root" , "1234" ); if (!con.isClosed())
                                            { Statement stmt=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
                                            ResultSet.CONCUR_READ_ONLY); stmt.execute("USE `ad1`"); ResultSet
                                            countRs=stmt.executeQuery("SELECT * FROM `randad`"); countRs.last(); int
                                            n=countRs.getRow(); countRs.close(); if (n> 0) {
                                            int current_adid = new Random().nextInt(n) + 1;

                                            ResultSet rs = stmt.executeQuery("SELECT * FROM `randad` WHERE `adid`=" +
                                            current_adid);

                                            if (rs.next()) {

                                            String imgPath = request.getContextPath() + "/期末/image1/" + rs.getString(3);
                                            String link = rs.getString(4);
                                            String altText = rs.getString(5);

                                            adHTML = "<a href='https://" + link + "'>" +
                                                "<img class='ad-img' src='" + imgPath + "' alt='" + altText + "'>" +
                                                "</a>";
                                            }
                                            rs.close();
                                            } else {
                                            adHTML = "<p style='color:red;'>目前沒有任何廣告資料。</p>";
                                            }

                                            stmt.close();
                                            }

                                            con.close();
                                            } catch (Exception e) {
                                            adHTML = "<p style='color:red;'>載入廣告失敗：" + e.getMessage() + "</p>";
                                            }
                                            out.println(adHTML);
                                            %>
                                    </div>

                                </div>

                            </div>


                            <div class="text2">成員心得</div>
                            <div class="member">
                                <div class="background2">
                                    <div class="content">
                                        <div class="flip2">
                                            <div class="inner">
                                                <div class="front">
                                                    <img
                                                        src="https://images.unsplash.com/photo-1721622560183-4172c8ef8934?q=80&w=2030&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
                                                </div>
                                                <div class="back">
                                                    <p>11244201游英妮</p>
                                                </div>

                                            </div>
                                        </div>
                                        <p>
                                            這堂課的期末專案，是我們需要以小組形式製作一個完整的電商網站，這個挑戰可以說是非常龐大，涉及到前端設計、資料串接和功能實現、甚至是部分後端等多個部分，我們小組從一個多月前就開始分工與討論，每位組員都對專案設計提供了的想法，也都非常積極討論、設計網頁的版面，此外也都有在預定的時間內完成自己的進度。<br>
                                            我認為最困難的部分，就是最後統合每一位組員製作的部分，因為每個組員編輯的電腦大小都不一樣，難免會有在其他人版面開啟後跑版的情形，或者是在其他人開啟後不能使用的情況，在無數次的修改與測試之後，我們最終成功將各部分的功能串接起來，完成了電商網站。
                                        </p>
                                    </div>
                                </div>

                                <div class="background2">
                                    <div class="content">
                                        <div class="flip2">
                                            <div class="inner">
                                                <div class="front">
                                                    <img
                                                        src="https://images.unsplash.com/photo-1667599611951-7e27a50f690e?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
                                                </div>
                                                <div class="back">
                                                    <p>11244202游婷喻</p>
                                                </div>
                                            </div>
                                        </div>
                                        <p>
                                            這次的期末專題,是跟組員合作製作一個購物網站,我們是跟一個咖啡店家合作,我是負責商品跟購物車的前端製作,我自己一開始遇到的困難是json抓取商品到對應購買介面,好在最後有製作出來,只是商品加入到購物車還不太成熟,之後再製作後端會精進自己的技術。另外,在這個過程中，我學到了團隊合作的重要性，特別是在分工和協調方面。每個組員都在不同的職責上發揮專長，讓整個專案得以順利推進。<br>
                                        </p>
                                    </div>
                                </div>
                                <div class="background2">
                                    <div class="content">
                                        <div class="flip2">
                                            <div class="inner">
                                                <div class="front">
                                                    <img
                                                        src="https://images.unsplash.com/photo-1670739368045-7f09844fc862?q=80&w=1963&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
                                                </div>
                                                <div class="back">
                                                    <p>11244239林孟亭</p>
                                                </div>
                                            </div>
                                        </div>
                                        <p>
                                            與組員合作製作一個網站是一次充滿挑戰但非常有收穫的經歷。在這個過程中，我學到了團隊合作的重要性，特別是在分工和協調方面。每個組員都在不同的職責上發揮專長，例如設計、前端開發或內容撰寫，讓整個專案得以順利推進。<br>
                                            透過這次專案，我對HTML語法有了更深入的了解，尤其是如何利用HTML結構化地展示內容，並搭配CSS進行版面設計，讓網站不僅功能完整，還具有吸引力。此外，我們也嘗試很多上課沒有學到的新功能，這需要不少時間研究I，並確保網站的流暢和用戶體驗。<br>
                                            雖然過程中遇到了一些困難，比如設計與功能需求的取捨，或是程式碼的調整，但每一次挑戰都讓我對網站開發有更多的認識，也讓團隊更加凝聚。這次專案不僅提升了我的技術能力，還教會了我解決問題的耐心與創意。
                                        </p>
                                    </div>
                                </div>
                                <div class="background2">
                                    <div class="content">
                                        <div class="flip2">
                                            <div class="inner">
                                                <div class="front">
                                                    <img
                                                        src="https://images.unsplash.com/photo-1629953428887-4226e677e91b?q=80&w=1936&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D">
                                                </div>
                                                <div class="back">
                                                    <p>11244240李怡萱</p>
                                                </div>
                                            </div>
                                        </div>
                                        <p>
                                            在期末專案中，我與小組合作製作了一個電商網站，這對我來說既新鮮又充滿挑戰。在網站製作的過程中，我遇到了一些程式設計的困難，但也因此學會如何在網路上搜尋與參考資料，並向同學與助教請教，逐漸理解程式的用法。<br>
                                            <br>我們小組每週都會安排時間討論，制定明確的進度與目標，透過一次次的累積，最終完成了一個完整的專案。這次經驗不僅有趣，還讓我學到了很多實用的技能與合作的價值。
                                        </p>
                                    </div>
                                </div>
                            </div>


                            <!------------>
                            <footer>

                                <div class="footer-container">
                                    <div class="left-section">
                                        <div class="social-icons">
                                            <a href="https://www.facebook.com/relaxshuca">
                                                <iconify-icon class="icon1" icon="entypo-social:facebook" width="50"
                                                    height="50"></iconify-icon>
                                            </a>
                                            <span>紓咖</span>
                                            <a href="https://www.instagram.com/cominghsu_/?hl=zh-tw">
                                                <iconify-icon class="icon1" icon="formkit:instagram" width="50"
                                                    height="50"></iconify-icon>
                                            </a>
                                            <span>cominghsu</span>
                                            <iconify-icon class="icon1" icon="el:phone-alt" width="50"
                                                height="50"></iconify-icon>
                                            <span>0911305010</span>
                                        </div>
                                        <div>
                                            <iconify-icon icon="maki:marker" style="color: #d22c0d" width="30"
                                                height="30"></iconify-icon>
                                            地址：320桃園市中壢區環中東路357-1號
                                        </div>

                                    </div>
                                    <div class="right-section">
                                        <iframe
                                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.138166658024!2d121.25174567499147!3d24.961413377863547!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3468232a47f00ba3%3A0xa4ae5602976d050a!2z57ST5ZKWIOS_ruaBr-ajpw!5e0!3m2!1szh-TW!2stw!4v1733113194746!5m2!1szh-TW!2stw"
                                            allowfullscreen="" loading="lazy"
                                            referrerpolicy="no-referrer-when-downgrade">
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
                                        © 2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION
                                        MANAGEMENT&emsp;&emsp;&emsp;&emsp;&emsp;©
                                        2020.紓咖修息棧 All Rights Reserved 網頁設計 ‧ CYCU IMFORMATUION MANAGEMENT
                                    </div>
                                </div>
                            </footer>


                            <script src="../js/coffee.js"></script>

                        </body>

                        </html>
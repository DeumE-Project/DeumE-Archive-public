<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/common/css/style.css"/>
</head>
<body>
<div class="wrapper">
    <div id="header"></div>


    <div class="contents">
        <div class="search_wrap pt0">

            <div class="content_box">
                <div class="gallery_section">

                    <p class="search_results">꾸러미</p>

                    <div class="search_top_btns">
                        <ul class="tab_btn">
                            <li class="active"><a href="#none">전체</a></li>
                        </ul>
                    </div>

                    <style>
                        .fade-in{opacity:1;animation-name:fadeInOpacity;animation-iteration-count:1;animation-timing-function:ease-in;animation-duration:0.5s;}
                        .fade-out{opacity:0;animation-name:fadeOutOpacity;animation-iteration-count:1;animation-timing-function:ease-in;animation-duration:0.5s;}
                        @keyframes fadeInOpacity{
                            0%{opacity:0;}
                            100%{opacity:1;}
                        }
                        @keyframes fadeOutOpacity{
                            0%{opacity:0;}
                            100%{opacity:1;}
                        }
                    </style>
                    <ul class="gallery_content" id="galleryContent">
                        <c:forEach items="${thumbnailList}" var="thumb">
                            <li class="fade-in thumb-item" data-idx="${thumb.packagesIdx}">
                                <img src="${thumb.presignedUrl}" alt="이미지">
                                <div class="hover_content">
                                    <div class="check_box">
                                        <label for="${thumb.packagesIdx}"><c:out value="${thumb.name}"/></label>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <p id="msg-loading"></p>
                </div>
            </div>
        </div>
    </div>
    <!--// contents -->

    <!-- footer -->
    <div id="footer"></div>
    <!--// footer -->
</div>

<a href="#none" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top">TOP</a>
</body>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>
<script>
    let oneDownload = false;
    let zipDownload = false;

    function getFormattedCurrentTime() {
        const now = new Date();
        const year = now.getFullYear()
        const month = String(now.getMonth() + 1).padStart(2, '0')
        const day = String(now.getDate()).padStart(2, '0')
        const hours = String(now.getHours()).padStart(2, '0')
        const minutes = String(now.getMinutes()).padStart(2, '0')
        const seconds = String(now.getSeconds()).padStart(2, '0')

        const formattedTime = year + month + day + '_' + hours + minutes + seconds
        return formattedTime
    }

    $('.thumb-item').on('click', function(e) {
        location.href = '/packages/detailPackages/' + e.currentTarget.dataset.idx
    })

</script>
</html>
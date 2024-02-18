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

<div class="wrapper">
    <div id="header"></div>

    <!-- contents -->
    <div class="contents">
        <div class="search_wrap pt0">
            <!-- 230207 :: .search_section 삭제-->
            <div class="content_box">
                <div class="gallery_section">
                    <!-- 230127 :: 타이틀 및 카테고리 위치수정 -->
                    <p class="search_results">콘텐츠</p>

                    <div class="search_top_btns">
                        <ul class="tab_btn">
                            <li class="active"><a href="#none">전체</a></li>
                        </ul>
                        <ul class="ico_btn">
                            <li>
                                <a href="#none" class="i_btn" data-target="missingInfo">
                                    <i class="ico_down"></i>
                                    <span class="speech_bubble">다운로드</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <ul class="gallery_content" id="galleryContent">
                        <c:forEach items="${thumbnailList}" var="thumb">
                            <li class="fade-in thumb-item" data-idx="${thumb.videoIdx}">
                                <img src="${thumb.presignedUrl}" alt="이미지">
                                <div class="hover_content">
                                    <div class="check_box">
                                        <input type="checkbox" id="${thumb.videoIdx}" value="${thumb.videoIdx}">
                                        <label for="${thumb.videoIdx}"><c:out value="${thumb.name}"/></label>
                                    </div>
                                    <ul class="ico_btn">
                                        <li>
                                            <a href="#none" class="img_download" data-target="missingInfo">
                                                <i class="ico_down" data-idx="${thumb.videoIdx}"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${empty thumbnailList}">
                            <h1>등록된 '비디오'가 없습니다</h1>
                        </c:if>
                    </ul>
                    <p id="msg-loading"></p>
                </div>
            </div>
        </div>
        <!-- popup -->
        <!-- 다운로드 버튼 클릭 시 -->
        <div class="modal" id="missingInfo">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">해당 사이트의 모든 게시물의 저작권은 당사에 있으며,<br class="mo_none"> 무단 복제나 도용은 저작권법에 의해 금지되어 있습니다. </p>
                <div class="btn_wrap">
                    <a href="#" class="btn" data-idx="" data-saved="" id="confirm-btn">확인</a>
                    <a href="#" class="btn outline" id="cancel-btn">취소</a>
                </div>
                <a href="#none" class="modal_close" data-dismiss="modal">
                    <img src="/common/images/ico_pop_close.png" alt="close">
                </a>
            </div>
        </div>
    </div>
    <!--// contents -->

    <!-- footer -->
    <div id="footer"></div>
    <!--// footer -->
</div>

<a href="#none" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top">TOP</a>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>
<script src="/common/js/video/videoList.js"></script>

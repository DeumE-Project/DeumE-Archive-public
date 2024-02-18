<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/common/css/style.css"/>
</head>
<body>
<div class="wrapper">
    <div id="header"></div>

    <!-- contents -->
    <div class="contents">
        <div class="search_wrap pt0">
            <!-- 230207 :: .search_section 삭제-->
            <div class="content_box">
                <div class="gallery_section">
                    <!-- 230127 :: 타이틀 및 카테고리 위치수정 -->
                    <p class="search_results">템플릿</p>

                    <div class="search_top_btns">
                        <ul class="tab_btn">
                            <li class="active"><a href="#none">전체</a></li>
                        </ul>
                    </div>
                    <ul class="gallery_content" id="galleryContent">
                        <c:forEach items="${thumbnailList}" var="thumb" varStatus="loop">
                            <li class="fade-in thumb-item" data-idx="${thumb.templateIdx}">
                                <img src="${thumb.presignedUrl}" alt="이미지">
                                <div class="hover_content">
                                    <div class="check_box">
                                        <label for="${thumb.templateIdx}" style="color: white;"><c:out value="${thumb.name}"/></label>
                                    </div>
                                    <ul class="ico_btn">
                                        <li>
                                            <a href="#none" class="img_download" data-target="missingInfo">
                                                <i class="ico_down" data-idx="${thumb.templateIdx}" data-saved="${thumb.mainSaved}"
                                                    data-original="${thumb.mainOriginal}"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </c:forEach>
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
                <p class="pop_msg">해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,<br class="mo_none"> 무단 복제나 도용은 저작권법에 의해 금지되어 있습니다. </p>
                <div class="btn_wrap">
                    <a href="#none" class="btn" data-idx="" data-saved="" id="confirm-btn">확인</a>
                    <a href="" class="btn outline">취소</a>
                </div>
                <a href="javascript:void(0)" class="modal_close" data-dismiss="modal">
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
</body>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>
<script>
    $('.thumb-item').on('click', function(e) {
        location.href = '/template/detail/' + e.currentTarget.dataset.idx
    })

    $('.ico_down').on('click', function(e) {
        console.log(e.currentTarget.dataset.idx)
        console.log(e.currentTarget.dataset.saved)
        console.log(e.currentTarget.dataset.original)
        document.getElementById('confirm-btn').dataset.idx = e.currentTarget.dataset.idx
        document.getElementById('confirm-btn').dataset.saved = e.currentTarget.dataset.saved
        document.getElementById('confirm-btn').dataset.original = e.currentTarget.dataset.original
    })

    // 다운로드
    $('#confirm-btn').on('click', function(e) {
        e.preventDefault()
        console.log('confirm-btn clicked!')
        $.ajax({
            type: 'post',
            url: '/basic/download',
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            data: JSON.stringify({
                path: 'template/',
                fileNameWithUUID: e.currentTarget.dataset.saved
            }),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                console.log(this)
                const originalFileName = e.currentTarget.dataset.original
                // Convert the Byte Data to BLOB object
                const blob = new Blob([data], {type: "application/octet-stream"})

                // Check the Browser type
                const isIE = false || !!document.documentMode
                if (isIE) {
                    window.navigator.msSaveBlob(blob, originalFileName)
                } else {
                    const url = window.URL || window.webkitURL
                    link = url.createObjectURL(blob)
                    const a = $("<a />")
                    a.attr("download", originalFileName)
                    a.attr("href", link)
                    $("body").append(a)
                    a[0].click()
                    $("body").remove(a)
                }
                console.log('template main file download success!')
                $('.modal_close').click()
            },
            error: function (err) {
                console.log('template main file download error!')
            }
        })
    })
</script>
</body>
</html>

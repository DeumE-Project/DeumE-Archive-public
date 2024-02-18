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
                            <li class="fade-in thumb-item" data-idx="${thumb.contentsIdx}">
                                <img src="${thumb.presignedUrl}" alt="이미지">
                                <div class="hover_content">
                                    <div class="check_box">
                                        <input type="checkbox" id="${thumb.contentsIdx}" value="${thumb.contentsIdx}">
                                        <label for="${thumb.contentsIdx}"><c:out value="${thumb.name}"/></label>
                                    </div>
                                    <ul class="ico_btn">
                                        <li>
                                            <a href="#none" class="img_download" data-target="missingInfo">
                                                <i class="ico_down" data-idx="${thumb.contentsIdx}"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </c:forEach>
                        <c:if test="${empty thumbnailList}">
                            <h1>등록된 '콘텐츠'가 없습니다</h1>
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
                <p class="pop_msg">해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,<br class="mo_none"> 무단 복제나 도용은 저작권법에 의해 금지되어 있습니다. </p>
                <div class="btn_wrap">
                    <a href="#" class="btn" data-idx="" id="confirm-btn">확인</a>
                    <a href="#" class="btn outline" id="cancel-btn">취소</a>
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
    let oneDownload = false;

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
        location.href = '/contents/detail/' + e.currentTarget.dataset.idx
    })

    $('.ico_down').on('click', function(e) {
        oneDownload = false
        const contentsIdx = e.currentTarget.dataset.idx
        console.log(contentsIdx)
        document.getElementById('confirm-btn').dataset.idx = contentsIdx
        if (contentsIdx) {
            oneDownload = true
        }
    })

    $('#confirm-btn').on('click', function(e) {
        if (oneDownload) {
            const contentsIdx = e.currentTarget.dataset.idx
            console.log(contentsIdx)
            downloadOneFile(contentsIdx)
        } else {
            const contentsIdxList = []
            $('input[type="checkbox"]:checked').each((index, item) => contentsIdxList.push($(item).val()));
            if (!contentsIdxList.length) {
                alert('체크 후 다운로드 버튼 클릭해주세요')
                return
            }
            downloadZipFile(contentsIdxList)
        }
    })

    function downloadOneFile(contentsIdx) {
        console.log('contentsIdx: ' + contentsIdx)
        $.ajax({
            type: 'post',
            url: '/contents/download-from-list',
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            data: JSON.stringify({
                contentsIdx: contentsIdx
            }),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                console.log(data)
                const blob = new Blob([data], {type: "application/octet-stream"})
                const isIE = false || !!document.documentMode
                const currTime = getFormattedCurrentTime()
                if (isIE) {
                    window.navigator.msSaveBlob(blob, currTime + '.jpg')
                } else {
                    const url = window.URL || window.webkitURL
                    link = url.createObjectURL(blob)
                    const a = $("<a />")
                    a.attr("download", currTime + '.jpg')
                    a.attr("href", link)
                    $("body").append(a)
                    a[0].click()
                    $("body").remove(a)
                }
                $('.modal_close').click()
            },
            error: function (err) {
                console.log('main image download error!')
            }
        })
    }

    function downloadZipFile(contentsIdxList) {
        console.log(contentsIdxList)
        $.ajax({
            type: 'post',
            url: '/contents/multi-download',
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            data: JSON.stringify({
                "contentsIdxList": contentsIdxList
            }),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                console.log(data)
                const blob = new Blob([data], {type: "application/octet-stream"})
                const isIE = false || !!document.documentMode
                const currTime = getFormattedCurrentTime()
                if (isIE) {
                    window.navigator.msSaveBlob(blob, currTime + '.zip')
                } else {
                    const url = window.URL || window.webkitURL
                    link = url.createObjectURL(blob)
                    const a = $("<a />")
                    a.attr("download", 'DeumeArchive-contents_' + currTime + '.zip')
                    a.attr("href", link)
                    $("body").append(a)
                    a[0].click()
                    $("body").remove(a)
                }
                $('.modal_close').click()
            },
            error: function (err) {
                console.log('main image download error!')
                alert('zip 파일 다운로드 오류 발생')
                $('.modal_close').click()
            }
        })
    }

    $('#cancel-btn').on('click', function (e) {
        e.preventDefault()
        $('.modal_close').click()
    })
</script>
</html>

</body>
</html>

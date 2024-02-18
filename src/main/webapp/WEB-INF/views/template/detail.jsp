<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>템플릿 상세보기</title>

    <link rel="stylesheet" type="text/css" href="/common/css/style.css"/>
    <style>
        .search_wrap.share_content {
            padding-bottom: 10px;
        }
        .contents {
            padding: 50px;
            min-height: auto;
        }
        .tag_list li {
            display: inline-block;
            height: 26px;
            padding: 0 8px;
            margin: 0 8px 5px 0;
            border-radius: 50px;
            border: 1px solid #dbdbdb;
            color: #a1a1a1;
            font-size: 14px;
            line-height: 24px;
            text-align: center;
        }
        .ico_btn > li a {
            margin-left: 25px;
        }
        .main-img-tag {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .detail_img{
            width: 100%;
            height: 390px;
            padding-bottom: 10px;
        }
        .preview_box{
            text-align: center;
        }

    </style>
    <script>
        $(document).ready(function() {
            $('.thumbnail').each(function() {
                const presignedViewRequestObj = null;
            });
        });
    </script>
</head>

<body>
    <div class="wrapper">
        <!-- header -->
        <div id="header"></div>
        <!-- header -->

        <!-- contents -->
        <div class="contents">
            <div class="search_wrap share_content">
                <div class="content_box">
                    <div class="preview_content">
                        <div class="preview_box">
                            <script>
                                const files = [];
                            </script>
                            <div class="detail_img">
                                <img id="img" src="" alt="" class="main-img-tag" onclick="change()">
                            </div>
                            <c:forEach items="${templateList}" var="thumbnail" varStatus="loop">
                                    <%-- 해당 idx의 전체 썸네일 받아오기 --%>
                                    <script>
                                        var i = 1;
                                        presignedViewRequestObj = {
                                            path: '${thumbnail.uploadPath}',
                                            fileNameWithUUID: '${thumbnail.saved}'
                                        }
                                        console.log(presignedViewRequestObj);
                                        $.ajax({
                                            type: 'post',
                                            url: '/presigned/view-url',
                                            data: JSON.stringify(presignedViewRequestObj),
                                            contentType: 'application/json; charset=utf-8',
                                            dataType: 'json',
                                            async: false,
                                            success: function (result) {
                                                if ('${loop.index}' == 0){
                                                    $('#img').attr('src',result.presignedUrl);
                                                }
                                                files.push(result.presignedUrl);
                                            },
                                            error: function (err) {
                                                console.log('ajax error!')
                                                console.log(err)
                                            }
                                        })

                                    </script>
                            </c:forEach>
                            <%-- 이미지 클릭 시 다음 이미지 보여주기 --%>
                            <script>
                                function change(){
                                    console.log(files[i]);
                                    console.log(i);
                                    $('#img').attr('src',files[i]);
                                    i++;
                                    if (files.length==i){
                                        i =0;
                                    }
                                }
                            </script>

                            <ul class="ico_btn">
                                <li>
                                    <a href="#none" class="i_btn" data-target="only-main-image" id="main-img-download-btn">
                                        <i class="ico_down"></i>
                                        <span class="speech_bubble" style="width: 140px;">다운로드</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="photo_info">
                            <ul class="photo_title">
                                <li class="info_text"><span>제목</span><p>${templateData.name}</p></li>
                                <li class="info_text"><span>출처</span><p>${templateData.source}</p></li>
                                <li class="info_text"><span>설명</span><p>${templateData.explanation}</p></li>
                                <li class="info_text"><span>카테고리</span><p id="category"></p></li>
                                <li class="info_text registDate"><span>게시일</span><p>${templateData.registerDate}</p></li>
                                <c:if test="${templateData.registerDate ne templateData.updateDate}">
                                    <li class="info_text updateDate"><span>수정일</span><p>${templateData.updateDate}</p></li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <ul class="tag_list">
                        <c:forEach items="${keywordList}" var="keyword" varStatus="loop">
                            <li>#${keyword}</li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 템플릿 메인 파일 다운로드 modal -->
        <div class="modal" id="only-main-image">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">
                    [템플릿 파일 다운로드]<br/>
                    해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,
                    <br class="mo_none">무단 복제나 도용은 저작권법에 의해 금지되어 있습니다.
                </p>
                <div class="btn_wrap">
                    <a href="" class="btn" id="confirm-btn-only">확인</a>
                    <a href="" class="btn outline">취소</a>
                </div>
                <a href="#none" class="modal_close" data-dismiss="modal">
                    <img src="/common/images/ico_pop_close.png" alt="close">
                </a>
            </div>
        </div>

        <!-- footer -->
        <div id="footer"></div>
        <!--// footer -->
    </div>

    <a href="#none" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top">TOP</a>

    <script>
        $(document).ready(function() {
            const category = '${templateData.subcateIdx}';
            $.ajax({
                type: 'get',
                url: '/template/category',
                data: {
                    'category' : category
                },
                success: function (res){
                    console.log(res)
                    console.log("카테고리 불러오기 성공")
                    $('#category').html(res)
                },
                error: function (err){
                    console.log("카테고리 불러오기 실패")
                }
            });
        });
        <%-- 시간 포맷 변경 --%>
        var time = '${templateData.registerDate}';
        var registDate = time.split('T');
        console.log(registDate);
        $('.registDate').html('<span>게시일</span><p>'+registDate[0]+' '+registDate[1]+'</p>');
        time = '${templateData.updateDate}';
        var updateDate = time.split('T');
        $('.updateDate').html('<span>수정일</span><p>'+updateDate[0]+' '+updateDate[1]+'</p>');

        // 다운로드
        $('#confirm-btn-only').on('click', function (e) {
            e.preventDefault()
            console.log('confirm-btn-only clicked!')

            $.ajax({
                type: 'post',
                url: '/basic/download',
                cache: false,
                xhrFields: {
                    responseType: 'blob'
                },
                data: JSON.stringify({
                    path: '${templateData.uploadPath}',
                    fileNameWithUUID: '${templateData.saved}'
                }),
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    console.log(this)
                    const originalFileName = '${templateData.original}'
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
                    $('.modal_close').click()
                },
                error: function (err) {
                    console.log('template main file download error!')
                }
            })
        })
    </script>
</body>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>

<script>
    // hashtag swiper
    var hashSwiper = new Swiper(".hash_swiper", {
            slidesPerView: "auto",
    });
</script>
</html>
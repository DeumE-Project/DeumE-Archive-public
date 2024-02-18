<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<head>
    <title>contents detail</title>
    <link rel="stylesheet" type="text/css" href="/common/css/style.css"/>
    <style>
        .search_wrap.share_content {
            padding-bottom: 10px;
        }

        .contents {
            padding: 0px;
            min-height: auto;
        }

        .contents.thumbnail {
            padding-top: 75px;
        }
    </style>

    <style>
        .prev,
        .next {
            cursor: pointer;
            position: absolute;
            top: 50%;
            width: auto;
            margin-top: -22px;
            padding: 16px;
            color: black;
            font-weight: bolder;
            font-size: 18px;
            transition: 0.6s ease;
            border-radius: 0 3px 3px 0;
            user-select: none;
        }

        .next {
            left: 630px;
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

        #thumbnail-img-tag,
        #main-img-tag {
            object-fit: contain;
        }
    </style>
</head>

<div class="wrapper">
    <!-- header -->
    <div id="header"></div>
    <!-- header -->

    <!-- contents -->
    <div class="contents thumbnail">
        <!-- 공유받은 콘텐츠 화면일 시 share_content 클래스 추가 해주세요 -->
        <div class="search_wrap share_content">
            <!-- 230207 :: 검색바 삭제 -->
            <div class="content_box">
                <div class="preview_content">
                    <!-- 230110 :: preview_box 클래스 추가 -->
                    <div class="preview_box">
                        <figure class="previw_img">
                            <img id="thumbnail-img-tag" src="" alt="이미지 미리보기">
                        </figure>
                        <a class="prev">&#10094;</a>
                        <a class="next">&#10095;</a>
                        <ul class="ico_btn">
                            <li>
                                <a href="#none" class="i_btn" data-target="thumbnail-included">
                                    <i class="ico_down"></i>
                                    <span class="speech_bubble" style="width: 140px;">썸네일 포함 다운로드</span>
                                </a>
                            </li>
                            <li>
                                <a href="#none" class="i_btn" data-target="only-main-image" id="main-img-download-btn">
                                    <i class="ico_down"></i>
                                    <span class="speech_bubble" style="width: 140px;">메인 사진만 다운로드</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="photo_info">
                        <ul class="photo_title">
                            <li class="info_text"><span>제목</span>
                                <p id="name"></p>
                            </li>
                            <li class="info_text"><span>출처</span>
                                <p id="source"></p>
                            </li>
                            <li class="info_text"><span>설명</span>
                                <p id="explanation"></p>
                            </li>
                        </ul>
                        <ul class="photo_route">
                            <li class="photo_group"><span>[주제]</span>
                                <p id="category">교통>항공교통수단</p>
                            </li>
                        </ul>
                        <ul class="tag_list" id="tag-list" style="margin-top: 10px;"></ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- popup -->


        <!-- 썸네일 포함 다운로드 modal -->
        <div class="modal" id="thumbnail-included">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">
                    [썸네일 포함 다운로드]<br/>
                    해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,
                    <br class="mo_none">무단 복제나 도용은 저작권법에 의해 금지되어 있습니다.
                </p>
                <div class="btn_wrap">
                    <a href="" class="btn" id="confirm-btn-included">확인</a>
                    <a href="" class="btn outline cancel-btn">취소</a>
                </div>
                <a href="#none" class="modal_close" data-dismiss="modal">
                    <img src="/common/images/ico_pop_close.png" alt="close">
                </a>
            </div>
        </div>

        <!-- 메인 이미지만 다운로드 modal -->
        <div class="modal" id="only-main-image">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">
                    [메인 이미지 다운로드]<br/>
                    해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,
                    <br class="mo_none">무단 복제나 도용은 저작권법에 의해 금지되어 있습니다.
                </p>
                <div class="btn_wrap">
                    <a href="" class="btn" id="confirm-btn-only">확인</a>
                    <a href="" class="btn outline cancel-btn">취소</a>
                </div>
                <a href="#none" class="modal_close" data-dismiss="modal">
                    <img src="/common/images/ico_pop_close.png" alt="close">
                </a>
            </div>
        </div>
    </div>


    <!-- contents -->
    <div class="contents">
        <div class="search_wrap share_content">
            <div class="content_box">
                <div class="preview_content" style="display: block; height: auto;">
                    <div class="preview_box" style="width: 100%; max-width: 100%; margin-right: 0px;">
                        <figure class="previw_img">
                            <img id="main-img-tag" src="/common/images/gallery_img/img_2.png" alt="이미지 미리보기"
                                 style="object-fit: contain;">
                        </figure>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<a href="#none" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top">TOP</a>
</div>
</body>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>

<script>
    // hashtag swiper
    var hashSwiper = new Swiper(".hash_swiper", {
        slidesPerView: "auto",
    });

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
</script>

<script>
    let slideIndex = 0;
    const thumbnailImageSrcArr = []

    $('.prev').on('click', function (e) {
        console.log('prev click')
        e.preventDefault()
        slideIndex--;
        if (slideIndex < 0) {
            slideIndex = thumbnailImageSrcArr.length - 1;
        }
        $('#thumbnail-img-tag').attr('src', thumbnailImageSrcArr[slideIndex])
    })

    $('.next').on('click', function (e) {
        console.log('next click')
        e.preventDefault()
        slideIndex++;
        if (slideIndex > thumbnailImageSrcArr.length - 1) {
            slideIndex = 0;
        }
        $('#thumbnail-img-tag').attr('src', thumbnailImageSrcArr[slideIndex])
    })
</script>

<script>
    const contentsIdx = location.href.substring(location.href.lastIndexOf('/') + 1, location.href.length)
    console.log(contentsIdx)
    $.ajax({
        type: 'get',
        url: '/contents/detail/get-info/' + contentsIdx,
        dataType: 'json',
        success: function (result) {
            console.log(result)
            fillUpContentsInformation(result)
            fillUpThumbnails(result.contentsThumbnailList)
            fillUpMainImage({
                path: result.uploadPath,
                fileNameWithUUID: result.saved
            })
        },
        error: function (err) {
            console.log(contentsIdx + " -> 정보 갖고오기 실패")
            console.log(contentsIdx)
        }
    })

    function fillUpContentsInformation(contents) {
        console.log('----------')
        console.log(contents)
        $('#name').text(contents.name)
        $('#source').text(contents.source)
        $('#explanation').text(contents.explanation)
        contents.keyword = contents.keyword.substring(0, contents.keyword.length - 1)

        const keywordList = contents.keyword.split(',')
        console.log(keywordList)
        keywordList.forEach((keyword) => {
            $('#tag-list').append('<li>' + keyword + '</li>')
        })

        $('#category').text(contents.maincateName + ' > ' + contents.subcateName)
    }

    function fillUpThumbnails(thumbnailList) {
        console.log(thumbnailList)
        thumbnailList.forEach((thumbnail) => {
            $.ajax({
                type: 'post',
                url: '/presigned/view-url',
                data: JSON.stringify({
                    path: thumbnail.uploadPath,
                    fileNameWithUUID: thumbnail.saved
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                async: false,
                success: function (result) {
                    thumbnailImageSrcArr.push(result.presignedUrl)
                },
                error: function (err) {

                }
            })
        })
        $('#thumbnail-img-tag').attr('src', thumbnailImageSrcArr[0])
    }

    function fillUpMainImage(mainImage) {
        console.log(mainImage)
        document.getElementById('confirm-btn-only').dataset.path = mainImage.path
        document.getElementById('confirm-btn-only').dataset.filenameWithUuid = mainImage.fileNameWithUUID
        $.ajax({
            type: 'post',
            url: '/presigned/view-url',
            data: JSON.stringify(mainImage),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            success: function (result) {
                $('#main-img-tag').attr('src', result.presignedUrl)
            },
            error: function (err) {
            }
        })
    }
</script>

<script>
    $('#confirm-btn-only').on('click', function (e) {
        e.preventDefault()
        console.log('confirm-btn-only clicked!')
        console.log(this.dataset.path)
        console.log(this.dataset.filenameWithUuid)
        $.ajax({
            type: 'post',
            url: '/basic/download',
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            data: JSON.stringify({
                path: this.dataset.path,
                fileNameWithUUID: this.dataset.filenameWithUuid
            }),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                console.log(this)
                const fileNameWithUUID = e.target.dataset.filenameWithUuid
                const originalFileName
                    = fileNameWithUUID.substring(fileNameWithUUID.indexOf('_') + 1, fileNameWithUUID.length)
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
                console.log('main image download error!')
            }
        })
    })
</script>

<script>
    $('#confirm-btn-included').on('click', function (e) {
        e.preventDefault()
        $.ajax({
            type: 'post',
            url: '/contents/zip',
            cache: false,
            xhrFields: {
                responseType: 'blob'
            },
            data: JSON.stringify({
                contentsIdx: contentsIdx
            }),
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                console.log(this)

                let formattedCurrentTime = getFormattedCurrentTime()
                console.log('formattedCurrentTime: ' + formattedCurrentTime)
                let zipFileName = 'DeumeArchive-contents_' + formattedCurrentTime + '.zip'

                console.log('zipFileName: ' + zipFileName)

                const blob = new Blob([data], {type: "application/octet-stream"})

                // Check the Browser type
                const isIE = false || !!document.documentMode
                if (isIE) {
                    window.navigator.msSaveBlob(blob, zipFileName)
                } else {
                    const url = window.URL || window.webkitURL
                    link = url.createObjectURL(blob)
                    const a = $("<a />")
                    a.attr("download", zipFileName)
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
    })

    $('.cancel-btn').on('click', function (e) {
        e.preventDefault()
        $('.modal_close').click()
    })
</script>
</html>

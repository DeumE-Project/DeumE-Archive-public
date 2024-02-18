<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<head>
    <title>contents detail</title>
    <link rel="stylesheet" type="text/css" href="/common/css/style.css"/>
    <link rel="stylesheet" type="text/css" href="/common/css/video/videoDetail.css"/>
   
</head>
<div class="wrapper">
    <!-- header -->
    <div id="header"></div>
    <!-- header -->

    <!-- contents -->
    <div class="video thumbnail">
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
                                <a href="#none" class="i_btn" data-target="only-video"
                                   id="video-download-btn">
                                    <i class="ico_down"></i>
                                    <span class="speech_bubble" style="width: 140px;">비디오만 다운로드</span>
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
                                <p id="source" style="white-space: normal"></p>
                            </li>
                            <li class="info_text"><span>설명</span>
                                <p id="explanation" style="white-space: normal"></p>
                            </li>
                        </ul>
                        <ul class="photo_route">
                            <li class="photo_group"><span>[주제]</span>
                                <p id="category">교통>항공교통수단</p>
                            </li>
                        </ul>
                        <ul class="tag_list" id="tag-list" style="margin-top: 10px;">
                        </ul>
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
                    해당 사이트의 모든 게시물의 저작권은 당사에 있으며,
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

        <!-- 비디오만 다운로드 modal -->
        <div class="modal" id="only-video">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">
                    [비디오 다운로드]<br/>
                    해당 사이트의 모든 게시물의 저작권은 당사에 있으며,
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
    <div class="video">
        <div class="search_wrap share_content">
            <div class="content_box">
                <div class="preview_content" style="display: block; height: auto;">
                    <div class="preview_box" style="width: 100%; max-width: 100%; margin-right: 0px;">
                        <figure class="previw_video">
                            <video id="video-tag" src="/common/images/gallery_img/img_2.png" alt="이미지 미리보기"
                                   style="object-fit: contain;" controls/>
                        </figure>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<a href="#none" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top">TOP</a>

<script src="/common/js/swiper.min.js"></script>
<script src="/common/js/script.js"></script>
<script src="/common/js/video/videoDetail.js"></script>
</html>

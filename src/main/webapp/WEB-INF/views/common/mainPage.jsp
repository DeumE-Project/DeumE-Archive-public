<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>DeumE-Archive</title>
    <link rel="icon" type="image/x-icon" href="/common/images/iconlogo.png"/>
    <link rel="stylesheet" type="text/css" href="/common/css/style.min.css" />

</head>

<body>
<div class="wrapper">
    <!-- header -->
    <div class="header_wrap">
        <div class="header main_header">
            <div class="left_sec">
                <a href="/"><h1 class="logo"></h1></a>
                <div class="search_bar_wrap" style="display: none">
                    <div class="search_bar">
                        <div class="dropdown">
                            <a href="javascript:void(0);" onclick="searchFunction()" class="dropbtn">
                                전체
                            </a>
                            <div id="searchDropdown" class="dropdown_content">
                                <!-- 230207 :: .first 추가 -->
                                <a href="javascript:void(0);">일반 이미지</a>
                                <a href="javascript:void(0);">움직이는 이미지</a>
                                <a href="javascript:void(0);">동영상</a>
                                <a href="javascript:void(0);">꾸러미</a>
                                <a href="javascript:void(0);">템플릿</a>
                            </div>
                        </div>

                        <div class="search_input_wrap">
                            <input
                                    class="search_input"
                                    type="text"
                                    placeholder="찾으시는 자료명을 입력하세요."
                            />
                        </div>
                        <a href="javascript:void(0);" class="search_btn">
                            <img src="/common/images/ico_main_search.png" alt="검색" />
                        </a>
                    </div>
                </div>
            </div>
            <div class="account">
                <div class="dropdown">
                    <a href="javascript:void(0);" onclick="loginFunction()" class="dropbtn">
                        admin<br />@gmail.com
                    </a>
                    <div id="loginDropdown" class="dropdown_content">
                        <a href="/contents/manage">일반 이미지</a>
                        <a href="/gif/list">움직이는 이미지</a>
                        <a href="/video/manageList">동영상</a>
                        <a href="/packages/listPackages">꾸러미</a>
                        <a href="/template/admin">템플릿</a>
                    </div>
                </div>
            </div>
            <!-- 230207 :: 햄버거 버튼 추가-->
            <a href="javascript:void(0);" class="mo_account" onclick="openNav()">
                <img src="/common/images/ico_ham_btn.png" alt="정보">
            </a>
            <!-- 230207 :: 우측 메뉴 추가-->
            <div class="side_nav" id="sideNav">
                <div class="nav_contents">
                    <div class="nav_top">
                        <div class="nav_header">
                            <a href="javascript:void(0);" class="close_btn" onclick="closeNav()">
                                <img src="/common/images/ico_pop_close.png" alt="close">
                            </a>
                        </div>
                        <ul class="nav_list">
                            <li><a href="javascript:void(0);"><img src="/common/images/ico_nav_home.png" alt="홈">홈</a></li>
                            <li><a href="javascript:void(0);" class="drop"><img src="/common/images/ico_nav_storage.png" alt="관리자페이지">관리자페이지</a>
                            <ul class="nav_depth">
                                <li><a href="/contents/manage">일반 이미지</a></li>
                                <li><a href="/gif/list">움직이는 이미지</a></li>
                                <li><a href="/video/manageList">동영상</a></li>
                                <li><a href="/packages/listPackages">꾸러미</a></li>
                                <li><a href="/template/admin">템플릿</a></li>
                            </ul>
                            </li>
                            <li><a href="javascript:void(0);"><img src="/common/images/ico_nav_visual.png" alt="로그아웃">로그아웃</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="backdrop" onclick="closeNav()"></div>
        </div>
    </div>
    <!-- header -->

    <!-- contents -->
    <div class="main_contents contents">
        <div class="search_section">
            <!--S: 230302 수정 -->
            <div class="img-box">
                <img src="/common/images/deume.png" alt="" />
            </div>
            <div class="search-wrap">
                <h2>더욱 특별해지는 순간</h2>
                <div class="search_bar_wrap">
                    <div class="search_bar">
                        <div class="dropdown">
                            <!-- 230207 :: 클릭 함수명 변경 -->
                            <a href="javascript:void(0);" onclick="mainSearch()" class="dropbtn">
                                전체
                            </a>
                            <!-- 230207 :: 아이디명 변경 -->
                            <div id="mainDropdown" class="dropdown_content">
                                <!-- 230207 :: .first 추가 -->
                                <a href="javascript:void(0);" class="first">전체</a>
                                <a href="javascript:void(0);">전체</a>
                                <a href="javascript:void(0);">일반 이미지</a>
                                <a href="javascript:void(0);">움직이는 이미지</a>
                                <a href="javascript:void(0);">동영상</a>
                            </div>
                        </div>
                        <div class="search_input_wrap">
                            <input
                                    class="search_input"
                                    type="text"
                                    placeholder="찾으시는 자료명을 입력하세요."
                            />
                            <ul class="search_list">
                                <li>
                                    <a class="searh_word" href="javascript:void(0);">수박</a>
                                    <a href="javascript:void(0);" class="delete"
                                    ><img src="/common/images/ico_search_delete.png" alt="삭제"
                                    /></a>
                                </li>
                            </ul>
                        </div>
                        <a href="javascript:void(0);" class="search_btn">
                            <img src="/common/images/ico_main_search.png" alt="검색" />
                        </a>
                    </div>
                </div>
                <div class="swiper hash_swiper">
                    <ul class="swiper-wrapper">
                        <li class="hashtag swiper-slide">
                            <a href="javascript:void(0);">#키워드</a>
                        </li>
                        <li class="hashtag swiper-slide">
                            <a href="javascript:void(0);">#키워드2</a>
                        </li>
                        <li class="hashtag swiper-slide">
                            <a href="javascript:void(0);">#키워드3</a>
                        </li>
                    </ul>
                </div>
            </div>
            <!--E: 230302 수정 -->
        </div>

        <!--일반 이미지-->
        <div class="gallery_section main_content">
            <div class="content_area">
                <div class="title_box first">
                    <p class="main_content_title">일반 이미지</p>
                </div>
                <ul class="gallery_content" id="galleryContent1">
                    <c:forEach items="${contentsThumbnailList}" var="contentsThumb">
                        <li class="fade-in thumb-item detail-contents" data-idx="${contentsThumb.contentsIdx}">
                            <img src="${contentsThumb.presignedUrl}" alt="이미지">
                            <div class="hover_content">
                                <div class="check_box">
                                    <input type="checkbox" id="${contentsThumb.contentsIdx}" value="${contentsThumb.contentsIdx}">
                                    <label for="${contentsThumb.contentsIdx}"><c:out value="${contentsThumb.name}"/></label>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty contentsThumbnailList}">
                        <h1>등록된 '콘텐츠'가 없습니다</h1>
                    </c:if>

                </ul>
                <a href="/contents/list" class="more_content"
                >전체 보기<i class="ico_arrow"></i
                ></a>
            </div>

            <!--230302 추천 컨텐츠 영역 .recommend_cnt 클래스 추가-->
            <!-- 움직이는 이미지 영역-->
            <div class="gallery_section main_content pb0">
                <div class="title_box first">
                    <p class="main_content_title">움직이는 이미지</p>
                    <a href="<c:url value='/gif/viewlist'/>" class="more_content"
                    >전체 보기<i class="ico_arrow"></i
                    ></a>
                </div>
                <ul class="gallery_content" id="galleryContent">
                    <c:forEach items="${gifThumbnailList}" var="gifThumb">
                        <li class="fade-in thumb-item detail-gif" data-idx="${gifThumb.gifIdx}">
                            <img src="${gifThumb.presignedUrl}" alt="이미지">
                            <div class="hover_content">
                                <div class="check_box" >
                                    <label for="${gifThumb.gifIdx}" style="color: white"><c:out value="${gifThumb.name}"/></label>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty gifThumbnailList}">
                        <h1>등록된 '움직이는 이미지'가 없습니다</h1>
                    </c:if>
                </ul>
            </div>
            <!--동영상 콘텐츠-->
            <div class="content_area">
                <div class="title_box">
                    <p class="main_content_title">동영상 콘텐츠</p>
                </div>
                <ul class="gallery_content" id="galleryContent3">
                    <c:forEach items="${videoThumbnailList}" var="videoThumb">
                        <li class="fade-in thumb-item detail-video" data-idx="${videoThumb.videoIdx}">
                            <img src="${videoThumb.presignedUrl}" alt="이미지">
                            <div class="hover_content">
                                <div class="check_box">
                                    <input type="checkbox" id="${videoThumb.videoIdx}" value="${videoThumb.videoIdx}">
                                    <label for="${videoThumb.videoIdx}"><c:out value="${videoThumb.name}"/></label>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty videoThumbnailList}">
                        <h1>등록된 '비디오'가 없습니다</h1>
                    </c:if>
                </ul>
                <a href="/video/list" class="more_content"
                >전체 보기<i class="ico_arrow"></i
                ></a>
            </div>
        </div>
    </div>
    <!--// contents -->

    <!-- 230228 :: 꾸러미 리스트 추가 -->
    <div class="gallery_section main_content pb0">
        <!-- 맨처음 타이틀 .first 클래스 추가 -->
        <div class="title_box first">
            <p class="main_content_title">꾸러미 모음</p>
            <a href="<c:url value='/packages/viewListPackages'/>" class="more_content"
            >전체 보기<i class="ico_arrow"></i
            ></a>
        </div>
        <ul class="gallery_content" id="galleryContent2">
            <c:forEach items="${packagesThumbnailList}" var="packagesThumb">
                <li class="fade-in thumb-item detail-packages" data-idx="${packagesThumb.packagesIdx}">
                    <img src="${packagesThumb.presignedUrl}" alt="이미지">
                    <div class="hover_content">
                        <div class="check_box">
                            <label for="${packagesThumb.packagesIdx}"><c:out value="${packagesThumb.name}"/></label>
                        </div>
                    </div>
                </li>
            </c:forEach>

        </ul>
    </div>

    <!-- 230228 :: 슬라이드 영역 추가 -->
    <div class="gallery_section main_content pb0">
        <div class="title_box first">
            <p class="main_content_title">템플릿 모음</p>
            <a href="<c:url value='/template/'/>" class="more_content"
            >전체 보기<i class="ico_arrow"></i
            ></a>
        </div>
                <ul class="gallery_content" id="galleryContent4">
                    <c:forEach items="${templateThumbnailList}" var="templateThumb" varStatus="loop">
                        <li class="fade-in thumb-item detail-template" data-idx="${templateThumb.templateIdx}">
                            <img src="${templateThumb.presignedUrl}" alt="이미지">
                            <div class="hover_content">
                                <div class="check_box">
                                    <label for="${templateThumb.templateIdx}" style="color: white;"><c:out value="${templateThumb.name}"/></label>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
        <div class="modal" id="missingInfo">
            <div class="modal_content alert">
                <img src="/common/images/ico_pop_alert.png" alt="알림">
                <p class="pop_msg">해당 사이트의 모든 콘텐츠의 저작권은 당사에 있으며,<br class="mo_none"> 무단 복제나 도용은 저작권법에 의해 금지되어 있습니다. </p>
                <div class="btn_wrap">
                    <a href="#none" class="btn" data-idx="" data-saved="" id="confirm-btn">확인</a>
                    <a href="#none" class="btn outline">취소</a>
                </div>
                <a href="javascript:void(0)" class="modal_close" data-dismiss="modal">
                    <img src="/common/images/ico_pop_close.png" alt="close">
                </a>
            </div>
        </div>
            </div>
    <!-- 다운로드 버튼 클릭 시 -->

        </div>
    <!-- footer -->
    <footer>
    <div id="footer">
        <div class="footer_wrap">
            <div class="terms">
                <div class="inner_cont">
                    <ul>
                        <li><a href="https://github.com/DeumE-Project/DeumE-Archive">Copyright © 천재교육 · Team DeumE</a></li>
                        <li><a href="https://github.com/wwnoov">남원우</a></li>
                        <li><a href="https://github.com/jaehyukpyon2">변재혁</a></li>
                        <li><a href="https://github.com/jiho-96">유지호</a></li>
                        <li><a href="https://github.com/LMH9999">이무현</a></li>
                        <li><a href="https://github.com/raknrak">최경락</a></li>
                    </ul>

                    <div class="family_site">
                        <div class="dropdown">
                            <a href="javascript:void(0);" onclick="familyFunction()" class="dropbtn"> Site </a>
                            <div id="familyDropdown" class="dropdown_content">
                                <a href="http://deume.kro.kr/main">DeumE-Shop</a>
                                <a href="https://github.com/DeumE-Project/DeumE-Archive">DeumE-Git</a>
                                <a href="#">DeumE-Notion</a>
                                <a href="#">DeumE-AWS</a>
                                <a href="#" class="last">Site</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // family site dropdown
            function familyFunction() {
                document.getElementById("familyDropdown").classList.toggle("show");
            }

            // Close the dropdown if the user clicks outside of it
            window.onclick = function (event) {
                if (!event.target.matches(".dropbtn")) {
                    var dropdowns = document.getElementsByClassName("dropdown_content");
                    var i;
                    for (i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains("show")) {
                            openDropdown.classList.remove("show");
                        }
                    }
                }
            };
        </script>

    </div>
    </footer>
    <!--// footer -->
</div>

<a href="javascript:void(0);" class="btn_top"><img src="/common/images/ico_main_top.png" alt="top" />TOP</a>


<!-- 주제/교과 필터링 팝업 -->
<div class="modal" id="searchFilter">
    <div class="modal_content filter">
        <div class="tab">
            <a href="javascript:void(0);"
                    button
                    class="tablinks"
                    id="defaultOpen"
            >주제</a
            >
            <a href="javascript:void(0);" class="tablinks" onclick="filterTab(event, 'tab2')"
            >교과</a
            >
        </div>

        <div class="btn_wrap">
            <!-- 230207 :: 버튼 위치 변경-->
            <a href="javascript:void(0);" class="btn">
                <img src="/common/images/ico_btn_search.png" alt="초기화" /> 적용
            </a>
            <a href="javascript:void(0);" class="btn outline" data-dismiss="modal">
                <img src="/common/images/ico_btn_itialization.png" alt="초기화" /> 초기화
            </a>
        </div>
        <a href="javascript:void(0);" class="modal_close" data-dismiss="modal">
            <img src="/common/images/ico_pop_close.png" alt="close" />
        </a>
    </div>
</div>
</body>

<script src="/common/js/jquery-1.12.4.min.js"></script>
<script src="/common/js/script.js"></script>
<script src="/common/js/swiper.min.js"></script>
<script>
    //login account dropdown
    function loginFunction() {
        document.getElementById("loginDropdown").classList.toggle("show");
    }
    // 230207 :: 메인 검색 dropdown 추가
    function mainSearch() {
        document.getElementById("mainDropdown").classList.toggle("show");
    }

    // search filter
    function filterTab(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";
    }
    document.getElementById("defaultOpen").click();

    // hashtag swiper
    var hashSwiper = new Swiper(".hash_swiper", {
        slidesPerView: "auto",
        freeMode: true,
    });


    // 230207 :: 스크롤 내리면 헤더 검색바 노출 추가
    const mainHeader = document.querySelector(".main_header");
    const logo = mainHeader.querySelector(".logo");
    const searchTopBar = mainHeader.querySelector(".search_bar_wrap");
    const searchSec = document.querySelector(".search_section");
    const searchHeight = searchSec.clientHeight;
    window.addEventListener("scroll", function () {
        if (window.scrollY >= searchHeight) {
            searchTopBar.style.display = "flex";
            logo.classList.add("mini");
        } else {
            searchTopBar.style.display = "none";
            logo.classList.remove("mini");
        }
    });

    // 230207 :: side nav 추가
    const body = document.querySelector("body");
    const sideNav = document.getElementById("sideNav");
    const backDrop = document.querySelector(".backdrop");
    function openNav() {
        sideNav.style.right = "0";
        body.classList.add("ovh");
        backDrop.style.display = "block";
    }
    function closeNav() {
        sideNav.style.right = "-320px";
        body.classList.remove("ovh");
        backDrop.style.display = "none";
    }

    // 230228 :: 사이드네비 토글추가
    $(function () {
        $(".nav_list .drop").on("click", function (e) {
            e.preventDefault();
            $(this).toggleClass("close");
            $(this).next(".nav_depth").stop().slideToggle(200);
        });
    });

    // 230228 :: first_swiper
    var swiper = new Swiper(".first_swiper", {
        slidesPerView: "auto",
        spaceBetween: 20,
        breakpoints: {
            720: {
                spaceBetween: 5,
            },
            1200: {
                spaceBetween: 10,
            },
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        scrollbar: {
            el: ".swiper-scrollbar",
            draggable: true,
        },
    });

    // 230228 :: second_swiper
    const slides = document.querySelectorAll(".slides");
    for (let i = 0; i < slides.length; i++) {
        let slide = slides[i].querySelectorAll("li");
        (slides[i].currentIdx = 0),
            (slides[i].slideCount = slide.length),
            (slideWidth = document.querySelector(".second_swiper").clientWidth),
            (prevBtn = document.querySelectorAll(".prev")),
            (nextBtn = document.querySelectorAll(".next"));
        //console.log(slides[i].slideCount);
        slides[i].style.width = slideWidth * slides[i].slideCount + "px";
        function moveSlide(num) {
            slides[i].style.left = -num * slideWidth + "px";
            slides[i].currentIdx = num;
        }
        nextBtn[i].addEventListener("click", function () {
            if (slides[i].currentIdx < slides[i].slideCount - 1) {
                moveSlide(slides[i].currentIdx + 1);
            } else {
                moveSlide(0);
            }
        });
        prevBtn[i].addEventListener("click", function () {
            if (slides[i].currentIdx > 0) {
                moveSlide(slides[i].currentIdx - 1);
            }
        });
    }
</script>
<script>
    $('.detail-gif').on('click', function(e) {
        location.href = '/gif/detail/' + e.currentTarget.dataset.idx
    })
    $('.detail-packages').on('click', function(e) {
        location.href = '/packages/detailPackages/' + e.currentTarget.dataset.idx
    })
    $('.detail-contents').on('click', function(e) {
        location.href = '/contents/detail/' + e.currentTarget.dataset.idx
    })
    $('.detail-template').on('click', function(e) {
        location.href = '/template/detail/' + e.currentTarget.dataset.idx
    })
    $('.detail-video').on('click', function(e) {
        location.href = '/video/detail/' + e.currentTarget.dataset.idx
    })
</script>


</html>

<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Deume-Archive</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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
</div>

<script>
    //login account dropdown
    function loginFunction() {
        document.getElementById("loginDropdown").classList.toggle("show");
    }

    //side nav
    const body = document.querySelector("body");
    const sideNav = document.getElementById("sideNav");
    const backDrop = document.querySelector('.backdrop');

    function openNav() {
        sideNav.style.right = "0";
        body.classList.add('ovh');
        backDrop.style.display = "block";
        console.log('aaa');
    }

    function closeNav() {
        sideNav.style.right = "-320px";
        body.classList.remove('ovh');
        backDrop.style.display = "none";
    }

    $(document).ready(function () {
        // 검색창 포커스 최근 검색 리스트 노출
        $('.search_input_wrap .search_input').focus(function () {
            if (true) {
                $(this).next().addClass('active');
                $(this).focusout(function () {
                    if (true && $(this).val().length >= 1) {
                        $(this).next().removeClass('active');
                    } else if (true && $(this).val().length == 0) {
                        $(this).next().removeClass('active');
                    }
                });
            }
        });

        // 230228 :: 사이드네비 토글추가
        $(".nav_list .drop").on("click", function (e) {
            e.preventDefault();
            $(this).toggleClass("close");
            $(this).next(".nav_depth").stop().slideToggle(200);
        });
    });
</script>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <!-- HTML 문서의 메타 태그 및 제목 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>template adminList</title>
    <!-- 외부 CSS 및 JS 라이브러리 링크 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/common/css/reset.css">
    <link rel="stylesheet" href="/common/css/admin.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/0.9.1/jquery.tablednd.js"
            integrity="sha256-d3rtug+Hg1GZPB7Y/yTcRixO/wlI78+2m08tosoRn7A=" crossorigin="anonymous"></script>
    <script src="/common/js/admin.js"></script>

    <style>
        .fileItem img {
            width: 100px;
            height: 100px;
        }
    </style>

    <style>
        .table-cnt .table-type02 select {
            width: 220px !important;
        }
    </style>
</head>
<body>
<div id="wrap" class="page05_02">
    <div class="header">
        <div class="inner">
            <a href="/">
                <img src="/common/images/archive_logo.png" alt="아카이브">
            </a>
            <div class="select-wrap">
                <button type="button" class="select-btn">관리자</button>
                <div class="select-list">
                    <a href="javascript:;">비밀번호 변경</a>
                    <a href="javascript:;">로그아웃</a>
                </div>
            </div>
        </div>
        <div class="nav">
            <div class="inner">
                <ul class="nav-list">
                    <li>
                        <a href="javascript:;">이미지 관리</a>
                        <div class="depth2">
                            <ul class="inner">
                                <li>
                                    <a href="/contents/write">이미지 등록</a>
                                </li>
                                <li>
                                    <a href="/contents/manage">이미지 관리</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:;">움직이는 이미지 관리</a>
                        <div class="depth2">
                            <ul class="inner">
                                <li>
                                    <a href="/gif/save">이미지 등록</a>
                                </li>
                                <li>
                                    <a href="/gif/list">이미지 관리</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:;">동영상 관리</a>
                        <div class="depth2">
                            <ul class="inner">
                                <li>
                                    <a href="/video/save">동영상 등록</a>
                                </li>
                                <li>
                                    <a href="/video/manageList">동영상 관리</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:;">꾸러미 관리</a>
                        <div class="depth2">
                            <ul class="inner">
                                <li>
                                    <a href="/packages/loadPackages">꾸러미 등록</a>
                                </li>
                                <li>
                                    <a href="/packages/listPackages">꾸러미 관리</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:;">템플릿 관리</a>
                        <div class="depth2">
                            <ul class="inner">
                                <li>
                                    <a href="/template/write">템플릿 등록</a>
                                </li>
                                <li>
                                    <a href="/template/admin">템플릿 관리</a>
                                </li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="inner">
            <div class="table-cnt">
                <div class="table-type01 cnt-type">
                    <p style="font-size: xx-large;font-weight: bold;text-align: left; font-family: 'Noto Sans KR', sans-serif;">템플릿 관리</p><br>
                    <table>
                        <colgroup>
                            <col width="7%">
                            <col width="19%">
                            <col width="9%">
                            <col width="*">
                            <col width="7%">
                            <col width="10%">
                            <col width="10%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>번호</th>
                            <th>썸네일</th>
                            <th>유형</th>
                            <th>제목</th>
                            <th>상태</th>
                            <th>등록일</th>
                            <th>수정</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${thumbnailList}" var="thumb" varStatus="loop">
                            <tr>
                                <td>${count-loop.index}</td>
                                <td>
                                    <img src="${thumb.presignedUrl}" alt="">
                                </td>
                                <td><c:if test="${thumb.typeIdx eq 3}">템플릿</c:if></td>
                                <td class="tit">
                                    <a href="/template/detail/${thumb.templateIdx}">${thumb.name}</a>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${thumb.display eq 0}">미노출</c:when>
                                        <c:when test="${thumb.display eq 1}">노출</c:when>
                                    </c:choose>
                                </td>
                                <td id="date${loop.index}">${thumb.registerDate}</td>
                                <td>
                                    <a href="/template/update/${thumb.templateIdx}" class="link">수정</a>
                                </td>
                            </tr>
                            <script>
                                var time = '${thumb.registerDate}';
                                var date = time.split(' ');
                                $('#date${loop.index}').html(date[0])
                            </script>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
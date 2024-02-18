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
    <title>packages listPackages</title>
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
        .table-cnt .table-type02 select {
            width: 220px !important;
        }
    </style>
</head>
<body>
<div id="wrap" class="page04_02">
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
                <p style="font-size: xx-large;font-weight: bold;text-align: left; font-family: 'Noto Sans KR', sans-serif;">꾸러미 관리</p><br>
                <table>
                    <colgroup>
                        <col width="5%">
                        <col width="15%">
                        <col width="15%">
                        <col width="*%">
                        <col width="10%">
                        <col width="7%">

                    </colgroup>
                    <thead>
                    <tr>
                        <th>파일명</th>
                        <th>썸네일</th>
                        <th>제목</th>
                        <th>설명</th>
                        <th>수정일</th>
                        <th>수정</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="packagesData" items="${packagesDataList}">
                        <tr>
                            <td>
                                <a href="<c:url value='/packages/detailPackages/${packagesData.packagesIdx}'/>"> ${packagesData.original} </a>
                            </td>
                            <td>
                                <img src="${packagesData.presignedUrl}" alt="이미지" style="height: 130px; width: 220px;">
                            </td>
                            <td>${packagesData.name}</td>
                            <td>${packagesData.explanation}</td>
                            <td>${packagesData.updateDate}</td>
                            <td> <a href="<c:url value='/packages/update/${packagesData.packagesIdx}'/>">수정하기</a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
              <%--  <div class="paging-wrap">
                    <a href="javascript:;" class="first"></a>
                    <a href="javascript:;" class="prev"></a>
                    <a href="javascript:;" class="page active">
                        <span>1</span>
                    </a>
                    <a href="javascript:;" class="page">
                        <span>2</span>
                    </a>
                    <a href="javascript:;" class="page">
                        <span>3</span>
                    </a>
                    <a href="javascript:;" class="page">
                        <span>4</span>
                    </a>
                    <a href="javascript:;" class="page">
                        <span>5</span>
                    </a>
                    <a href="javascript:;" class="next"></a>
                    <a href="javascript:;" class="last"></a>
                </div>--%>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<script>

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
    $(function(){
        var dateFormat = "yy-mm-dd",
            from = $( "#from" )
                .datepicker({
                    defaultDate: "+1w",
                    changeMonth: true,
                    numberOfMonths: 1,
                    dateFormat: "yy-mm-dd",
                    showOn: "button",
                    buttonImage: "../images/admin/ico_calendar.png",
                    buttonImageOnly: true,
                    buttonText: "Select date"
                })
                .on( "change", function() {
                    to.datepicker( "option", "minDate", getDate( this ) );
                }),
            to = $( "#to" ).datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                dateFormat: "yy-mm-dd",
                showOn: "button",
                buttonImage: "../images/admin/ico_calendar.png",
                buttonImageOnly: true,
                buttonText: "Select date"
            })
                .on( "change", function() {
                    from.datepicker( "option", "maxDate", getDate( this ) );
                });

        function getDate( element ) {
            var date;
            try {
                date = $.datepicker.parseDate( dateFormat, element.value );
            } catch( error ) {
                date = null;
            }

            return date;
        }

    })


</script>



<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    #wrap {
        background-color: #fff;

    }

    .header {

        color: #fff;
        padding: 10px;
    }

    .nav {
        background-color: #444;
        color: #fff;
    }

    .nav-list {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
    }

    .nav-list li {
        margin-right: 20px;
    }

    .nav-list a {
        color: #fff;
        text-decoration: none;
    }

    .container {
        margin-top: 20px;
    }

    .table-type01 table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    .table-type01 th, .table-type01 td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }

    .table-type01 th {
        background-color: #f2f2f2;
    }

    .table-type01 a {
        color: #0066cc;
        text-decoration: none;
    }

    .paging-wrap {
        margin-top: 20px;
    }

    .paging-wrap a {
        display: inline-block;
        padding: 8px;
        margin-right: 5px;
        background-color: #0066cc;
        color: #fff;
        text-decoration: none;
        cursor: pointer;
    }

    .paging-wrap a.active {
        background-color: #fff;
        color: #0066cc;
    }
</style>
</html>
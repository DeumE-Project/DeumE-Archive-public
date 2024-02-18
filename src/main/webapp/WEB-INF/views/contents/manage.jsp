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
    <title>contents manage</title>
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
        #thumbnail-file-upload-wrapper,
        #gif-file-upload-wrapper {
            border: 1px dashed;
            padding: 5px;
            text-align: center;
            overflow: hidden;
            height: 120px;
        }

        #thumbnail-file-list,
        #gif-file-list {
            list-style-type: none;
            padding: 0;
        }


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
<div id="wrap" class="page01_02">
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

                                    <a href="/contents/write">콘텐츠 등록</a>
                                </li>
                                <li>
                                    <a href="/contents/manage">콘텐츠 관리</a>
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
                    <div class="table-top">
                        <div class="select-box">
                            <h3 style="display: inline-block; font-weight: bolder">총 <em><c:out
                                    value="${contentsList.size()}"/></em>개</h3>
                        </div>
                        <a href="/contents/write" id="new" style="width: 120px; height: 35px; color: #fff; background-color: #6f6f6f; line-height: 35px;">새로운 콘텐츠 등록</a>
                    </div>
                    <table>
                        <colgroup>
                            <col width="7%">
                            <col width="19%">
                            <col width="9%">
                            <col width="*">
                            <col width="7%">
                            <col width="10%">
                            <col width="10%">
                            <col width="10%">
                        </colgroup>
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>썸네일</th>
                            <th>유형</th>
                            <th>제목</th>
                            <th>상태</th>
                            <th>게시자</th>
                            <th>등록일</th>
                            <th>수정</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${empty contentsList}">
                                등록된 콘텐츠가 없습니다
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${contentsList}" var="item">
                                    <tr>
                                        <td><c:out value="${item.idx}"/></td>
                                        <td>
                                            <img class="tb-img" src='<c:out value="${item.contentsThumbnailList.get(0).presignedUrl}"/>' alt=""
                                            style="width: 200px; height: 130px;">
                                        </td>
                                        <td>이미지</td>
                                        <td class="tit">
                                            <button type="button" class="pop-btn" data-pop="detail-pop"
                                                    data-idx="${item.idx}">
                                                <c:out value="${item.name}"/>
                                            </button>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${item.display eq 1}">노출</c:when>
                                                <c:when test="${item.display eq 0}">비노출</c:when>
                                            </c:choose>
                                        </td>
                                        <td>관리자</td>
                                        <td>
                                            <fmt:parseDate var="parsedDateTime" value="${item.registerDate}"
                                                           pattern="yyyy-MM-dd'T'HH:mm"/>
                                            <fmt:formatDate pattern="yyyy.MM.dd HH:mm" value="${parsedDateTime}"/>
                                        </td>
                                        <td>
                                            <a href="/contents/update/${item.idx}" class="link">수정</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="dim"></div>

    <div class="popup" data-pop="detail-pop">
        <div class="view-cnt">
            <div class="tit">
                <span>상세 보기</span>
                <div class="btn-wrap">
                    <a href="javascript:;" class="link" id="detail">상세</a>
                    <a href="javascript:;" class="link" id="edit">수정</a>
                    <button type="button" class="pop-close"></button>
                </div>
            </div>
            <div class="cnt">
                <div class="table-type02">
                    <table>
                        <colgroup>
                            <col width="11%">
                            <col width="*">
                            <col width="11%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>ID</th>
                            <td id="idx">xxxx</td>
                            <th>유형</th>
                            <td>콘텐츠 이미지</td>
                        </tr>
                        <tr>
                            <th>노출여부</th>
                            <td colspan="3" id="show">노출</td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td colspan="3" id="name">바다에서 가족과 물놀이하는 모습</td>
                        </tr>
                        <tr>
                            <th>키워드</th>
                            <td colspan="3" id="keyword">여름, 바다, 물놀이, 가족 여행</td>
                        </tr>
                        <tr>
                            <th>설명</th>
                            <td colspan="3" id="explanation">-</td>
                        </tr>
                        <tr>
                            <th>출처</th>
                            <td colspan="3" id="source">천재교육</td>
                        </tr>
                        <tr>
                            <th>카테고리</th>
                            <td colspan="3">
                                [주제] <span id="category"></span>
                            </td>
                        </tr>
                        <tr>
                            <th>등록일</th>
                            <td colspan="3" id="registerDate">YYYY-MM-DD</td>
                        </tr>
                        <tr>
                            <th>마지막 수정일</th>
                            <td colspan="3" id="updateDate">YYYY-MM-DD</td>
                        </tr>
                        <%--<tr>
                            <th>썸네일</th>
                            <td colspan="3"><img src="../images/admin/thum_sample.png" alt=""></td>
                        </tr>--%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    const contentsMap = new Map()
    <c:forEach items="${contentsList}" var="item">
    contentsMap.set('${item.idx}', {
        idx: ${item.idx},
        display: ${item.display},
        name: '${item.name}',
        keyword: '${item.keyword}'.substring(0, '${item.keyword}'.length - 1),
        explanation: '${item.explanation}',
        source: '${item.source}',
        maincateIdx: ${item.maincateIdx},
        subcateIdx: ${item.subcateIdx},
        registerDate: '${item.registerDate}'.replace('T', ' '),
        updateDate: '${item.updateDate}'.replace('T', ' '),
        maincateName: '${item.maincateName}',
        subcateName: '${item.subcateName}',
    })
    </c:forEach>


    $('.pop-btn').on('click', function (e) {
        console.log('button click')
        const idx = e.target.dataset.idx // string
        const item = contentsMap.get(idx)
        console.log(item)

        $('#idx').text(item.idx)
        $('#show').text(
            item.show == 1 ? '노출' : '비노출'
        )
        $('#name').text(item.name)
        $('#keyword').text(item.keyword)
        $('#explanation').text(item.explanation)
        $('#source').text(item.source)
        $('#registerDate').text(item.registerDate)
        $('#updateDate').text(item.updateDate)

        $('#edit').attr('href', '/contents/update/' + item.idx)
        $('#detail').attr('href', '/contents/detail/' + item.idx)

        $('#category').text(item.maincateName + ' > ' + item.subcateName)
    })
</script>

<script>
    $(function () {
        var dateFormat = "yy-mm-dd",
            from = $("#from")
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
                .on("change", function () {
                    to.datepicker("option", "minDate", getDate(this));
                }),
            to = $("#to").datepicker({
                defaultDate: "+1w",
                changeMonth: true,
                numberOfMonths: 1,
                dateFormat: "yy-mm-dd",
                showOn: "button",
                buttonImage: "../images/admin/ico_calendar.png",
                buttonImageOnly: true,
                buttonText: "Select date"
            })
                .on("change", function () {
                    from.datepicker("option", "maxDate", getDate(this));
                });

        function getDate(element) {
            var date;
            try {
                date = $.datepicker.parseDate(dateFormat, element.value);
            } catch (error) {
                date = null;
            }
            return date;
        }
    })
</script>
</html>
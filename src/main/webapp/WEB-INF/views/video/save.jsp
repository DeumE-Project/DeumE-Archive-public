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
    <title>video save</title>
    <!-- 외부 CSS 및 JS 라이브러리 링크 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/common/css/reset.css">
    <link rel="stylesheet" href="/common/css/admin.css">
    <link rel="stylesheet" href="/common/css/video/video.css">
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/TableDnD/0.9.1/jquery.tablednd.js"
            integrity="sha256-d3rtug+Hg1GZPB7Y/yTcRixO/wlI78+2m08tosoRn7A=" crossorigin="anonymous"></script>
    <script src="/common/js/admin.js"></script>

 <%--   <style>
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
    </style>--%>
</head>
<body>
<div id="wrap" class="page03_01">
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
                <div class="table-type02">
                    <div class="table-top">
                        <span class="table-tit">비디오 등록</span>
                        <div class="btn-wrap">

                            <button type="button" class="btn w90" id="save-btn">등록하기</button>

                        </div>
                    </div>
                    <table>
                        <colgroup>
                            <col width="6%">
                            <col width="9%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th colspan="2">
                                <span>
                                  <em>＊</em>비디오 유형
                                </span>
                            </th>
                            <td>
                                <select name="type" id="type">
                                    <option value="1">비디오</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <span>
                                  <em>＊</em>노출 여부
                                </span>
                            </th>
                            <td>
                                <input type="radio" id="display1" name="display" value="1" checked>
                                <label for="display1">노출</label>
                                <input type="radio" id="display2" name="display" value="0">
                                <label for="display2">미노출</label>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <span>
                                  <em>＊</em>제목
                                </span>
                            </th>
                            <td>
                                <input type="text" name="name" id="name">
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">
                                <span>
                                  <em>＊</em>키워드
                                </span>
                            </th>
                            <td>
                                <input type="text" placeholder="최대 10개 까지 작성 가능합니다. (작성 후 엔터)" id="keyword-input">
                                <div class="keyword-wrap" id="keyword-wrap"></div>
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">설명</th>
                            <td>
                                <input type="text" name="explanation" id="explanation">
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2">출처</th>
                            <td>
                                <input type="text" name="source" id="source">
                            </td>
                        </tr>
                        <tr>
                            <th colspan="2" rowspan="2">카테고리 선택</th>
                            <td>
                                <select name="maincate" id="maincate">
                                    <option value="">- 메인카테고리 선택 -</option>
                                    <option value="1">명절</option>
                                    <option value="2">민속놀이</option>
                                </select>
                                <select name="subcate" id="subcate">
                                    <option value="">- 서브카테고리 선택 -</option>
                                </select>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="table-type02">
                    <div class="table-top">
                        <span class="table-tit">파일 등록</span>
                    </div>
                    <table>
                        <colgroup>
                            <col width="15%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                        <tr>
                            <th>
                                <span>
                                  <em>＊</em>비디오
                                </span>
                            </th>
                            <%--<td>
                                <div id="contents-file-upload-wrapper">
                                    <p style="text-align: center;">여기에 비디오를 드래그 앤 드롭하세요 (최대 1개)</p>
                                    <ul id="contents-file-list" style="text-align: center;"></ul>
                                </div>
                            </td>--%>
                            <td>
                                <div id="video-file-upload-wrapper">
                                    <p style="text-align: center;">여기에 비디오를 드래그 앤 드롭하세요 (최대 1개)</p>
                                    <input type="file" id="video-upload" accept="video/*" style="display: none;" onchange="handleVideoUpload(event)">
                                    <ul id="video-file-list" style="list-style-type: none; padding: 0;"></ul>
                                </div>
                            </td>

                        </tr>
                        <tr>
                            <th>
                                <span>
                                  <em>＊</em>썸네일 사진
                                </span>
                            </th>
                            <td>
                                <div id="thumbnail-file-upload-wrapper">
                                    <p style="text-align: center;">여기에 썸네일 사진(들)을 드래그 앤 드롭하세요 (최대 10개)</p>
                                    <ul id="thumbnail-file-list" style="text-align: left;"></ul>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="dim"></div>
</div>
</body>
<script src="/common/js/video/videoSave.js"></script>
</html>

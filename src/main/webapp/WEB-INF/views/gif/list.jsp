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
  <title>gif list</title>
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
<div id="wrap" class="page02_02">
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
          <div class="table-top">
            <p style="font-size: large;font-weight: bold;text-align: left; ">움직이는 이미지 관리</p><br>
            <div class="select-box">
              <h3 style="display: inline-block; font-weight: bolder">총 <em><c:out
                      value="${gifThumbnailList.size()}"/></em>개</h3>

            </div>

          </div>
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
              <th>파일이름</th>
              <th>썸네일</th>
              <th>제목</th>
              <th>설명</th>
              <th>수정일</th>
              <th>수정</th>
            </tr>
            </thead>
            <tbody class="table-type02">
      <%--        <c:forEach items="${gifThumbnailList}" var="gifThumb">  --%>
              <c:forEach var="gifThumb" items="${gifThumbnailList}">
                <tr>
                  <td>
                    <a class="gitBtn" href="<c:url value='/gif/detail/${gifThumb.gifIdx}'/>">${gifThumb.original}</a>
                  </td>
                  <td>
                    <a href="<c:url value='/gif/detail/${gifThumb.gifIdx}'/>"> <img src="${gifThumb.presignedUrl}" alt="이미지"></a>
                  </td>
                  <td>${gifThumb.name}</td>
                  <td>${gifThumb.explanation}</td>
                  <td>${gifThumb.updateDate}</td>
                  <td>    <a class="gitBtn" href="<c:url value='/gif/update/${gifThumb.gifIdx}'/>">수정하기</a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
          <div class="paging-wrap">
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
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>


<style>
  .table-type02 a  {
    color: #0066cc;
    text-decoration: none;
  }

</style>
</html>
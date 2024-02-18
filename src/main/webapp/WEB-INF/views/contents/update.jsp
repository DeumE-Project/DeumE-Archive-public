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
    <title>contesnt update</title>
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
        #contents-file-upload-wrapper {
            border: 1px dashed;
            padding: 5px;
            text-align: center;
            overflow: hidden;
            height: 120px;
        }

        #thumbnail-file-list,
        #contents-file-list {
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
                        <span class="table-tit">단건이미지(콘텐츠) 등록</span>
                        <div class="btn-wrap">

                            <button type="button" class="btn w90" id="save-btn">업데이트</button>
                            
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
                                  <em>＊</em>콘텐츠 유형
                                </span>
                            </th>
                            <td>
                                <select name="type" id="type">
                                    <option value="1">단건이미지(콘텐츠)</option>
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
                                <input type="radio" id="display1" name="display" value="1">
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
                            <th colspan="2" rowspan="2">
                                <span>
                                  <em>＊</em>카테고리 선택
                                </span>
                            </th>
                            <td>
                                <select name="maincate" id="maincate">
                                    <option value="">- 메인카테고리 선택 -</option>
                                    <option id="maincate1" value="1">명절</option>
                                    <option id="maincate2" value="2">민속놀이</option>
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
                        <tr>
                            <th>
                                <span>
                                  <em>＊</em>콘텐츠 메인 사진
                                </span>
                            </th>
                            <td>
                                <div id="contents-file-upload-wrapper">
                                    <p style="text-align: center;">여기에 메인 콘텐츠 사진을 드래그 앤 드롭하세요 (최대 1개)</p>
                                    <ul id="contents-file-list" style="text-align: center;"></ul>
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

<%-- 페이지가 load 된 이후, 원래의 정보를 갖고 오기 위한 script --%>
<script>
    const subCateForMainCate1 = '\
<option value="">- 서브카테고리 선택 -</option>\
<option value="1" id="subcate1">신정</option>\
<option value="2" id="subcate2">설날</option>\
<option value="3" id="subcate3">정월대보름</option>\
<option value="4" id="subcate4">단오</option>\
<option value="5" id="subcate5">칠석</option>\
<option value="6" id="subcate6">추석</option>\
<option value="7" id="subcate7">동지</option>\
'

    const subCateForMainCate2 = '\
<option value="">- 서브카테고리 선택 -</option>\
<option value="8" id="subcate8">강강술래</option>\
<option value="8" id="subcate9">널뛰기</option>\
<option value="10" id="subcate10">연날리기</option>\
<option value="11" id="subcate11">씨름</option>\
<option value="12" id="subcate12">쥐불놀이</option>\
<option value="13" id="subcate13">투호</option>\
<option value="14" id="subcate14">팽이치기</option>\
'

    $('#maincate').on('change', function (e) {
        if ($(this).val() == '') {
            console.log('maincate 아무것도 선택 안 됨')
            $('#subcate').html('<option value="">- 서브카테고리 선택 -</option>')
        } else if ($(this).val() == '1') {
            console.log('maincate 1번 선택')
            $('#subcate').html(subCateForMainCate1)
        } else if ($(this).val() == '2') {
            console.log('maincate 2번 선택')
            $('#subcate').html(subCateForMainCate2)
        }
    })

    const contentsIdx = location.href.substring(location.href.lastIndexOf('/') + 1, location.href.length)
    console.log(contentsIdx)
    $.ajax({
        type: 'get',
        url: '/contents/update/get-info/' + contentsIdx,
        dataType: 'json',
        success: function(result) {
            console.log(result)
            fillUpContentsInformation(result)
            fillUpThumbnails(result.contentsThumbnailList)
            fillUpMainImage({
                path: result.uploadPath,
                fileNameWithUUID: result.saved
            })
        },
        error: function(err) {
            console.log(contentsIdx + " -> 정보 갖고오기 실패")
            console.log(contentsIdx)
        }
    })

    function fillUpContentsInformation(contents) {
        $('#name').val(contents.name)

        if (contents.display == 1) {
            $('#display1').attr('checked', true)
        } else if (contents.display == 0) {
            $('#display2').attr('checked', true)
        }

        contents.keyword.substring(0, contents.keyword.lastIndexOf(','))
            .split(',')
            .forEach((word) => {
                const keywordDiv = document.createElement('div')
                keywordDiv.classList.add('keyword')

                const spanTag = document.createElement('span')
                spanTag.innerText = word

                const buttonTag = document.createElement('button')
                buttonTag.classList.add('delete')

                buttonTag.onclick = function () {
                    keywordDiv.remove()
                }

                keywordDiv.appendChild(spanTag)
                keywordDiv.appendChild(buttonTag)
                $('#keyword-wrap').append(keywordDiv)
        })

        $('#explanation').val(contents.explanation)
        $('#source').val(contents.source)

        if (contents.maincateIdx == 1) {
            $('#maincate1').attr('selected', true)
            $('#subcate').html(subCateForMainCate1)
            $('#subcate' + contents.subcateIdx).attr('selected', true)
        } else if (contents.maincateIdx == 2) {
            $('#maincate2').attr('selected', true)
            $('#subcate').html(subCateForMainCate2)
            $('#subcate' + contents.subcateIdx).attr('selected', true)
        }
    }

    function fillUpThumbnails(contentsThumbnailList) {
        const thumbnailList = contentsThumbnailList
        console.log(thumbnailList)

        const requestArr = Array.from(thumbnailList).map((thumbnail) => {
            return {
                path: thumbnail.savedPath,
                fileNameWithUUID: thumbnail.saved
            }
        })
        console.log(requestArr)
        console.log(JSON.stringify(requestArr))

        requestArr.forEach((request) => {
            console.log('------------')
            console.log(JSON.stringify(request))
            $.ajax({
                type: 'post',
                url: '/presigned/view-url',
                data: JSON.stringify(request),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                async: false,
                success: function(result) {
                    let fileItem = '<li class="fileItem" data-file-name="' + result.originalFileName + '" data-untouched="true"' +
                        'data-filename-with-uuid="' + result.fileNameWithUUID + '">'
                    fileItem += '<img src="' + result.presignedUrl + '" title="' + result.originalFileName + '" class="thumb-img"/>'
                    fileItem += '<span class="deleteButton" id="deleteButton">X</span>'
                    fileItem += '</li>'
                    $('#thumbnail-file-list').append(fileItem)
                },
                error: function(err) {

                }
            })
        })
    }

    function fillUpMainImage(request) {
        $.ajax({
            type: 'post',
            url: '/presigned/view-url',
            data: JSON.stringify(request),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            success: function(result) {
                let fileItem = '<li class="fileItem" data-file-name="' + result.originalFileName + '" data-untouched="true"' +
                    'data-filename-with-uuid="' + result.fileNameWithUUID + '">'
                fileItem += '<img src="' + result.presignedUrl + '" title="' + result.originalFileName + '"/>'
                fileItem += '<span class="deleteButton" id="deleteButton">X</span>'
                fileItem += '</li>'
                $('#contents-file-list').append(fileItem)
            },
            error: function(err) {

            }
        })
    }

    $(document).on('click', '#deleteButton', function(e) {
        $(this).parent().remove()
    })
</script>

<%-- keyword를 입력하고 enter 입력 시 이벤트 처리 --%>
<script>
    $('#keyword-input').on('keyup', function (e) {
        if (!((e.keyCode === 13) && e.target.value)) {
            return
        }

        if ($('#keyword-wrap').children().length === 10) {
            alert('키워드는 총 10개까지 입력할 수 있습니다')
            e.target.value = ''
            return
        }

        const inputKeyword = e.target.value
        console.log('inputKeyword: ' + inputKeyword)

        const keywordDiv = document.createElement('div')
        keywordDiv.classList.add('keyword')

        const spanTag = document.createElement('span')
        spanTag.innerText = inputKeyword

        const buttonTag = document.createElement('button')
        buttonTag.classList.add('delete')

        buttonTag.onclick = function () {
            keywordDiv.remove()
        }

        keywordDiv.appendChild(spanTag)
        keywordDiv.appendChild(buttonTag)
        $('#keyword-wrap').append(keywordDiv)
        e.target.value = ''
    })
</script>

<%-- 썸네일 사진을 위한 Drag & Drop event handler --%>
<script>
    const thumbnailMap = new Map();
    const THUMBNAIL_MAX_FILES = 10
    const thumbnailFileUploadWrapperTag = document.getElementById('thumbnail-file-upload-wrapper')
    const thumbnailFileList = document.getElementById('thumbnail-file-list')

    thumbnailFileUploadWrapperTag.addEventListener('dragover', function (e) {
        e.preventDefault()
    })

    thumbnailFileUploadWrapperTag.addEventListener('drop', function (e) {
        console.log('thumbnail drop!')
        e.preventDefault()

        const thumbnailFileList = e.dataTransfer.files
        handleThumbnailFiles(thumbnailFileList)
    })

    function handleThumbnailFiles(thumbnails) {
        if (thumbnailFileList.childElementCount + thumbnails.length > THUMBNAIL_MAX_FILES) {
            alert('최대 ' + THUMBNAIL_MAX_FILES + '개까지 업로드할 수 있습니다.')
            return;
        }

        const existingFiles = Array.from(thumbnailFileList.children)
            .map(
                (item) => {
                    console.log(item.dataset.fileName)
                    return item.dataset.fileName
                }
            )

        for (const file of thumbnails) {
            console.log(file.type)
            console.log(file)
            if (!file.type.match('image.*')) {
                alert('사진만 등록할 수 있습니다')
                continue
            }

            if (existingFiles.includes(file.name)) {
                alert('동일한 파일은 중복해서 업로드할 수 없습니다: ' + file.name)
                continue
            }

            let reader = new FileReader()

            reader.onload = function (e) {
                const thumbnailFileName = file.name

                let thumbnailFileItem = document.createElement('li')
                thumbnailFileItem.className = 'fileItem'
                thumbnailFileItem.dataset.fileName = thumbnailFileName

                let thumbnailDeleteButton = document.createElement('span')
                thumbnailDeleteButton.className = 'deleteButton'
                thumbnailDeleteButton.innerHTML = 'X'
                thumbnailDeleteButton.onclick = function () {
                    thumbnailFileItem.remove()
                    thumbnailMap.delete(thumbnailFileName)
                }

                let thumbnailImage = document.createElement('img')
                thumbnailImage.src = e.target.result
                thumbnailImage.title = thumbnailFileName
                thumbnailImage.classList.add('thumb-img')
                thumbnailFileItem.appendChild(thumbnailImage)

                thumbnailFileItem.appendChild(thumbnailDeleteButton)
                thumbnailFileList.appendChild(thumbnailFileItem)

                thumbnailMap.set(thumbnailFileName, file)
            }
            reader.readAsDataURL(file)
        }
    }

    $(function () {
        $('#thumbnail-file-list').sortable()
    })
</script>

<%-- 메인 사진을 위한 Drag & Drop event handler --%>
<script>
    const CONTENTS_MAX_FILES = 1
    const contentsFileUploadWrapperTag = document.getElementById('contents-file-upload-wrapper')
    const contentsFileList = document.getElementById('contents-file-list')
    const mainImageMap = new Map()

    contentsFileUploadWrapperTag.addEventListener('dragover', function (e) {
        e.preventDefault()
    })

    contentsFileUploadWrapperTag.addEventListener('drop', function (e) {
        console.log('contents main image drop!')
        e.preventDefault()

        const contentsFileList = e.dataTransfer.files
        handleContentsFiles(contentsFileList)
    })

    function handleContentsFiles(contents) {
        if (contentsFileList.childElementCount + contents.length > CONTENTS_MAX_FILES) {
            alert('최대 ' + CONTENTS_MAX_FILES + '개까지 업로드할 수 있습니다.')
            return;
        }

        const existingFiles = Array.from(contentsFileList.children).map(
            (item) => item.dataset.fileName
        )

        for (const file of contents) {
            console.log(file.type)
            if (!file.type.match('image.*')) {
                alert('사진만 등록할 수 있습니다')
                continue
            }

            if (existingFiles.includes(file.name)) {
                alert('동일한 파일은 중복해서 업로드할 수 없습니다: ' + file.name)
                continue
            }
            let reader = new FileReader()

            reader.onload = function (e) {
                const contentsFileName = file.name

                let contentsFileItem = document.createElement('li')
                contentsFileItem.className = 'fileItem'
                contentsFileItem.dataset.fileName = contentsFileName

                let contentsDeleteButton = document.createElement('span')
                contentsDeleteButton.className = 'deleteButton'
                contentsDeleteButton.innerHTML = 'X'
                contentsDeleteButton.onclick = function () {
                    contentsFileItem.remove()
                    mainImageMap.delete(contentsFileName)
                }

                let contentsImage = document.createElement('img')
                contentsImage.src = e.target.result
                contentsImage.title = contentsFileName
                contentsImage.classList.add('thumb-img')

                contentsFileItem.appendChild(contentsImage)
                contentsFileItem.appendChild(contentsDeleteButton)

                contentsFileList.appendChild(contentsFileItem)

                mainImageMap.set(contentsFileName, file)
            }
            reader.readAsDataURL(file)
        }
    }

    $(function () {
        $('#contents-file-list').sortable()
    })
</script>

<%-- 저장 버튼을 눌렀을 때 event handler --%>
<script>
    function handleThumbnailImagesWhenSaveButtonClicked() {
        let thumbnailOrder = 1
        const thumbnailFileInfoList= []
        Array.from(thumbnailFileList.children).forEach((thumbnail) => {
            if (thumbnail.dataset.untouched == 'true' && thumbnail.dataset.filenameWithUuid) {
                thumbnailFileInfoList.push({
                    original: thumbnail.dataset.fileName,
                    saved: thumbnail.dataset.filenameWithUuid,
                    orders: thumbnailOrder++,
                    uploadRequired: false
                })
            } else {
                const presignedUploadRequestObj = {
                    path: 'contents/thumbnails/',
                    originalFileName: thumbnail.dataset.fileName
                }
                $.ajax({
                    type: 'post',
                    url: '/presigned/upload-url',
                    data: JSON.stringify(presignedUploadRequestObj),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    async: false,
                    success: function (result1) {
                        $.ajax({
                            type: 'put',
                            url: result1.presignedUrl,
                            data: thumbnailMap.get(thumbnail.dataset.fileName),
                            processData: false,
                            contentType: 'binary/octet-stream',
                            async: false,
                            success: function (result2) {
                                thumbnailFileInfoList.push({
                                    original: thumbnail.dataset.fileName,
                                    saved: result1.fileNameWithUUID,
                                    orders: thumbnailOrder++
                                })
                            },
                            error: function (err) {
                                console.log('thumbnail upload error!')
                            }
                        })
                    },
                    error: function (err) {
                        console.log('ajax error!')
                        console.log(err)
                    }
                })
            }
        })
        console.log(thumbnailFileInfoList)
        return thumbnailFileInfoList
    }

    function handleContentsMainImage() {
        const mainImageInfo = {}
        if ($('#contents-file-list > li').data('untouched') == true &&
            $('#contents-file-list > li').data('filename-with-uuid')) {
            mainImageInfo.original = $('#contents-file-list > li').data('file-name')
            mainImageInfo.saved = $('#contents-file-list > li').data('filename-with-uuid')
        } else {
            $.ajax({
                type: 'post',
                url: '/presigned/upload-url',
                data: JSON.stringify({
                    path: 'contents/',
                    originalFileName: $('#contents-file-list > li').data('file-name'),
                }),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                async: false,
                success: function(result) {
                    console.log('main image upload presigned url generation success')
                    mainImageInfo.original = $('#contents-file-list > li').data('file-name')
                    mainImageInfo.saved = result.fileNameWithUUID
                    mainImageInfo.presignedUrl = result.presignedUrl
                },
                error: function(err) {
                    console.log('main image upload presigned url generation error')
                    console.log(err)
                }
            })

            $.ajax({
                type: 'put',
                url: mainImageInfo.presignedUrl,
                data: mainImageMap.get(mainImageInfo.original),
                processData: false,
                contentType: 'binary/octet-stream',
                async: false,
                success: function (result) {
                    console.log(result)
                },
                error: function (err) {
                    console.log(err)
                }
            })
        }
        console.log(mainImageInfo)
        return mainImageInfo;
    }

    function handleContentsInformationWhenSaveButtonClicked(thumbnailFileInfoList, mainImageInfo) {
        let keywordsWithCommas = ""
        function handleKeyword() {
            $('.keyword > span').each(function (index, item) {
                keywordsWithCommas = keywordsWithCommas + $(item).text() +  ","
            })
        }
        handleKeyword()

        const contentsSaveRequestObj = {
            idx: contentsIdx,
            type: $('#type option:selected').val(),
            display: $('input:radio[name="display"]:checked').val(),
            name: $('#name').val(),
            keyword: keywordsWithCommas,
            explanation: $('#explanation').val(),
            source: $('#source').val(),
            subCategory: $('#subcate option:selected').val()
        }
        console.log(contentsSaveRequestObj)

        contentsSaveRequestObj.thumbnailSaveRequestList = thumbnailFileInfoList
        contentsSaveRequestObj.mainImageSaveRequestDTO = mainImageInfo

        $.ajax({
            type: 'post',
            url: '/contents/update',
            data: JSON.stringify(contentsSaveRequestObj),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            async: false,
            success: function (result) {
                console.log('콘텐츠 정보 save success!')
                alert('콘텐츠가 수정되었습니다')
                console.log(result)
                location.href = '/contents/detail/' + contentsIdx
            },
            error: function (err) {
                console.log('콘텐츠 정보 save error!')
                alert('콘텐츠를 수정하지 못했습니다')
                console.log(err)
            }
        })
    }

    function validationCheck() {
        const name = $('#name').val()
        const keywordDivTagLength = $('#keyword-wrap > .keyword').length
        const thumbnailLength = $('#thumbnail-file-list > .fileItem').length
        const mainImageLength = $('#contents-file-list > .fileItem').length
        const subCate = $('#subcate option:selected').val()

        if (!name) {
            alert('콘텐츠 제목을 입력해주세요')
            return false
        }
        if (!keywordDivTagLength) {
            alert('키워드를 한 개 이상 작성해주세요')
            return false
        }
        if (!subCate) {
            alert('카테고리를 선택해주세요')
            return false
        }
        if (!thumbnailLength) {
            alert('썸네일 사진을 한 개 이상 등록해주세요')
            return false
        }
        if (!mainImageLength) {
            alert('메인 이미지를 등록해주세요')
            return false
        }
        return true
    }

    $('#save-btn').on('click', function (e) {
        console.log('save-btn click!')

        if (!validationCheck()) {
            return
        }

        const thumbnailFileInfoList = handleThumbnailImagesWhenSaveButtonClicked()
        const mainImageInfo = handleContentsMainImage()
        handleContentsInformationWhenSaveButtonClicked(thumbnailFileInfoList, mainImageInfo)
    }) // save-btn on click handler ends
</script>

</html>

package kr.co.chunjae.video.controller;

import kr.co.chunjae.aws.dto.BasicS3DownloadRequestDTO;
import kr.co.chunjae.aws.service.BasicS3Service;
import kr.co.chunjae.video.dto.*;
import kr.co.chunjae.video.service.VideoService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/video")
public class VideoController {
    private final VideoService videoService;
    private final BasicS3Service basicS3Service;

    /**
     *
     * @return
     */
    @GetMapping("/save")
    public String videoSaveForm() {
        return "video/save";
    }

    /**
     *
     * @param saveRequestDTO
     * @return
     */
    @PostMapping("/save")
    public ResponseEntity<?> videoSave(@RequestBody VideoSaveRequestDTO saveRequestDTO) {
        log.info("saveRequestDTO ={}", saveRequestDTO);
        videoService.saveVideoWithThumbnailAndVideoFile(saveRequestDTO);
        log.info("saveRequestDTO ={}", saveRequestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "등록완료");

        return ResponseEntity
                .status(HttpStatus.CREATED) //Post에서는 201(created)를 반환
                .body(resultMap);
    }

    /**
     *
     * @param videoIdx
     * @return
     */
    @GetMapping("/update/{videoIdx}")
    public String videoUpdateForm(@PathVariable Integer videoIdx) {
        return "video/update";
    }

    /**
     *
     * @param videoIdx
     * @return
     */
    @GetMapping("/update/get-info/{videoIdx}")
    public ResponseEntity<?> getVideoInfo(@PathVariable String videoIdx) {
        Integer videoIdxInt = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            videoIdxInt = Integer.parseInt(videoIdx);

        } catch (Exception e) {
            log.error("숫자 이외의 값이 입력되었습니다.");
            errorMap.put("errorMessage", "숫자 이외의 값이 입력되었습니다. 숫자를 입력해주세요");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        VideoDTO videoDTO = videoService.selectVideo(videoIdxInt);
        log.info("videoDTO = {}", videoDTO);

        if (videoDTO == null) {
            errorMap.put("errorMessage", "해당 비디오의 Idx를 찾을 수 없습니다.");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        return ResponseEntity
                .ok(videoDTO);
    }

    /**
     *
     * @param saveRequestDTO
     * @return
     */
    @PostMapping("/update")
    public ResponseEntity<?> videoUpdate(@RequestBody VideoSaveRequestDTO saveRequestDTO) {
        log.info("saveRequestDTO ={}", saveRequestDTO);
        videoService.updateVideoWithThumbnailAndVideoFile(saveRequestDTO);
        log.info("saveRequestDTO={}", saveRequestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "비디오 정보가 수정되었습니다.");

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(resultMap);
    }

    /**
     *
     * @param videoIdx
     * @return
     */
    @GetMapping("/detail/{videoIdx}")
    public String videoDetail(@PathVariable String videoIdx) {
        return "video/detail";
    }

    /**
     *
     * @param videoIdx
     * @return
     */
    @GetMapping("/detail/get-info/{videoIdx}")
    public ResponseEntity<?> getVideoInfoDetail(@PathVariable String videoIdx) {
        Integer videoIdxInt = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            videoIdxInt = Integer.parseInt(videoIdx);

        } catch (Exception e) {
            log.error("숫자가 아닌 값이 입력되었습니다.");
            errorMap.put("errorMessage", "숫자가 아닌 값이 입력되었습니다. 숫자를 입력해주세요");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        VideoDTO videoDTO = videoService.selectVideo(videoIdxInt);
        log.info("videoDTO = {}", videoDTO);

        if (videoDTO == null) {
            errorMap.put("errorMessage", "해당 비디오의 Idx를 찾을 수 없습니다.");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        return ResponseEntity
                .ok(videoDTO);

    }

    /**
     *
     * @param videoZipDownRequestDTO
     * @return
     * @throws IOException
     */

    @PostMapping("/zip")
    public ResponseEntity<?> zipDownload(@RequestBody VideoZipDownRequestDTO videoZipDownRequestDTO)
            throws IOException {
        Integer videoIdx = videoZipDownRequestDTO.getVideoIdx();
        Map<String, Object> resultMap = null;
        try {
            resultMap = videoService.downloadZipFile(videoIdx);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        ByteArrayResource byteArrayResource = (ByteArrayResource) resultMap.get("zipFile");
        String zipFileName = (String) resultMap.get("zipFileName");
        return ResponseEntity
                .ok()
                .contentLength(byteArrayResource.contentLength())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .header("Content-Disposition",
                        "attachment;filename=" +
                                new String(zipFileName.getBytes("utf-8"), "ISO-8859-1"))
                .body(byteArrayResource);
    }

    /**
     *
     * @param model
     * @return
     */
    @GetMapping("/list")
    public String videoList(Model model) {
        model.addAttribute("thumbnailList", videoService.selectVideoListThumbnail());
        return "video/list";
    }

    /**
     *
     * @param downRequestDTO
     * @return
     * @throws UnsupportedEncodingException
     */
    @PostMapping("/download-from-list")
    public ResponseEntity<?> downloadVideoFromList(@RequestBody VideoDownRequestDTO downRequestDTO) throws UnsupportedEncodingException {
        VideoDTO videoDTO = videoService.selectVideo(downRequestDTO.getVideoIdx());
        BasicS3DownloadRequestDTO basicS3DownloadRequestDTO = BasicS3DownloadRequestDTO.builder()
                .path(videoDTO.getUploadPath())
                .fileNameWithUUID(videoDTO.getSaved())
                .build();

        ByteArrayResource byteArrayResource = basicS3Service.downloadFile(basicS3DownloadRequestDTO);
        return ResponseEntity
                .ok()
                .contentLength(byteArrayResource.contentLength())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .header("Content-Disposition",
                        "attachment;filename=" +
                                new String(videoDTO.getOriginal().getBytes("utf-8"), "ISO-8859-1"))
                .body(byteArrayResource);
    }

    /**
     *
     * @param multiDownRequestDTO
     * @return
     * @throws IOException
     */
    @PostMapping("/multiple-download")
    public ResponseEntity<?> multipleDown(@RequestBody VideoMultiDownRequestDTO multiDownRequestDTO)
            throws IOException {

        Map<String,Object> resultMap = null;
        resultMap = videoService.multiDownVideo(multiDownRequestDTO);

        ByteArrayResource byteArrayResource = (ByteArrayResource) resultMap.get("zipFile");
        String zipFileName = (String) resultMap.get("zipFileName");
        return ResponseEntity
                .ok()
                .contentLength(byteArrayResource.contentLength())
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .header("Content-Disposition",
                        "attachment;filename=" +
                                new String(zipFileName.getBytes("utf-8"), "ISO-8859-1"))
                .body(byteArrayResource);
    }

    /**
     *
     * @param model
     * @return
     */
    @GetMapping("/manageList")
    public String manageList(Model model) {
        List<VideoDTO> videoList = videoService.manageVideoList();
        model.addAttribute("videoList", videoList);
        return "video/manageList";
    }
}

package kr.co.chunjae.gif.controller;


import kr.co.chunjae.gif.dto.GifDTO;
import kr.co.chunjae.gif.dto.GifSaveRequestDTO;
import kr.co.chunjae.gif.service.GifService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/gif")
public class GifController {
    private final GifService gifService;

    // GIF 등록 화면을 보여주는 메서드
    @GetMapping(value = "/save")
    public String gifSaveForm() {
        return "gif/save";
    }
    // GIF 이미지를 저장하는 메서드
    @PostMapping(value = "/save")
    public ResponseEntity<?> gifSave(@Validated @RequestBody GifSaveRequestDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);

        // GIF 이미지와 썸네일 및 메인 이미지를 저장하는 로직 수행
        gifService.insertGifWithThumbnailAndMainImage(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "이미지가 등록되었습니다");

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(resultMap);
    }

    // GIF 이미지 수정 화면을 보여주는 메서드
    @GetMapping(value = "/update/{gifIdx}")
    public String updateGif(@PathVariable Integer gifIdx) {
        return "gif/update";
    }
    // GIF 이미지 수정을 위한 정보를 조회하는 메서드
    @GetMapping(value = "/update/get-info/{gifIdx}")
    public ResponseEntity<?> getGifInformation(@PathVariable String gifIdx) {
        Integer gifIdxInt = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            gifIdxInt = Integer.parseInt(gifIdx);
        } catch (Exception e) {
            log.error("숫자가 아닌 값이 입력되었습니다");
            errorMap.put("errorMessage", "숫자가 아닌 값이 입력되었습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        // GIF 이미지 정보를 조회
        GifDTO gifDTO = gifService.selectGif(gifIdxInt);
        log.info("gifDTO = {}", gifDTO);

        if (gifDTO == null) {
            errorMap.put("errorMessage", "해당 이미지 idx를 찾을 수 없습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        return ResponseEntity
                .ok(gifDTO);
    }
    // GIF 이미지 수정을 처리하는 메서드
    @PostMapping(value = "/update")
    public ResponseEntity<?> gifUpdate(@Validated @RequestBody GifSaveRequestDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);
        // GIF 이미지와 썸네일 및 메인 이미지를 업데이트하는 로직 수행
        gifService.updateGifWithThumbnailAndMainImage(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "이미지가 업데이트 되었습니다");

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(resultMap);
    }
    // GIF 이미지 상세 화면을 보여주는 메서드
    @GetMapping(value = "/detail/{gifIdx}")
    public String detailGif(@PathVariable Integer gifIdx) {
        return "gif/detail";
    }
    // GIF 이미지 상세 정보를 조회하는 메서드
    @GetMapping(value = "/detail/get-info/{gifIdx}")
    public ResponseEntity<?> detailGifInformation(@PathVariable String gifIdx ) {
        Integer gifIdxInt = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            gifIdxInt = Integer.parseInt(gifIdx);
        } catch (Exception e) {
            log.error("숫자가 아닌 값이 입력되었습니다");
            errorMap.put("errorMessage", "숫자가 아닌 값이 입력되었습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }
        // GIF 이미지 정보를 조회
        GifDTO gifDTO = gifService.selectGif(gifIdxInt);

        log.info("gifDTO = {}", gifDTO);
        if (gifDTO == null) {
            errorMap.put("errorMessage", "해당 이미지 idx를 찾을 수 없습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        return ResponseEntity
                .ok(gifDTO);
    }
    // GIF 이미지 목록 화면을 보여주는 메서드
    @GetMapping(value = "/list")
    public String gifList(Model model) {
        // GIF 이미지 목록을 조회
       /* List<GifDTO> gifList = gifService.getGifList();
        log.info(gifList.toString());
        model.addAttribute("gifList", gifList);*/
        model.addAttribute("gifThumbnailList", gifService.selectgifThumbnailForList());
        return "gif/list";
    }
    @GetMapping(value = "/viewlist")
    public String gitViewList(Model model) {
        model.addAttribute("thumbnailList", gifService.selectgifThumbnailForList());

        return "gif/viewList";
    }
}
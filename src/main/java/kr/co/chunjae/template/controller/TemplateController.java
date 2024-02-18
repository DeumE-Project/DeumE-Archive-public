package kr.co.chunjae.template.controller;

import kr.co.chunjae.contents.dto.ContentsDTO;
import kr.co.chunjae.contents.dto.request.ContentsSaveRequestDTO;
import kr.co.chunjae.template.dto.TemplateSaveDTO;
import kr.co.chunjae.template.dto.TemplateThumbnailDTO;
import kr.co.chunjae.template.service.TemplateService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/template")
public class TemplateController {
    private final TemplateService templateService;

    /**
     * 템플릿 저장
     * @param requestDTO : write 페이지에서 받아온 템플릿 정보
     */
    @PostMapping(value = "/write")
    public ResponseEntity<?> templateSave(@Validated @RequestBody TemplateSaveDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);

        templateService.insertTemplate(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "템플릿이 등록되었습니다");

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(resultMap);
    }

    /**
     * 수정 페이지에서 사용할 기존 썸네일 정보 가져오기
     * @param templateIdx : 가져올 템플릿의 idx
     * @return
     */
    @GetMapping(value = "/update/get-info/{templateIdx}")
    public ResponseEntity<?> getTemplateInformationForUpdate(@PathVariable String templateIdx) {
        Integer idx = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            idx = Integer.parseInt(templateIdx);
        } catch (Exception e) {
            log.error("숫자가 아닌 값이 입력되었습니다");
            errorMap.put("errorMessage", "숫자가 아닌 값이 입력되었습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        List<TemplateThumbnailDTO> templateThumbnailDTOList = templateService.getThumbnailList(idx);
        log.info("TemplateThumbnailDTO = {}", templateThumbnailDTOList);

        if (templateThumbnailDTOList == null) {
            errorMap.put("errorMessage", "해당 idx로 저장된 썸네일을 찾을 수 없습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        return ResponseEntity
                .ok(templateThumbnailDTOList);
    }

    /**
     * 템플릿 수정
     * @param requestDTO : 수정을 위해 받아온 정보
     */
    @PostMapping(value = "/update")
    public ResponseEntity<?> templateUpdate(@Validated @RequestBody TemplateSaveDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);

        templateService.updateTemplate(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "템플릿이 업데이트 되었습니다");

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(resultMap);
    }

    @GetMapping(value = "/category")
    public @ResponseBody String loadCategory(@RequestParam("category") Integer category) {
        String fullCategory = templateService.getFullCategory(category);
        return fullCategory;
    }
}

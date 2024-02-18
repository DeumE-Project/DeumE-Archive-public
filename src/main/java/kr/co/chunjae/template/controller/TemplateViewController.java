package kr.co.chunjae.template.controller;

import kr.co.chunjae.template.dto.TemplateDTO;
import kr.co.chunjae.template.dto.TemplateThumbnailDTO;
import kr.co.chunjae.template.service.TemplateService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/template")
@RequiredArgsConstructor
public class TemplateViewController {
    private final TemplateService templateService;

    // 등록 페이지
    @GetMapping("/write")
    public String writeForm() {
        return "template/write";
    }

    /**
     * 상세보기 페이지
     *
     * @param idx : 상세보기 할 템플릿 idx
     * @model templateList : 썸네일 정보
     * @model templateData : 템플릿 정보
     * @model keywordList : 키워드 ','로 나눠서 출력하기 위한 리스트
     */
    @GetMapping("/detail/{idx}")
    public String templateList(@PathVariable Integer idx, Model model) {
        List<TemplateThumbnailDTO> templateThumbnailDTOList = templateService.getThumbnailList(idx);
        log.info(templateThumbnailDTOList.toString());
        TemplateDTO templateDTO = templateService.getTemplateByIdx(idx);
        String[] keywordList = templateDTO.getKeyword().split(",");

        model.addAttribute("templateList", templateThumbnailDTOList);
        model.addAttribute("templateData", templateDTO);
        model.addAttribute("keywordList", keywordList);
        return "template/detail";
    }

    /**
     * 수정 페이지
     * @param idx : 수정 할 템플릿 idx
     * @model templateData : 템플릿 수정 전 기존 정보
     * @model keywordList : 키워드 ','로 나눠서 출력하기 위한 리스트
     */
    @GetMapping("/update/{idx}")
    public String updateForm(@PathVariable Integer idx, Model model) {
        TemplateDTO templateDTO = templateService.getTemplateByIdx(idx);
        String[] keywordList = templateDTO.getKeyword().split(",");

        model.addAttribute("templateData", templateDTO);
        model.addAttribute("keywordList", keywordList);

        return "template/update";
    }

    /**
     * 사용자 View 템플릿 전체 목록
     * @model thumbnailList : 썸네일과 해당 썸네일이 속한 템플릿의 정보들 ( 노출상태인 템플릿만 출력 )
     */
    @GetMapping
    public String templateList(Model model) {
        List<TemplateThumbnailDTO> thumbnailDTOList = templateService.getThumbnailForTemplateList();
        model.addAttribute("thumbnailList", thumbnailDTOList);
        return "template/list";
    }

    /**
     * 관리자 View 템플릿 관리 전체 목록
     * @model thumbnailList : 썸네일과 해당 썸네일이 속한 템플릿의 정보들
     * @model count : 템플릿 전체 개수
     */
    @GetMapping("/admin")
    public String adminTemplateList(Model model){
        List<TemplateThumbnailDTO> thumbnailDTOList = templateService.getThumbnailForTemplateAdminList();
        int count = templateService.getCountTemplate();
        model.addAttribute("thumbnailList", thumbnailDTOList);
        model.addAttribute("count", count);
        return "template/adminList";
    }
}

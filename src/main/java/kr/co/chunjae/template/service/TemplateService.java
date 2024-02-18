package kr.co.chunjae.template.service;

import kr.co.chunjae.aws.dto.PresignedUrlViewRequestDTO;
import kr.co.chunjae.aws.dto.PresignedUrlViewResponseDTO;
import kr.co.chunjae.aws.service.PresignedUrlService;
import kr.co.chunjae.template.dto.TemplateDTO;
import kr.co.chunjae.template.dto.TemplateSaveDTO;
import kr.co.chunjae.template.dto.TemplateThumbnailDTO;
import kr.co.chunjae.template.repository.TemplateRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class TemplateService {
    private final TemplateRepository templateRepository;
    private final PresignedUrlService presignedUrlService;

    public void insertTemplate(TemplateSaveDTO requestDTO) {
        TemplateDTO templateDTO = TemplateDTO
                .builder()
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getTemplateMainFileDTO().getOriginal())
                .saved(requestDTO.getTemplateMainFileDTO().getSaved())
                .build();
        Integer insertTemplateResult = templateRepository.insertTemplate(templateDTO);
        if (insertTemplateResult != 1) {
            throw new RuntimeException("템플릿 정보를 저장하는 중 오류 발생");
        }

        Map<String, Object> templateThumbnailInsertMap = new HashMap<>();
        templateThumbnailInsertMap.put("templateIdx", templateDTO.getIdx());
        templateThumbnailInsertMap.put("thumbnailList", requestDTO.getTemplateThumbnailList());

        Integer thumbnailInsertResult = templateRepository.insertTemplateThumbnailList(templateThumbnailInsertMap);
        if (requestDTO.getTemplateThumbnailList().size() != thumbnailInsertResult) {
            throw new RuntimeException("템플릿 썸네일 정보를 저장하는 중 오류 발생");
        }
    }

    public List<TemplateThumbnailDTO> getThumbnailList(Integer idx) {
        return templateRepository.getThumbnailList(idx);
    }

    public TemplateDTO getTemplateByIdx(Integer idx) {
        return templateRepository.getTemplateByIdx(idx);
    }

    public void updateTemplate(TemplateSaveDTO requestDTO) {
        templateRepository.deleteTemplateThumbnailByIdx(requestDTO.getIdx());
        TemplateDTO templateUpdateDTO = TemplateDTO
                .builder()
                .idx(requestDTO.getIdx())
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getTemplateMainFileDTO().getOriginal())
                .saved(requestDTO.getTemplateMainFileDTO().getSaved())
                .build();

        templateRepository.updateTemplate(templateUpdateDTO);

        Map<String, Object> templateThumbnailInsertMap = new HashMap<>();
        templateThumbnailInsertMap.put("templateIdx", templateUpdateDTO.getIdx());
        templateThumbnailInsertMap.put("thumbnailList", requestDTO.getTemplateThumbnailList());

        Integer thumbnailInsertResult = templateRepository.insertTemplateThumbnailList(templateThumbnailInsertMap);
        if (requestDTO.getTemplateThumbnailList().size() != thumbnailInsertResult) {
            throw new RuntimeException("템플릿 썸네일 정보를 저장하는 중 오류 발생");
        }
    }

    public List<TemplateThumbnailDTO> getThumbnailForTemplateList() {
        List<TemplateThumbnailDTO> templateThumbnailList = templateRepository.getThumbnailForTemplateList();

        // 불러온 썸네일 리스트 각각에 이미지 불러오기 위한 presigned url 저장
        templateThumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
        });
        return templateThumbnailList;
    }
    public List<TemplateThumbnailDTO> getThumbnailForTemplateListInMain() {
        List<TemplateThumbnailDTO> templateThumbnailList = templateRepository.getThumbnailForTemplateListInMain();

        // 불러온 썸네일 리스트 각각에 이미지 불러오기 위한 presigned url 저장
        templateThumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
        });
        return templateThumbnailList;
    }

    public List<TemplateThumbnailDTO> getThumbnailForTemplateAdminList() {
        List<TemplateThumbnailDTO> templateThumbnailList = templateRepository.getThumbnailForTemplateAdminList();
        // 불러온 썸네일 리스트 각각에 이미지 불러오기 위한 presigned url 저장
        templateThumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());

        });
        return templateThumbnailList;
    }

    public int getCountTemplate() {
        return templateRepository.getCountTemplate();
    }

    public String getFullCategory(Integer category) {
        return templateRepository.getFullCategory(category);
    }
}

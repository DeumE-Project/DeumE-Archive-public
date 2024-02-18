package kr.co.chunjae.template.mapper;

import kr.co.chunjae.common.dto.CategoryDTO;
import kr.co.chunjae.template.dto.TemplateDTO;
import kr.co.chunjae.template.dto.TemplateThumbnailDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TemplateMapper {
    Integer insertTemplate(TemplateDTO templateDTO);

    Integer insertTemplateThumbnailList(Map<String, Object> templateThumbnailInsertMap);

    List<TemplateThumbnailDTO> getThumbnailList(Integer idx);

    TemplateDTO getTemplateByIdx(Integer idx);

    void deleteTemplateThumbnailByIdx(Integer idx);

    void updateTemplate(TemplateDTO templateUpdateDTO);

    List<TemplateThumbnailDTO> getThumbnailForTemplateList();

    List<TemplateThumbnailDTO> getThumbnailForTemplateListInMain();

    List<TemplateThumbnailDTO> getThumbnailForTemplateAdminList();

    Integer getCountTemplate();

    CategoryDTO getCategory(Integer category);
}

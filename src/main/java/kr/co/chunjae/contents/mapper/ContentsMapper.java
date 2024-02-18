package kr.co.chunjae.contents.mapper;

import kr.co.chunjae.contents.dto.ContentsDTO;
import kr.co.chunjae.contents.dto.ContentsThumbnailDTO;
import kr.co.chunjae.contents.validation.ValidList;
import org.apache.ibatis.annotations.Mapper;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Mapper
public interface ContentsMapper {
    Integer insertContents(ContentsDTO contentsDTO);

    ContentsDTO selectContents(Integer idx);

    Integer insertContentsThumbnailList(Map<String, Object> contentsThumbnailInsertMap);

    Integer deleteContentsThumbnailByContentsIdx(Integer contentsIdx);

    Integer updateContents(ContentsDTO contentsDTO);

    Map<String, String> selectContentsMainImage(Integer contentsIdx);

    List<Map<String, String>> selectContentsThumbnail(Integer contentsIdx);

    List<ContentsThumbnailDTO> selectContentsThumbnailForList();
    List<ContentsThumbnailDTO> selectContentsThumbnailForListInMain();

    List<String> selectContentsFileNameList(@ValidList @Valid List<Integer> contentsIdxList);

    List<ContentsDTO> selectContentsForManage();
}
package kr.co.chunjae.contents.repository;

import kr.co.chunjae.contents.dto.ContentsDTO;
import kr.co.chunjae.contents.dto.ContentsThumbnailDTO;
import kr.co.chunjae.contents.mapper.ContentsMapper;
import kr.co.chunjae.contents.validation.ValidList;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ContentsRepository {
    private final ContentsMapper contentsMapper;

    public Integer insertContents(ContentsDTO contentsDTO) {
        return contentsMapper.insertContents(contentsDTO);
    }

    public ContentsDTO selectContents(Integer idx) {
        return contentsMapper.selectContents(idx);
    }

    public Integer insertContentsThumbnailList(Map<String, Object> contentsThumbnailInsertMap) {
        return contentsMapper.insertContentsThumbnailList(contentsThumbnailInsertMap);
    }

    public Integer deleteContentsThumbnailByContentsIdx(Integer contentsIdx) {
        return contentsMapper.deleteContentsThumbnailByContentsIdx(contentsIdx);
    }

    public Integer updateContents(ContentsDTO contentsDTO) {
        return contentsMapper.updateContents(contentsDTO);
    }

    public Map<String, String> selectContentsMainImage(Integer contentsIdx) {
        return contentsMapper.selectContentsMainImage(contentsIdx);
    }

    public List<Map<String, String>> selectContentsThumbnail(Integer contentsIdx) {
        return contentsMapper.selectContentsThumbnail(contentsIdx);
    }

    public List<ContentsThumbnailDTO> selectContentsThumbnailForList() {
        return contentsMapper.selectContentsThumbnailForList();
    }
    public List<ContentsThumbnailDTO> selectContentsThumbnailForListInMain() {
        return contentsMapper.selectContentsThumbnailForListInMain();
    }

    public List<String> selectContentsFileNameList(@ValidList @Valid List<Integer> contentsIdxList) {
        return contentsMapper.selectContentsFileNameList(contentsIdxList);
    }

    public List<ContentsDTO> selectContentsForManage() {
        return contentsMapper.selectContentsForManage();
    }
}

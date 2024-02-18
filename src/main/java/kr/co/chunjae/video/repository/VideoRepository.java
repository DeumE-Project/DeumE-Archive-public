package kr.co.chunjae.video.repository;

import kr.co.chunjae.video.dto.VideoDTO;
import kr.co.chunjae.video.dto.VideoThumbnailDTO;
import kr.co.chunjae.video.mapper.VideoMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Slf4j
@Repository
@RequiredArgsConstructor
public class VideoRepository {
    private final VideoMapper videoMapper;

    public Integer saveVideo(VideoDTO videoDTO) {
        return videoMapper.saveVideo(videoDTO);
    }

    public VideoDTO selectVideo(Integer idx) {
        return videoMapper.selectVideo(idx);
    }

    public Integer videoThumbnailsList(Map<String, Object> videoThumbnailsSaveMap) {
        return videoMapper.videoThumbnailsList(videoThumbnailsSaveMap);
    }

    public Integer deleteVideoThumbnailByVideoIdx(Integer videoIdx) {
        return videoMapper.deleteVideoThumbnailByVideoIdx(videoIdx);
    }

    public Integer updateVideo(VideoDTO videoDTO) {
        return videoMapper.updateVideo(videoDTO);
    }

    public Map<String, String> selectVideoFile(Integer videoIdx) {

        return videoMapper.selectVideoFile(videoIdx);
    }

    public List<Map<String, Object>> selectVideoThumbnail(Integer videoIdx) {
        return videoMapper.selectVideoThumbnail(videoIdx);
    }

    public List<VideoThumbnailDTO> selectVideoListThumbnail() {return videoMapper.selectVideoListThumbnail();}

    public List<VideoThumbnailDTO> selectVideoListThumbnailInMain() {return videoMapper.selectVideoListThumbnailInMain();}

    public List<String> selectVideoFileNameList(List<Integer> videoIdxList) {
        return videoMapper.selectVideoFileNameList(videoIdxList);
    }

    public List<VideoDTO> manageVideoList() {
        return videoMapper.manageVideoList();

    }
}

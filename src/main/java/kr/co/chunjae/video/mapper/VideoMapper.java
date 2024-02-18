package kr.co.chunjae.video.mapper;

import kr.co.chunjae.video.dto.VideoDTO;
import kr.co.chunjae.video.dto.VideoThumbnailDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface VideoMapper {
    Integer saveVideo(VideoDTO videoDTO);

    VideoDTO selectVideo(Integer idx);

    Integer videoThumbnailsList(Map<String, Object> videoThumbnailsSaveMap);

    Integer deleteVideoThumbnailByVideoIdx(Integer videoIdx);

    Integer updateVideo(VideoDTO videoDTO);


    Map<String, String> selectVideoFile(Integer videoIdx);

    List<Map<String, Object>> selectVideoThumbnail(Integer videoIdx);

    List<VideoThumbnailDTO> selectVideoListThumbnail();

    List<VideoThumbnailDTO> selectVideoListThumbnailInMain();

    List<String> selectVideoFileNameList(List<Integer> videoIdxList);

    List<VideoDTO> manageVideoList();
}

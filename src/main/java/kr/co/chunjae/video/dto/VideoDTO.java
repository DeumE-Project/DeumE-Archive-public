package kr.co.chunjae.video.dto;

import kr.co.chunjae.common.dto.BaseDTO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;

import java.util.List;

@Getter @Setter @ToString
@NoArgsConstructor
@SuperBuilder
public class VideoDTO extends BaseDTO {
    // 여기에다가 필요한 필드 추가
    private Integer maincateIdx;
    private List<VideoThumbnailDTO> videoThumbnailList;
    private String maincateName;
    private String subcateName;

}

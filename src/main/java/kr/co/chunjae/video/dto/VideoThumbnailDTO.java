package kr.co.chunjae.video.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.annotation.security.DenyAll;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VideoThumbnailDTO {
    private Integer idx;
    private Integer videoIdx;
    private String original;
    private String saved;
    private String uploadPath;
    private String savedPath;
    private Integer orders;
    private String name;
    private String presignedUrl;
}

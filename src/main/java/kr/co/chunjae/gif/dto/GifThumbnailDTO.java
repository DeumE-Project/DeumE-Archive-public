package kr.co.chunjae.gif.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GifThumbnailDTO {
    private Integer idx;
    private Integer gifIdx;
    private String original;
    private String saved;
    private String uploadPath;
    private String savedPath;
    private Integer orders;

    // 원본 콘텐츠 제목
    private String name;
    // list 페이지에서 필요한
    private String presignedUrl;

    private String explanation;
    private String source;
    private String updateDate;
    private String tmName;
    private String tsName;
}

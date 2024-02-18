package kr.co.chunjae.packages.dto;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PackagesThumbnailDTO {

    private Integer idx;
    private Integer packagesIdx;
    private String uploadPath;
    private String savedPath;

    @NotBlank(message = "썸네일 원본 파일명은 필수 입력값입니다")
    private String original;

    @NotBlank(message = "썸네일 저장 파일명은 필수 입력값입니다")
    private String saved;

    @NotNull(message = "썸네일 순서는 필수 입력값입니다")
    @Positive(message = "썸네일 순서는 양의 정수입니다")
    private Integer orders;

    // 원본 콘텐츠 제목
    private String name;

    // list 페이지에서 필요한 presignedUrl
    private String presignedUrl;

    private String explanation;
    private String source;
    private String updateDate;

}

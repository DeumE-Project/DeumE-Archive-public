package kr.co.chunjae.gif.dto;

import kr.co.chunjae.contents.validation.ValidList;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Data
public class GifSaveRequestDTO {
    @NotNull(message = "콘텐츠 유형은 필수 입력값입니다")
    private Integer type;

    @NotNull(message = "노출 여부는 필수 입력값입니다")
    private Integer display;

    @NotBlank(message = "제목은 필수 입력값입니다")
    private String name;

    @NotNull(message = "키워드는 필수 입력값입니다")
    private String keyword;

    private String explanation = "";
    private String source = "";

    @NotNull(message = "서브 카테고리는 필수 입력값입니다")
    private Integer subCategory;

    @ValidList(message = "썸네일 이미지는 최소 한 개 이상이여야 합니다")
    @Valid
    private List<GifThumbnailSaveRequestDTO> thumbnailSaveRequestList;

    @NotNull(message = "메인 이미지는 필수 입력값입니다")
    @Valid
    private GifMainImageSaveRequestDTO mainImageSaveRequestDTO;

    private Integer idx;
}

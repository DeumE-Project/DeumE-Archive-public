package kr.co.chunjae.template.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

@Data
public class TemplateThumbnailDTO {
    @NotBlank(message = "템플릿 썸네일 원본 파일명은 필수 입력값입니다")
    private String original;

    @NotBlank(message = "템플릿 썸네일 저장 파일명은 필수 입력값입니다")
    private String saved;

    @NotNull(message = "템플릿 썸네일 순서는 필수 입력값입니다")
    @Positive(message = "템플릿 썸네일 순서는 양의 정수입니다")
    private Integer orders;

    private String savedPath;

    private String uploadPath;

    private Integer templateIdx;

    private String presignedUrl;

    private String name;

    // 사용자 뷰 리스트에서 메인 파일 다운로드를 위한 선언
    private String mainSaved;
    // 사용자 뷰 리스트에서 메인 파일 다운로드를 위한 선언
    private String mainOriginal;

    // 관리자 뷰 리스트에서 보여주기 위한 유형 선언
    private Integer typeIdx;
    // 관리자 뷰 리스트에서 보여주기 위한 노출 여부
    private Integer display;
    // 관리자 뷰 리스트에서 보여주기 위한 등록일
    private String registerDate;
    // 관리자 뷰 리스트에서 보여주기 위한 순서
    private Integer count;
}

package kr.co.chunjae.video.dto;

import lombok.Data;

import java.util.List;

@Data
public class VideoMultiDownRequestDTO {
    private List<Integer> videoIdxList;
}

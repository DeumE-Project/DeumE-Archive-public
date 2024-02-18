package kr.co.chunjae.gif.service;

import kr.co.chunjae.aws.dto.PresignedUrlViewRequestDTO;
import kr.co.chunjae.aws.dto.PresignedUrlViewResponseDTO;
import kr.co.chunjae.aws.service.BasicS3Service;
import kr.co.chunjae.aws.service.PresignedUrlService;
import kr.co.chunjae.contents.dto.ContentsThumbnailDTO;
import kr.co.chunjae.gif.dto.GifDTO;
import kr.co.chunjae.gif.dto.GifSaveRequestDTO;
import kr.co.chunjae.gif.dto.GifThumbnailDTO;
import kr.co.chunjae.gif.repository.GifRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class GifService {
    private final GifRepository gifRepository;
    private final BasicS3Service basicS3Service;
    private final PresignedUrlService presignedUrlService;

    // GIF 정보를 DB에 등록하는 메서드
    public Integer insertGif(GifDTO gifDTO) {
        Integer insertResult = gifRepository.insertGif(gifDTO);
        return insertResult;
    }
    // GIF 정보를 DB에서 조회하는 메서드
    public GifDTO selectGif(Integer idx) {
        return gifRepository.selectGif(idx);
    }

    // GIF 이미지와 썸네일 및 메인 이미지를 함께 저장하는 메서드
    public void insertGifWithThumbnailAndMainImage(GifSaveRequestDTO requestDTO) {
        // 새로운 GifDTO 객체를 생성하여 requestDTO 정보를 복사
        GifDTO newGifDTO = GifDTO
                .builder()
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getMainImageSaveRequestDTO().getOriginal())
                .saved(requestDTO.getMainImageSaveRequestDTO().getSaved())
                .build();
        // GIF 정보를 DB에 저장
        Integer gifInfoInsertResult = insertGif(newGifDTO);
        if (gifInfoInsertResult != 1) {
            throw new RuntimeException("Gif 정보를 저장하는 중 오류 발생");
        }

        // GIF의 썸네일 정보를 Map에 저장하여 DB에 삽입
        Map<String, Object> gifThumbnailInsertMap = new HashMap<>();
        gifThumbnailInsertMap.put("gifIdx", newGifDTO.getIdx());
        gifThumbnailInsertMap.put("thumbnailList", requestDTO.getThumbnailSaveRequestList());

        Integer thumbnailInsertResult = gifRepository.insertGifThumbnailList(gifThumbnailInsertMap);
        if (requestDTO.getThumbnailSaveRequestList().size() != thumbnailInsertResult) {
            throw new RuntimeException("Gif 썸네일 정보를 저장하는 중 오류 발생");
        }
    }
    // GIF 이미지와 썸네일 및 메인 이미지를 함께 업데이트하는 메서드
    public void updateGifWithThumbnailAndMainImage(GifSaveRequestDTO requestDTO) {
        // 원래 있던 contentsThumbnail 삭제
        Integer gifThumbnailDeleteResult =
                gifRepository.deleteGifThumbnailByGifIdx(requestDTO.getIdx());

        // 업데이트를 위한 GifDTO 객체 생성
        GifDTO gifDTOForUpdate = GifDTO
                .builder()
                .idx(requestDTO.getIdx())
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getMainImageSaveRequestDTO().getOriginal())
                .saved(requestDTO.getMainImageSaveRequestDTO().getSaved())
                .build();
        // GIF 정보 업데이트
        Integer gifUpdateResult = gifRepository.updateGif(gifDTOForUpdate);
        // 업데이트된 GIF의 썸네일 정보를 Map에 저장하여 DB에 삽입
        Map<String, Object> gifThumbnailInsertMap = new HashMap<>();
        gifThumbnailInsertMap.put("gifIdx", gifDTOForUpdate.getIdx());
        gifThumbnailInsertMap.put("thumbnailList", requestDTO.getThumbnailSaveRequestList());

        Integer gifThumbnailInsertResult = gifRepository.insertGifThumbnailList(gifThumbnailInsertMap);
    }
    // 파일 삭제 메서드
    private void deleteFile(File file) {
        if (file.exists()) {
            file.delete();
        }
    }
    // GIF 이미지 목록을 조회하는 메서드
    public List<GifDTO> getGifList() {
        return gifRepository.getGifList();
    }

  public Object selectgifThumbnailForList() {
      List<GifThumbnailDTO> thumbnailList = gifRepository.selectGifThumbnailForList();
      thumbnailList.stream().forEach((thumbnail) -> {
          PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
          requestDTO.setPath(thumbnail.getSavedPath());
          requestDTO.setFileNameWithUUID(thumbnail.getSaved());
          PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
          thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
      });
      return thumbnailList;
  }

    public Object selectGifThumbnailForListInMain() {
        List<GifThumbnailDTO> thumbnailList = gifRepository.selectGifThumbnailForListInMain();
        thumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
        });
        return thumbnailList;
    }
}

package kr.co.chunjae.video.service;

import kr.co.chunjae.aws.dto.BasicS3DownloadRequestDTO;
import kr.co.chunjae.aws.dto.PresignedUrlViewRequestDTO;
import kr.co.chunjae.aws.dto.PresignedUrlViewResponseDTO;
import kr.co.chunjae.aws.service.BasicS3Service;
import kr.co.chunjae.aws.service.PresignedUrlService;
import kr.co.chunjae.video.dto.VideoDTO;
import kr.co.chunjae.video.dto.VideoMultiDownRequestDTO;
import kr.co.chunjae.video.dto.VideoSaveRequestDTO;
import kr.co.chunjae.video.dto.VideoThumbnailDTO;
import kr.co.chunjae.video.repository.VideoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class VideoService {
    private final VideoRepository videoRepository;
    private final BasicS3Service basicS3Service;
    private final PresignedUrlService presignedUrlService;


    /**
     *
     * @param videoDTO
     * @return
     */
    public Integer saveVideo(VideoDTO videoDTO) {
        Integer saveResult = videoRepository.saveVideo(videoDTO);
        return saveResult;
    }

    /**
     *
     */

    public VideoDTO selectVideo(Integer idx) {
        return videoRepository.selectVideo(idx);
    }

    /**
     *
     * @param saveRequestDTO
     */
    public void saveVideoWithThumbnailAndVideoFile(VideoSaveRequestDTO saveRequestDTO) {
        VideoDTO newVideoDTO = VideoDTO
                .builder()
                .typeIdx(saveRequestDTO.getType())
                .display(saveRequestDTO.getDisplay())
                .subcateIdx(saveRequestDTO.getSubCategory())
                .name(saveRequestDTO.getName())
                .explanation(saveRequestDTO.getExplanation())
                .source(saveRequestDTO.getSource())
                .keyword(saveRequestDTO.getKeyword())
                .original(saveRequestDTO.getFileSaveRequestDTO().getOriginal())
                .saved(saveRequestDTO.getFileSaveRequestDTO().getSaved())
                .build();
        log.info("saveRequestDTO = ", saveRequestDTO);

        Integer videoInfoSaveResult = saveVideo(newVideoDTO);
        if (videoInfoSaveResult != 1) {
            throw new RuntimeException("update video info Error!");
        }

        Map<String, Object> videoThumbnailSaveMap = new HashMap<>();
        videoThumbnailSaveMap.put("videoIdx", newVideoDTO.getIdx());
        videoThumbnailSaveMap.put("thumbnailList", saveRequestDTO.getThumbnailSaveRequestList());

        Integer videoThumbnailSaveResult = videoRepository.videoThumbnailsList(videoThumbnailSaveMap);
        if (saveRequestDTO.getThumbnailSaveRequestList().size() != videoThumbnailSaveResult) {
        throw new RuntimeException("thumbnail(s) saved Error");
        }
    }

    /**
     *
     * @param saveRequestDTO
     */
    public void updateVideoWithThumbnailAndVideoFile(VideoSaveRequestDTO saveRequestDTO) {
        // 기존 video의 thumbnail(s) 삭제
        Integer videoThumbnailDeleteResult =
                videoRepository.deleteVideoThumbnailByVideoIdx(saveRequestDTO.getIdx());

        VideoDTO updateVideoDTO = VideoDTO
                .builder()
                .idx(saveRequestDTO.getIdx())
                .typeIdx(saveRequestDTO.getType())
                .display(saveRequestDTO.getDisplay())
                .name(saveRequestDTO.getName())
                .keyword(saveRequestDTO.getKeyword())
                .explanation(saveRequestDTO.getExplanation())
                .source(saveRequestDTO.getSource())
                .subcateIdx(saveRequestDTO.getSubCategory())
                .original(saveRequestDTO.getFileSaveRequestDTO().getOriginal())
                .saved(saveRequestDTO.getFileSaveRequestDTO().getSaved())
                .build();

        Integer videoUpdateResult = videoRepository.updateVideo(updateVideoDTO);

        Map<String, Object> videoThumbnailSavetMap = new HashMap<>();
        videoThumbnailSavetMap.put("videoIdx", updateVideoDTO.getIdx());
        videoThumbnailSavetMap.put("thumbnailList", saveRequestDTO.getThumbnailSaveRequestList());

        Integer videoThumbnailSaveResult = videoRepository.videoThumbnailsList(videoThumbnailSavetMap);
    }

    /**
     *
     * @param videoIdx
     * @return
     * @throws IOException
     */
    public Map<String, Object> downloadZipFile(Integer videoIdx) throws IOException {
        List<String> filePathList = new ArrayList<>();
        List<String> fileNameList = new ArrayList<>();

        // video File 경로 및 파일명 uuid 조회
        Map<String,String> videoFilePathAndName = videoRepository.selectVideoFile(videoIdx);
        filePathList.add(videoFilePathAndName.get("uploadPath"));
        fileNameList.add(videoFilePathAndName.get("saved"));
        // video의 thumbnail 조회
        List<Map<String,Object>> thumbnailInfoList = videoRepository.selectVideoThumbnail(videoIdx);

        thumbnailInfoList.forEach((thumbnailInfo) -> {
            filePathList.add(thumbnailInfo.get("uploadPath").toString());
            fileNameList.add(thumbnailInfo.get("saved").toString());
        });

        List<ByteArrayResource> byteArrayResourceList = new ArrayList<>();

        for (int i = 0; i < filePathList.size(); i++) {
            ByteArrayResource byteArrayResource = basicS3Service.downloadFile(
                    BasicS3DownloadRequestDTO.builder()
                            .path(filePathList.get(i))
                            .fileNameWithUUID(fileNameList.get(i))
                            .build());
            byteArrayResourceList.add(byteArrayResource);
        }

        return generateZipFileWithZipFileName(byteArrayResourceList, fileNameList);
    }

    /**
     *
     * @param byteArrayResourceList
     * @param fileNameList
     * @return
     * @throws IOException
     */
    private Map<String, Object> generateZipFileWithZipFileName(List<ByteArrayResource> byteArrayResourceList,
                                                               List<String> fileNameList) throws IOException {
        List<File> fileList = new ArrayList<>();

        for (int i = 0; i < byteArrayResourceList.size(); i++) {
            ByteArrayResource resource = byteArrayResourceList.get(i);
            InputStream inputStream = resource.getInputStream();
            String fileName = fileNameList.get(i);
            String fileNameWithoutUUIDAndExtension = fileName.substring(
                    fileName.indexOf("_") + 1,
                    fileName.lastIndexOf("."));
            String extension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
            File tempFile = File.createTempFile(fileNameWithoutUUIDAndExtension, extension);
            FileCopyUtils.copy(inputStream.readAllBytes(), tempFile);
            fileList.add(tempFile);
        }

        LocalDateTime nowDate = LocalDateTime.now();
        String formatDate = nowDate.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss"));
        String zipFileName = "DeumeArchive_Video_" + formatDate;
        File zipFile = File.createTempFile(zipFileName, ".zip");
        zipFile.deleteOnExit();

        try (ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFile))) {
            byte[] buf = new byte[1_024];
            for (File file : fileList) {
                if (file.exists()) {
                    try (FileInputStream fis = new FileInputStream(file)) {
                        ZipEntry zipEntry = new ZipEntry(file.getName());
                        out.putNextEntry(zipEntry);
                        int len;
                        while ((len = fis.read(buf)) > 0) {
                            out.write(buf, 0, len);
                        }
                        out.closeEntry();
                    }
                }
            }
            for (File file : fileList) {
                deleteFile(file);
            }
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("zipFileName", zipFileName + ".zip");
        resultMap.put("zipFile", new ByteArrayResource(FileCopyUtils.copyToByteArray(zipFile)));
        return resultMap;
    }

    /**
     *
     * @param file
     */
    private void deleteFile(File file) {
        if (file.exists()) {
            file.delete();
        }
    }

    /**
     *
     * @return
     */
    public List<VideoThumbnailDTO> selectVideoListThumbnail(){
        List<VideoThumbnailDTO> thumbnailList = videoRepository.selectVideoListThumbnail();
        thumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());

        });
        return thumbnailList;
    }

    /**
     *
     * @return
     */
    public List<VideoThumbnailDTO> selectVideoListThumbnailInMain(){
        List<VideoThumbnailDTO> thumbnailList = videoRepository.selectVideoListThumbnailInMain();
        thumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());

        });
        return thumbnailList;
    }

    /**
     *
     * @param multiDownRequestDTO
     * @return
     * @throws IOException
     */

    public Map<String, Object> multiDownVideo(VideoMultiDownRequestDTO multiDownRequestDTO) throws IOException{
        final String filePath ="video/";
        List<String> fileNameList = videoRepository.selectVideoFileNameList(multiDownRequestDTO.getVideoIdxList());

        List<ByteArrayResource> byteArrayResourceList = new ArrayList<>();
        fileNameList.stream().forEach((fileName) -> {
            byteArrayResourceList.add(
                    basicS3Service.downloadFile(
                            BasicS3DownloadRequestDTO
                                    .builder()
                                    .path(filePath)
                                    .fileNameWithUUID(fileName)
                                    .build()
                    )
            );
        });

        Map<String, Object> resultMap = generateZipFileWithZipFileName(byteArrayResourceList, fileNameList);
        return resultMap;

    }

    /**
     *
     * @return
     */

    public List<VideoDTO> manageVideoList() {
        List<VideoDTO> videoList = videoRepository.manageVideoList();
        videoList.stream()
                .forEach((video) -> {
                    video.getVideoThumbnailList().stream()
                            .forEach((thumbnail) ->{
                                PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
                                requestDTO.setPath(thumbnail.getSavedPath());
                                requestDTO.setFileNameWithUUID(thumbnail.getSaved());
                                PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
                                thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
                            } );
                });
        return videoList;

    }
}

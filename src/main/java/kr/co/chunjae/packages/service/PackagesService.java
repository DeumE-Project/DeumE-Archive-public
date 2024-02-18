package kr.co.chunjae.packages.service;

import kr.co.chunjae.aws.dto.PresignedUrlViewRequestDTO;
import kr.co.chunjae.aws.dto.PresignedUrlViewResponseDTO;
import kr.co.chunjae.aws.service.PresignedUrlService;
import kr.co.chunjae.packages.dto.PackagesDTO;
import kr.co.chunjae.packages.dto.PackagesSaveDTO;
import kr.co.chunjae.packages.dto.PackagesThumbnailDTO;
import kr.co.chunjae.packages.repository.PackagesRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@Transactional
public class PackagesService {
    private final PackagesRepository packagesRepository;
    private final PresignedUrlService presignedUrlService;

    public void insertPackages(PackagesSaveDTO requestDTO) {
        PackagesDTO packagesDTO = PackagesDTO
                .builder()
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getPackagesMainFileDTO().getOriginal())
                .saved(requestDTO.getPackagesMainFileDTO().getSaved())
                .build();
        Integer insertPackagesResult = packagesRepository.insertPackages(packagesDTO);
        if (insertPackagesResult != 1){
            throw new RuntimeException("꾸러미 정보를 저장하는 중 오류 발생");
        }

        Map<String, Object> packagesThumbnailInsertMap = new HashMap<>();
        packagesThumbnailInsertMap.put("packagesIdx", packagesDTO.getIdx());
        packagesThumbnailInsertMap.put("thumbnailList", requestDTO.getPackagesThumbnailList());

        Integer thumbnailInsertResult = packagesRepository.insertPackagesThumbnailList(packagesThumbnailInsertMap);
        if (requestDTO.getPackagesThumbnailList().size() != thumbnailInsertResult) {
            throw new RuntimeException("꾸러미 썸네일 정보를 저장하는 중 오류 발생");
        }
    }

    public List<PackagesThumbnailDTO> getThumbnailList(Integer idx) {
        return packagesRepository.getThumbnailList(idx);
    }

    public PackagesDTO getPackagesByIdx(Integer idx) {
        return packagesRepository.getPackagesByIdx(idx);
    }

    public void updatePackages(PackagesSaveDTO requestDTO) {
        packagesRepository.deletePackagesThumbnailByIdx(requestDTO.getIdx());
        PackagesDTO packagesUpdateDTO = PackagesDTO
                .builder()
                .idx(requestDTO.getIdx())
                .typeIdx(requestDTO.getType())
                .display(requestDTO.getDisplay())
                .name(requestDTO.getName())
                .keyword(requestDTO.getKeyword())
                .explanation(requestDTO.getExplanation())
                .source(requestDTO.getSource())
                .subcateIdx(requestDTO.getSubCategory())
                .original(requestDTO.getPackagesMainFileDTO().getOriginal())
                .saved(requestDTO.getPackagesMainFileDTO().getSaved())
                .build();

        packagesRepository.updatePackages(packagesUpdateDTO);

        Map<String, Object> packagesThumbnailInsertMap = new HashMap<>();
        packagesThumbnailInsertMap.put("packagesIdx", packagesUpdateDTO.getIdx());
        packagesThumbnailInsertMap.put("thumbnailList", requestDTO.getPackagesThumbnailList());

        Integer thumbnailInsertResult = packagesRepository.insertPackagesThumbnailList(packagesThumbnailInsertMap);
        if (requestDTO.getPackagesThumbnailList().size() != thumbnailInsertResult) {
            throw new RuntimeException("썸네일 정보를 저장하는 중 오류 발생");
        }
    }



    public Object selectPackagesThumbnailList() {
        List<PackagesThumbnailDTO> thumbnailList = packagesRepository.selectPackagesThumbnailList();
        thumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
        });
        return thumbnailList;
    }

    public Object selectPackagesThumbnailListInMain() {
        List<PackagesThumbnailDTO> thumbnailList = packagesRepository.selectPackagesThumbnailListInMain();
        thumbnailList.stream().forEach((thumbnail) -> {
            PresignedUrlViewRequestDTO requestDTO = new PresignedUrlViewRequestDTO();
            requestDTO.setPath(thumbnail.getSavedPath());
            requestDTO.setFileNameWithUUID(thumbnail.getSaved());
            PresignedUrlViewResponseDTO responseDTO = presignedUrlService.generatePresignedUrlForView(requestDTO);
            thumbnail.setPresignedUrl(responseDTO.getPresignedUrl());
        });
        return thumbnailList;
    }

    public String getCategoryList(Integer category) {return packagesRepository.getCategoryList(category);
    }
}
package kr.co.chunjae.packages.repository;

import kr.co.chunjae.common.dto.CategoryDTO;
import kr.co.chunjae.packages.dto.PackagesDTO;
import kr.co.chunjae.packages.dto.PackagesThumbnailDTO;
import kr.co.chunjae.packages.mapper.PackagesMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Slf4j
@Repository
@RequiredArgsConstructor
public class PackagesRepository {
    private final PackagesMapper packagesMapper;

    public Integer insertPackages(PackagesDTO packagesDTO) {
        return packagesMapper.insertPackages(packagesDTO);
    }

    public Integer insertPackagesThumbnailList(Map<String, Object> packagesThumbnailInsertMap){
        return packagesMapper.insertPackagesThumbnailList(packagesThumbnailInsertMap);
    }

    public List<PackagesThumbnailDTO> getThumbnailList(Integer idx) {
        return packagesMapper.getThumbnailList(idx);
    }

    public PackagesDTO getPackagesByIdx(Integer idx) {
        return packagesMapper.getPackagesByIdx(idx);
    }

    public void deletePackagesThumbnailByIdx(Integer idx) {
        packagesMapper.deletePackagesThumbnailByIdx(idx);
    }

    public void updatePackages(PackagesDTO packagesUpdateDTO) {
        packagesMapper.updatePackages(packagesUpdateDTO);
    }


    public List<PackagesThumbnailDTO> selectPackagesThumbnailList() {
        return packagesMapper.selectPackagesThumbnailList();
    }

    public List<PackagesThumbnailDTO> selectPackagesThumbnailListInMain() {
        return packagesMapper.selectPackagesThumbnailListInMain();
    }

    public String getCategoryList(Integer category) {
        CategoryDTO categoryDTO = packagesMapper.getCategoryList(category);
        log.info(String.valueOf(categoryDTO));
        String categoryList = categoryDTO.getMaincateName() + " > " + categoryDTO.getSubcateName();
        log.info(categoryList);
        return categoryList;
    }
}

package kr.co.chunjae.packages.mapper;

import kr.co.chunjae.common.dto.CategoryDTO;
import kr.co.chunjae.packages.dto.PackagesDTO;
import kr.co.chunjae.packages.dto.PackagesThumbnailDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface PackagesMapper {
    Integer insertPackages(PackagesDTO packagesDTO);

    Integer insertPackagesThumbnailList(Map<String, Object> packagesThumbnailInsertMap);

    List<PackagesThumbnailDTO> getThumbnailList(Integer idx);

    PackagesDTO getPackagesByIdx(Integer idx);

    void deletePackagesThumbnailByIdx(Integer idx);

    void updatePackages(PackagesDTO packagesUpdateDTO);


    List<PackagesThumbnailDTO> selectPackagesThumbnailList();

    List<PackagesThumbnailDTO> selectPackagesThumbnailListInMain();

    CategoryDTO getCategoryList(Integer category);
}

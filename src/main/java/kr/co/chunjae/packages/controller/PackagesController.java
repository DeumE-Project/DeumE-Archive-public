package kr.co.chunjae.packages.controller;

import kr.co.chunjae.packages.dto.PackagesDTO;
import kr.co.chunjae.packages.dto.PackagesSaveDTO;
import kr.co.chunjae.packages.dto.PackagesThumbnailDTO;
import kr.co.chunjae.packages.service.PackagesService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/packages")
public class PackagesController {
    private final PackagesService packagesService;

    // 뷰를 반환하는 메서드
    @GetMapping(value = "/loadPackages")
    public String packagesLoadForm(){
        return "packages/loadPackages";
    }

    // 패키지를 저장하기 위한 HTTP POST 요청을 처리하는 메서드
    @PostMapping(value = "/loadPackages")
    public ResponseEntity<?> packagesSave(@Validated @RequestBody PackagesSaveDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);

        packagesService.insertPackages(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "꾸러미가 등록되었습니다");

        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(resultMap);
    }


    @GetMapping("/detailPackages/{idx}")
    public String packagesList(@PathVariable Integer idx, Model model) {
        List<PackagesThumbnailDTO> packagesThumbnailDTOList = packagesService.getThumbnailList(idx);
        log.info(packagesThumbnailDTOList.toString());
        PackagesDTO packagesDTO = packagesService.getPackagesByIdx(idx);
        String[] keywordList = packagesDTO.getKeyword().split(",");

        model.addAttribute("packagesList", packagesThumbnailDTOList);
        model.addAttribute("packagesInfo", packagesDTO);
        model.addAttribute("keywordList", keywordList);
        return "packages/detailPackages";
    }

    @GetMapping(value = "/update/{idx}")
    public String updatePackagesForm(@PathVariable Integer idx, Model model){
        PackagesDTO packagesDTO = packagesService.getPackagesByIdx(idx);
        String[] keywordList = packagesDTO.getKeyword().split(",");

        model.addAttribute("packagesInfo",packagesDTO);
        model.addAttribute("keywordList", keywordList);

        return "packages/update";
    }


    @GetMapping(value = "/update/get-info/{packagesIdx}")
    public ResponseEntity<?> getPackagesInformationForUpdate(@PathVariable String packagesIdx) {
        Integer packagesIdxInt = null;
        Map<String, Object> errorMap = new HashMap<>();

        try {
            packagesIdxInt = Integer.parseInt(packagesIdx);
        } catch (Exception e) {
            log.error("숫자가 아닌 값이 입력되었습니다");
            errorMap.put("errorMessage", "숫자가 아닌 값이 입력되었습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        List<PackagesThumbnailDTO> packagesThumbnailDTOList = packagesService.getThumbnailList(packagesIdxInt);
        log.info("packagesThumbnailDTO = {}", packagesThumbnailDTOList);

        if (packagesThumbnailDTOList == null) {
            errorMap.put("errorMessage", "해당 idx로 저장된 썸네일을 찾을 수 없습니다");
            return ResponseEntity
                    .badRequest()
                    .body(errorMap);
        }

        return ResponseEntity
                .ok(packagesThumbnailDTOList);
    }


    @PostMapping(value = "/update")
    public ResponseEntity<?> packagesUpdate(@Validated @RequestBody PackagesSaveDTO requestDTO) {
        log.info("requestDTO = {}", requestDTO);

        packagesService.updatePackages(requestDTO);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("message", "꾸러미가 업데이트 되었습니다");

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(resultMap);
    }

    @GetMapping(value = "/listPackages")
    public String gifList(Model model) {


        model.addAttribute("packagesDataList", packagesService.selectPackagesThumbnailList());
        return "packages/listPackages";
    }

    @GetMapping(value = "/viewListPackages")
    public String packagesViewList(Model model) {
        model.addAttribute("thumbnailList", packagesService.selectPackagesThumbnailList());

        return "packages/viewListPackages";
    }

    @GetMapping(value = "/category")
    public @ResponseBody String loadCategory(@RequestParam("category") Integer category){
        String categoryList = packagesService.getCategoryList(category);
        return categoryList;
    }

}

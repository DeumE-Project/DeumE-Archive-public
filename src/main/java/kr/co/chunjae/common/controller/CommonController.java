package kr.co.chunjae.common.controller;


import kr.co.chunjae.contents.service.ContentsService;
import kr.co.chunjae.gif.service.GifService;
import kr.co.chunjae.packages.service.PackagesService;
import kr.co.chunjae.template.dto.TemplateThumbnailDTO;
import kr.co.chunjae.template.service.TemplateService;
import kr.co.chunjae.video.service.VideoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping(value = "/")
@RequiredArgsConstructor
public class CommonController {

  private final GifService gifService;
  private final PackagesService packagesService;
  private final ContentsService contentsService;
  private final TemplateService templateService;
  private final VideoService videoService;

  @GetMapping
    public String mainPage(Model model){
    /*남원우*/
    model.addAttribute("gifThumbnailList", gifService.selectGifThumbnailForListInMain());



    /*변재혁*/
    model.addAttribute("contentsThumbnailList", contentsService.selectContentsThumbnailForListInMain());


    /*유지호*/
    model.addAttribute("packagesThumbnailList", packagesService.selectPackagesThumbnailListInMain());



    /*이무현*/
    List<TemplateThumbnailDTO> thumbnailDTOList = templateService.getThumbnailForTemplateListInMain();
    model.addAttribute("templateThumbnailList", thumbnailDTOList);


    /*최경락*/
    model.addAttribute("videoThumbnailList", videoService.selectVideoListThumbnailInMain());

    return "common/mainPage";
  }


}


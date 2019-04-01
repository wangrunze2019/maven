package com.java.controller.admin;

import com.github.pagehelper.PageInfo;
import com.java.pojo.EbookEntry;
import com.java.service.EbookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：13:50
 */
@Controller
@RequestMapping("/book")
public class EbookController {

    @Autowired
    private EbookService ebookService;

    /**
     * 分页查询图书信息
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping("/toEbookList")
    public String toEbookList(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "3") Integer pageSize,
                              Model model){
        List<EbookEntry> bookList = ebookService.findEBooks(pageNum, pageSize);
        PageInfo<EbookEntry> pageInfo = new PageInfo<>(bookList);
        model.addAttribute("pageInfo",pageInfo);
        return "admin/ebookList.jsp";
    }

    /**
     * 查询所有的分类信息
     * @return
     */
    @RequestMapping("/getCatogories")
    public @ResponseBody List<Map<String,Object>> getCatogories(){
        return ebookService.findCatogories();
    }

    /**
     * 根据分类来查询图书列表信息
     * @param catgoryId
     * @return
     */
    @RequestMapping("/getEbooksByCatogory")
    public @ResponseBody List<EbookEntry> getEbooksByCatogory(Long catgoryId){
        //数据校验
        return ebookService.findEbooksByCatogory(catgoryId);
    }

    /**
     * 添加电子书
     * @param ebookEntry
     * @return
     */
    @RequestMapping("/addEbook")
    public @ResponseBody boolean addEbook(@RequestBody EbookEntry ebookEntry){
        //数据校验-ebookEntry的数据完全正确的时候才调用业务层，往数据库中存数据
        return ebookService.saveEbookEntry(ebookEntry);
    }

    /**
     *从ebookList.jsp--->updateEbook.jsp时查询某个图书的详细信息，并且将数据存放到session域中去
     * @param bookId
     * @return
     */
    @RequestMapping("/toUpdateEbook")
    public @ResponseBody boolean toUpdateEbook(Long bookId, HttpSession session){
        try {
            EbookEntry ebook = ebookService.findEbookById(bookId);
            session.setAttribute("ebook",ebook);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @RequestMapping("/delEbookById.do")
    public @ResponseBody boolean delEbookById(Long bookId){
        return ebookService.removeEbookById(bookId);
    }

}

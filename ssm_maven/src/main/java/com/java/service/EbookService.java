package com.java.service;

import com.java.pojo.EbookEntry;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：13:49
 */
public interface EbookService {
    List<EbookEntry> findEBooks(Integer pageNum, Integer pageSize);

    /**
     * 查询所有分类信息
     * @return
     */
    List<Map<String,Object>> findCatogories();

    /**
     * 根据分类来查询图书列表信息
     * @param catgoryId
     * @return
     */
    List<EbookEntry> findEbooksByCatogory(Long catgoryId);

    /**
     * 插入电子书数据
     * @param record
     * @return
     */
    boolean saveEbookEntry(EbookEntry record);

    /**
     * 根据电子书id查询出电子书的详细信息
     * @param bookId
     * @return
     */
    EbookEntry findEbookById(Long bookId);

    /**
     * 根据id删除图书信息
     * @param bookId
     * @return
     */
    boolean removeEbookById(Long bookId);
}

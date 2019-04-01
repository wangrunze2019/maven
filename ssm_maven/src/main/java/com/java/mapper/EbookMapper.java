package com.java.mapper;

import com.java.pojo.EbookEntry;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：14:50
 */
public interface EbookMapper {

    /**
     * 查询所有电子书-分页
     * @return
     */
    @Select("SELECT * FROM ebook_entry ORDER BY id DESC")
    List<EbookEntry> selectEBooks();

    /**
     * 查询所有分类信息
     * @return
     */
    @Select("SELECT * FROM ebook_catogory")
    List<Map<String,Object>> selectCatogories();

    /**
     * 根据分类来查询图书列表信息
     * @param catgoryId
     * @return
     */
    List<EbookEntry> selectEbooksByCatogory(Long catgoryId);

    /**
     * 插入电子书
     * @param record
     * @return
     */
    int insertEbookEntry(EbookEntry record);

    /**
     * 根据电子书id查询出电子书的详细信息
     * @param bookId
     * @return
     */
    @Select("SELECT * FROM ebook_entry WHERE id=#{arg0}")
    EbookEntry selectEbookById(Long bookId);

    /**
     * 根据id删除图书信息
     * @param bookId
     * @return
     */
    @Update("delete from ebook_entry where id=#{0}")
    int deleteEbookById(Long bookId);

}

package com.java.service.impl;

import com.github.pagehelper.PageHelper;
import com.java.mapper.EbookMapper;
import com.java.pojo.EbookEntry;
import com.java.service.EbookService;
import org.apache.ibatis.annotations.Select;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * description：
 * author：丁鹏
 * date：13:46
 */
@Service
public class EbookServiceImpl implements EbookService {
    @Autowired
    private EbookMapper ebookMapper;

    /**
     * 查询所有电子书-分页
     * @return
     */
    @Override
    public List<EbookEntry> findEBooks(Integer pageNum, Integer pageSize){
        //使用PageHelper分页
        PageHelper.startPage(pageNum,pageSize);
        return ebookMapper.selectEBooks();
    }

    @Override
    public List<Map<String, Object>> findCatogories() {
        return ebookMapper.selectCatogories();
    }

    @Override
    public List<EbookEntry> findEbooksByCatogory(Long catgoryId) {
        return ebookMapper.selectEbooksByCatogory(catgoryId);
    }

    @Override
    public boolean saveEbookEntry(EbookEntry record) {
        return ebookMapper.insertEbookEntry(record)>=1;
    }

    @Override
    public EbookEntry findEbookById(Long bookId) {
        return ebookMapper.selectEbookById(bookId);
    }

    @Override
    public boolean removeEbookById(Long bookId) {
        return ebookMapper.deleteEbookById(bookId)>=1;
    }
}

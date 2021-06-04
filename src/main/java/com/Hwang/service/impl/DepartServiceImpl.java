package com.Hwang.service.impl;

import com.Hwang.mapper.DepartMapper;
import com.Hwang.pojo.Depart;
import com.Hwang.service.DepartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class DepartServiceImpl implements DepartService {

    @Autowired
    private DepartMapper departMapper;


    @Override
    public List<Depart> getDept() {
        return departMapper.getDept();
    }
}

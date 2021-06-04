package com.Hwang.pojo;

import com.github.pagehelper.PageInfo;

import java.util.List;

public class EmpVo<T> {

    private PageInfo pageInfo;

    private Depart depart;

    private List<T> departs;

    public PageInfo getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageInfo pageInfo) {
        this.pageInfo = pageInfo;
    }

    public Depart getDepart() {
        return depart;
    }

    public void setDepart(Depart depart) {
        this.depart = depart;
    }

    public List<T> getDeparts() {
        return departs;
    }

    public void setDeparts(List<T> departs) {
        this.departs = departs;
    }
}

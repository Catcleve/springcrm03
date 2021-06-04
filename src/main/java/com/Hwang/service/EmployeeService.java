package com.Hwang.service;

import com.Hwang.pojo.Employee;

import java.util.List;

public interface EmployeeService {

    //    模糊查询
    List<Employee> findEmployee(Integer pageNum);

    //    通过id修改员工信息
    void updateEmployeeById(Employee employee);

    //    增加员工
    void add(Employee employee);

    //    批量删除员工
    void deleteAll(List<Integer> list);

    //    通过id删除员工
    void delete(Employee employee);
}

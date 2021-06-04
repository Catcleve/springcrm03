package com.Hwang.service.impl;

import com.Hwang.mapper.EmployeeMapper;
import com.Hwang.pojo.Employee;
import com.Hwang.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

//    分页查询
    @Override
    public List<Employee> findEmployee(Integer pageNum) {


        return employeeMapper.findEmployee();
    }

//    通过id获取信息
    @Override
    public void updateEmployeeById(Employee employee) {

        employeeMapper.updateEmployeeById(employee);

    }

//     增加员工
    @Override
    public void add(Employee employee) {

    }

//    批量删除
    @Override
    public void deleteAll(List<Integer> list) {

        employeeMapper.deleteAll(list);

    }

//    通过id删除
    @Override
    public void delete(Employee employee) {

    }
}

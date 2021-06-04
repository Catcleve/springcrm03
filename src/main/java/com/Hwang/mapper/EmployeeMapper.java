package com.Hwang.mapper;

import com.Hwang.pojo.Employee;

import java.util.List;

public interface EmployeeMapper {

//    模糊查询
    List<Employee> findEmployee();

//    通过id查询员工
    Employee findEmployeeById(Employee employee);

//    通过id修改员工信息
    void updateEmployeeById(Employee employee);

    //    增加员工
    void add(Employee employee);

//    批量删除员工
    void deleteAll(List<Integer> list);

//    通过id删除员工
    void delete(Employee employee);
}

package com.Hwang.controller;


import com.Hwang.pojo.Depart;
import com.Hwang.pojo.Employee;
import com.Hwang.service.DepartService;
import com.Hwang.service.EmployeeService;
import com.Hwang.pojo.EmpVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Arrays;
import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private DepartService departService;


//  根据id查找到员工
    @RequestMapping ("update")
    @ResponseBody
    public Employee update(Employee employee){

        return employeeService.findEmpById(employee);
    }

//    修改员工
    @RequestMapping("edit")
    @ResponseBody
    private String edit(Employee employee){
        System.out.println("employee修改 = " + employee);
        return "haha";
    }




//    配合ajax主方法
    @RequestMapping("findAll")
    @ResponseBody
    public EmpVo<Depart> findAll (@RequestParam(defaultValue = "1") Integer page){

        System.out.println("page = " + page);
        PageHelper.startPage(page,5);
        List<Employee> list = employeeService.findEmployee(page);
        PageInfo<Employee> pageInfo = new PageInfo<>(list,5);
        List<Depart> dept = departService.getDept();
        EmpVo<Depart> empVo = new EmpVo<>();
        empVo.setDeparts(dept);
        empVo.setPageInfo(pageInfo);
        return empVo;
    }


//    获取部门集合
    @RequestMapping("getDeparts")
    @ResponseBody
    public EmpVo<Depart> getDeparts(){
        List<Depart> dept = departService.getDept();
        EmpVo<Depart> empVo = new EmpVo<>();
        empVo.setDeparts(dept);
        return empVo;
    }



//    批量删除
    @RequestMapping("deleteAll")
    private ModelAndView deleteAll( Integer[] ids) {

        ModelAndView mad = new ModelAndView();

        if (ids.length > 0) {

            List<Integer> list = Arrays.asList(ids);

            employeeService.deleteAll(list);
        }
        mad.setViewName("redirect:findAll.do");

        return mad;
    }


//    添加员工
    @RequestMapping("add")
    @ResponseBody
    public String addEmp (Employee employee){
        System.out.println("employee添加 = " + employee);
        return "添加成功";
    }
}

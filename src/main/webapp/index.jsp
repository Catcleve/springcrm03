<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <script src="<%=basePath%>js/jquery.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap.min.js" ></script>

</head>
<body>

<%--添加和编辑模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">修改页面</h4>
                </div>
                <div class="modal-body" >
                    <form class="form-horizontal" role="form" id="addForm" action="<%=basePath%>add.do">
                        <%--          id框 添加的时候隐藏，编辑的时候显现--%>
                        <div class="form-group" id="edit_id_show" style="display: none">
                            <label  class="col-lg-2 control-label">ID</label>
                            <div class="col-lg-9">
                                <p class="form-control-static" ></p>
                                <input type="hidden" name="id" id="emp_id" >
                            </div>
                            <div class="col-lg-1"></div>
                        </div>

                        <%--          名字组--%>
                        <div class="form-group">
                            <label for="lastname" class="col-lg-2 control-label">名字</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="lastName" id="lastname" placeholder="请输入名字">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>

                        <%--    邮箱组--%>
                        <div class="form-group">
                            <label for="email" class="col-lg-2 control-label">邮箱</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" name="email" id="email" placeholder="请输入邮箱">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>

    <%--                        性别组--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10 ">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" value="男" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" value="女"> 女
                                </label>
                            </div>
                            <div class="col-sm-1"></div>
                        </div>

    <%--                        部门组--%>
                        <div class="form-group">
                            <label for="dept_name" class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-9">
                                <select class="form-control" id="dept_name" name="deptName">
                                </select>
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary" id="add_sub">提交更改</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <%--    主表格--%>
    <form id="form">
        <div class="container glyphicon-sort-by-attributes ">
            <h1 id="">SSM-CRUD</h1>
            <table class="table table-striped table-bordered table-hover " style="font-size: 22px">
                <thead>
                    <tr>
                        <td colspan="7">
                            <div class="row">
                                <div class="col-xs-10"></div>
                                <div class="col-xs-2">
                                    <input type="submit" value="删除" class="btn btn-danger">
                                    <button class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="add_btn">添加</button>
                                </div>
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <th><input type="checkbox" name="ids_all" id="ids_all"></th>
                        <th>#</th>
                        <th>lastName</th>
                        <th>email</th>
                        <th>gender</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                </thead>

                <tbody id="emp_table">

                </tbody>
            </table>

            <div class="row">
                <div class="col-md-7" id="page_info"></div>
                <div class="col-md-5" >
                    <nav aria-label="Page navigation">
                        <ul class="pagination" id="page_nav">
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">

<%--        定义全局变量，给编辑和添加使用--%>
<%--     page_num当前页   page_size总页数  dept_name部门名称集合  url_emp提交和 --%>
        var page_num, page_size,dept_name,url_emp
        $(function (){

            goPage(1)

        })

        function goPage(pn) {
            //goPage方法会回显下拉框，所以要先清空一次，要不然会出现很多个下拉框
            $("#dept_name").empty()
            $.ajax({
                url:"<%=basePath%>findAll.do",
                type:"get",
                data:"page="+pn,
                success:function (empVo) {

                    //这里因为要解析不同的数据，所以最好要分不同的方法来解决
                    //解析员工集合
                    build_ems_tables(empVo);
                    // 解析分页信息
                    build_page_info(empVo);
                    //解析分页导航信息
                    build_page_nav(empVo);
                    //解析部门信息
                    build_dept_name(empVo);
                }
            })
        }
        //解析员工集合
        function build_ems_tables(empVo){
            const emps = empVo.pageInfo.list;
            console.log(emps)
            $("#emp_table").empty();
            $.each(emps,function (index,emp) {
                //    创建td对象
                    let $tr = $("<tr></tr>");
                    $("<td></td>").append($("<input type='checkbox' name='ids'/>").val(emp.id)).appendTo($tr)
                    $("<td></td>").append(emp.id).appendTo($tr)
                    $("<td></td>").append(emp.lastName).appendTo($tr)
                    $("<td></td>").append(emp.email).appendTo($tr)
                    $("<td></td>").append(emp.gender).appendTo($tr)
                    $("<td></td>").append(emp.deptName).appendTo($tr)

                    //编辑按钮
                    const editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

                    //为编辑按钮添加一个定义的属性，来表示当前员工的id
                    editBtn.attr("edit-id",emp.id);

                    //删除按钮
                    const delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

                    //为删除按钮添加一个定义的属性，来表示当前员工的id
                    delBtn.attr("del-id",emp.id);
                    $("<td></td>").append(editBtn).append(" ").append(delBtn).appendTo($tr)
                    $tr.appendTo($("tbody"))
            })
        }

        // 解析分页信息
        function build_page_info(empVo){
            let pageInfo = empVo.pageInfo;
            $('#page_info').empty().append("当前第"+ pageInfo.pageNum+
                "页，总共"+pageInfo.pages+"页，一共"+pageInfo.total+"条记录")

            page_num = pageInfo.pageNum
            page_size = pageInfo.pages

        }

        //解析分页导航信息
        function build_page_nav(empVo) {
            const $page_nav = $("#page_nav");
            $page_nav.empty()
            let pageInfo = empVo.pageInfo;
            const firstPage = $("<li></li>").append($("<a></a>").attr("href", "#").append("首页"));
            const prePage = $("<li></li>").append($("<a></a>").attr("href", "#").append($("<span></span>").attr("aria-hidden", "true").append("&laquo;")));
            if (pageInfo.isFirstPage) {
                //如果是第一页，就禁用按钮
                firstPage.addClass("disabled")
                prePage.addClass("disabled")
            }else {
                //如果不是，就给按钮添加点击时间
                firstPage.click(function () {
                    goPage(1)
                })
                prePage.click(function () {
                    goPage(pageInfo.prePage)
                })
            }
            $page_nav.append(firstPage).append(prePage)

            //遍历添加中间的按钮
            $.each(pageInfo.navigatepageNums,function (index,item) {
                var numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item))
                if(item === pageInfo.pageNum){
                    //给当前页 页码添加高亮
                    numLi.addClass("active")
                }
                numLi.click(function () {
                    goPage(item)
                })
                $page_nav.append(numLi)
            })

            var lastPage = $("<li></li>").append($("<a></a>").attr("href","#").append("末页"))
            var nextPage = $("<li></li>").append($("<a></a>").attr("href","#").append($("<span></span>").attr("aria-hidden","true").append("&raquo;")))
            if (pageInfo.isLastPage) {
                //如果是最后一页，就禁用按钮
                lastPage.addClass("disabled")
                nextPage.addClass("disabled")
            }else {
                //如果不是，就给按钮添加点击事件
                lastPage.click(function () {
                    goPage(pageInfo.pages)
                })
                nextPage.click(function () {
                    goPage(pageInfo.nextPage)
                })
            }
            $page_nav.append(nextPage).append(lastPage)
        }


        //给部门下拉框赋值的方法
        function build_dept_name(empVo){
            let $dept_name = $('#dept_name')

            //const {departs} = empVo;这一行作用等同于下面一行代码，是json对象的用法
            let departs = empVo.departs;
            console.log(empVo)
            $.each(departs,function (index,item) {
                $("<option></option>").val(item.departmentId)
                    .html(item.departmentName).appendTo($dept_name)
            })
        }


        //点击添加按钮，清空模态框内容，
        $('#add_btn').click(function (){
            // 清空内容
            restart()
            //  因为是添加，所以把ajax请求地址改为添加
            url_emp = "<%=basePath%>add.do"
            //隐藏id框，清空id值
            $('#edit_id_show').attr("style","display: none").val()
        })

        //点击模态框提交按钮，获取模态框内容，启动添加方法
        $('#add_sub').click(function () {
            add()
        })

        //提交表单的方法，添加和编辑公用
        function add() {
            $.ajax({
                type:'post',
                url:url_emp,
                data: $('#addForm').serialize(),
                success:function (data) {
                    $("#dept_name").empty()
                    goPage(page_size)
                    $('#myModal').modal('hide')
                    alert(data)
                }
            })
        }


        //编辑的模态框回显
        $(document).on("click","[edit-id]",function () {
            var $edit_id = $(this).attr("edit-id")
            url_emp = "<%=basePath%>edit.do"
        //    显示id框
            $('#edit_id_show').attr("style","")
            //更改表单提交地址
            $("addForm").attr("action","<%=basePath%>edit.do")
            $('#myModal').modal('show')
        //    先获得员工信息
            $.ajax({
                url:"<%=basePath%>update.do",
                type:"post",
                data:{
                    id:$edit_id
                },
                //    请求获取员工信息 然后回显信息
                success:function (emp){
                    //把数据放进模态框中
                    $("#edit_id_show p").text(emp.id);
                    $("#emp_id").val(emp.id)
                    $("#lastname").val(emp.lastName);
                    $("#email").val(emp.email);
                    //获取性别的单选框，遍历，选中员工性别
                    $.each($("input[name = 'gender']"),function (index,item) {
                        console.log($(item).val())
                        console.log(emp.gender)
                        if ($(item).val() === emp.gender) {
                            //这里要用prop
                            $(item).prop("checked",true)
                        }else {
                            $(item).removeAttr("checked","checked")
                        }
                    })
                    //获取部门下拉框，遍历选中员工部门
                    $.each($("option"),function (index,item) {
                        if ($(item).val() === emp.deptName) {
                            $(item).prop("selected",true)
                        }
                    })
                }
            })
        })

        
        //清空模态框方法
        function restart() {
            //清空除了性别框的内容
            $("#addForm input:not([name = 'gender'])").val("")
            //取消性别框选中
            $("#addForm input[name = 'gender']").prop("checked",false)
            //取消部门选中
            $("#addForm option").prop("selected",false)
            //清空id显示的值
            $("#addForm p").text(null)
        }


        //全选的实现，当点击全选时
        $("#ids_all").click(function () {
            //选择器选中所有的多选框，设置属性checked为 上面全选框全选的checked属性
            $("input[name = 'ids']").prop("checked",$(this).prop("checked"))
        })


        /*点击删除按钮的时候要判断是否有选中的，如果没有选中的则不提交
        如果有选中的，则显示二次确认，同时显示姓名，确认删除执行ajax请求*/


        //删除按钮点击的时候判断是否有按钮选中，如果一个都没有，则无法点击
        $('#form').submit(function (){
            var tt = true
            $.each($("input[name = 'ids']"),function (i,idss){
                if ($(idss).is(':checked')) {
                    tt = false
                }
            })
            return tt;
        })
    </script>
</body>
</html>

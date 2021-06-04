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

    <%--模态框--%>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

        <div class="modal-dialog" >
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="myModalLabel">修改页面</h4>
                </div>
                <div class="modal-body" >
                    <form class="form-horizontal" role="form" action="">
                        <div class="form-group">
                            <%--   <div class="col-xs-1"></div>--%>
                            <label for="firstname" class="col-lg-2 control-label">名字</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" id="firstname" placeholder="请输入名字">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-lg-2 control-label">邮箱</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" id="email" placeholder="请输入名字">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
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
                        <div class="form-group">
                            <label for="deptName" class="col-lg-2 control-label">部门</label>
                            <div class="col-lg-9">
                                <input type="text" class="form-control" id="deptName" placeholder="请输入名字">
                            </div>
                            <div class="col-lg-1"></div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">提交更改</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

<%--    主表格--%>
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
                                <button class="btn btn-primary" data-toggle="modal" data-target="#myModal">添加</button>
                            </div>
                        </div>
                    </td>
                </tr>

                <tr>
                    <th><input type="checkbox"></th>
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
    </div>



    <script type="text/javascript">

        // $(function (){
        //
        //     goPage(1)
        //
        // })

        function goPage(pn) {
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
                }
            })
        }

        function build_ems_tables(empVo){
            const emps = empVo.pageInfo.list;
            $("#emp_table").empty();
            $.each(emps,function (index,emp) {
            //    创建td对象
            //     let $tr = $("<tr><tr>");
            //     $("<td></td>").append($("<input type='checkbox' name='ids' />").val(emp.id)).appendTo($tr)
            //     $("<td></td>").append(emp.id).appendTo($tr)
            //     $("<td></td>").append(emp.lastName).appendTo($tr)
            //     $("<td></td>").append(emp.email).appendTo($tr)
            //     $("<td></td>").append(emp.gender).appendTo($tr)
            //     $("<td></td>").append(emp.deptName).appendTo($tr)
            //     $("<td></td>").append("emp.lastName").appendTo($tr)
            //     $tr.appendTo($("tbody"))

                var emp_checkbox = $("<td></td>").append($("<input type='checkbox' name='ids' />").val(emp.id))
                var emp_id = $("<td></td>").append(emp.id)
                var emp_name = $("<td></td>").append(emp.lastName)
                var emp_email = $("<td></td>").append(emp.email)
                var emp_gender = $("<td></td>").append(emp.gender)
                var emp_dept = $("<td></td>").append(emp.deptName)
                var emp_caozuo = $("<td></td>").append("emp.lastName")

                $("<tr><tr>").append(emp_checkbox)
                .append(emp_id)
                .append(emp_name)
                .append(emp_email)
                .append(emp_gender)
                .append(emp_dept)
                .append(emp_caozuo).appendTo($("#emp_table"))
            })
        }



        $('#form').submit(function (){
            var tt = false
            $.each($("input[name = 'ids']"),function (i,idss){
                if ($(idss).is(':checked')) {
                    tt = true
                }
            })
            return tt;
        })

    </script>
</body>
</html>

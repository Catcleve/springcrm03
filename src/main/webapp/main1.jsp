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
    <style>
        td,th{
            text-align: center;
        }
    </style>







</head>
<body>


<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">修改页面</h4>
            </div>
            <div class="modal-body" >
                <form class="form-horizontal" role="form" action="${pageContext.request.contextPath}/findAll.do">
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



<div class="container glyphicon-sort-by-attributes ">
    <h1 id="">SSM-CRUD</h1>
    <form action="${pageContext.request.contextPath}/deleteAll.do" id="form">
<table class="table table-striped table-bordered table-hover " style="font-size: 22px">
    <thead>
        <tr>
            <td colspan="7">
                <div class="row">
                    <div class="col-xs-10"></div>
                    <div class="col-xs-2">
                        <input type="submit" value="删除" class="btn btn-danger">
                        <button class="btn btn-primary" data-toggle="modal" data-target="#myModal">添加</button>

<%--                        <input type="submit" value="添加" class="btn btn-primary">--%>
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
    <tbody>
        <c:forEach var = "employee" items = "${pageInfo.list}" varStatus="vars">
            <tr>
                <td><input type="checkbox" name="ids" value="${employee.id}"></td>
                <td>${employee.id}</td>
                <td>${employee.lastName}</td>
                <td>${employee.email}</td>
                <td>${employee.gender}</td>
                <td>${employee.deptName}</td>
                <td>
                    <a class="btn btn-danger" href="${pageContext.request.contextPath}/edit.action?id=${employee.id}">修改</a>
                    <a class="btn btn-warning" href="${pageContext.request.contextPath}/delete.action?id=${employee.id}">删除</a>
                </td>
            </tr>
     </c:forEach>
  </tbody>
</table>
    </form>

        <div class="row">
            <div class="col-xs-6"></div>
                <div class="col-xs-6 col-sm-push-1" >
                    <ul class="pagination">
                        <li >
                            <a href="javascript:goPage(1)" aria-label="Previous">首页</a>
                        </li>

                        <li >
                            <a href="javascript:goPage(${pageInfo.prePage})">上一页</a></li>
<%--                        <c:if test="${pageInfo.hasPreviousPage}">--%>
<%--                        </c:if>--%>
                        <c:forEach begin="${pageInfo.navigateFirstPage}" end="${pageInfo.navigateLastPage}" var="i">
                            <li class="paginate_button ${pageInfo.pageNum==i ? 'active':''}">
                                <a href="javascript:goPage(${i})">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                        </c:if>
                        <li class=" ${pageInfo.hasNextPage ? '':'disabled'}"><a href="javascript:goPage(${pageInfo.nextPage})" class="disabled">下一页</a></li>

                        <li>
                            <a href="javascript:goPage(${pageInfo.pages})" aria-label="Next">尾页</a>
                        </li>
                    </ul>
                </div>
            </div>

</div>

<form id="pageForm" action="${pageContext.request.contextPath}/findAll.do" method="post">
    <input type="hidden" name="page" id="pageNum">
    <input type="hidden" name="PageSize" id="pageSize" value="${pageInfo.pageSize}">
</form>
    <script>
        $('#form').submit(function (){
            var tt = false
            $.each($("input[name = 'ids']"),function (i,idss){
                if ($(idss).is(':checked')) {
                    tt = true
                }
            })
            return tt;
        })

        // function showSelection(selection){
        //     document.getElementById("pageSize").value=selection;
        //     goPage(1);
        // }
        function goPage(page) {
            document.getElementById("pageNum").value = page
            // var select=document.getElementById("selectSize")
            // var selectValue=select.options[select.options.selectedIndex].value
            // document.getElementById("pageSize").value = selectValue
            document.getElementById("pageForm").submit()
        }
    </script>
</body>
</html>

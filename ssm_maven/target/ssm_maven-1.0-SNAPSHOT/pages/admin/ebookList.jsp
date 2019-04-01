<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() +request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>帖子列表</title>
    <style type="text/css">
        tbody>tr:nth-child(odd){
            background: #CCF6CE;
        }
    </style>
    <!-- 引入bootstrap分页 -->
    <link rel="stylesheet" href="<%=basePath%>/static/js/bootstrap/bootstrap.css" />
    <script src="<%=basePath%>/static/js/bootstrap/jquery.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap.min.js"></script>
    <script src="<%=basePath%>/static/js/bootstrap/bootstrap-paginator.js"></script>
    <script>
        $(function() {
            $('#pagination').bootstrapPaginator({
                bootstrapMajorVersion: 3,
                currentPage: ${requestScope.pageInfo.pageNum },
                totalPages: ${requestScope.pageInfo.pages },
                pageUrl: function(type, page, current) {
                    return 'book/toEbookList.do?pageNum=' + page;
                },
                itemTexts: function(type, page, current) {
                    switch(type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                }
            });
        });
    </script>
</head>
<body>
<center>
    <h3>贴子列表</h3>
    <span style="position: relative;left:-200px">
        帖子分类：
        <select name="catgory">
            <option value="0">全部</option>
        </select>
        <button id="search">查询</button>
    </span>
    <span style="position: relative;right:-200px">
        <button id="addBook">新增帖子</button>
    </span>
    <table width="900px" border="1px" cellspacing="0px">
        <thead>
            <tr>
                <th>帖子编号</th>
                <th>帖子名称</th>
                <th>帖子摘要</th>
                <th>上传人</th>
                <th>上传时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pageInfo.list}" var="book">
                <tr>
                    <td>${book.id}</td>
                    <td>${book.title}</td>
                    <td>${book.summary}</td>
                    <td>${book.uploaduser}</td>
                    <td><fmt:formatDate value="${book.createdate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                    <td>
                        <a href="javascript:void(0)" class="update" bookId="${book.id}">修改</a>
                        &nbsp;&nbsp;
                        <a href="javascript:void(0)" class="del" bookId="${book.id}">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- 把分页搞出来 -->
    <ul id="pagination"></ul>
</center>



    <script type="text/javascript">
        $(function(){
            //页面加载完毕后自动执行ajax操作，获取所有图书分类信息
            $.ajax({
                url:"<%=basePath %>/book/getCatogories.do",
                type:"POST",
                dataType:"JSON",
                success:function(rs){
                    var content = "";
                    for(var i in rs){
                        var id = rs[i].id;//分类主键
                        var name= rs[i].name;//分类名
                        content+="<option value='"+id+"'>"+name+"</option>"
                    }
                    $("select[name=catgory]").append(content);
                }
            });


            /*分类按钮触发ajax*/
            $("#search").click(function(){
                $.ajax({
                    url:"<%=basePath %>/book/getEbooksByCatogory.do",
                    type:"POST",
                    dataType:"JSON",
                    data:{
                      "catgoryId": $("select[name=catgory]>option:selected").val()
                    },
                    success:function(rs){
                        var content = "";
                        for(var i in rs){
                            var id = rs[i].id;
                            var title = rs[i].title;
                            var summary = rs[i].summary;
                            var uploaduser = rs[i].uploaduser;
                            var createdate = rs[i].createdate;
                            content+="<tr><td>"+id+"</td><td>"+title+"</td><td>"+summary+"</td><td>"+uploaduser+"</td><td>"+createdate+"</td><td><a href='#'>修改</a>&nbsp;&nbsp;<a href='#'>删除</a></td></tr>";
                        }
                        $("tbody").html(content);
                    }
                });
            });

            /*新增电子图书--->弹出addEbook.jsp页面*/
            $("#addBook").click(function(){
                var catgoryId = $("select[name=catgory]>option:selected").val()
                window.open("<%=basePath%>/pages/admin/addEbook.jsp?catgoryId="+catgoryId,"","width=800,height=400,left=350,top=200,resizable:no");
            });

            /*修改电子图书*/
            $(".update").click(function(){
                var bookId = $(event.target).attr("bookId");
                //触发ajax
                $.ajax({
                    url:"<%=basePath %>/book/toUpdateEbook.do",
                    type:"POST",
                    dataType:"JSON",
                    data:{
                        "bookId":bookId
                    },
                    success:function(rs){
                        if(rs){
                            window.open("<%=basePath%>/pages/admin/updateEbook.jsp","","width=800,height=400,left=350,top=200,resizable:no");
                        }else{
                            window.alert("系统跳转失败(修改)");
                        }
                    }
                });
            });

            /*删除按钮*/
            $(".del").click(function(){
                var flag = window.confirm("您确认删除此记录吗？");
                if(flag){
                    var bookId = $(event.target).attr("bookId");
                    //触发ajax
                    $.ajax({
                        url:"<%=basePath %>/book/delEbookById.do",
                        type:"POST",
                        dataType:"JSON",
                        data:{
                            "bookId":bookId
                        },
                        success:function(rs){
                            if(rs){//删除成功
                                //刷新：自行解决
                                window.location.reload();
                                $("tbody").append("<tr><td colspan='6' align='center'><span style='font-size: 12px;color: red'>删除成功</span></td></tr>");
                            }else{
                                window.alert("操作有误，删除失败，请重试");
                            }
                        }
                    });
                }
            });
        });
    </script>


</body>
</html>

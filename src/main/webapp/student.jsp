<%--
  Created by IntelliJ IDEA.
  User: Reset
  Date: 2018/1/22
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- Bootstrap -->
    <link href="plugs/bootstrap.min.css" rel="stylesheet">
    <link href="plugs/button.css" rel="stylesheet">
    <link rel="stylesheet" href="plugs/page.css"/>
</head>
<body>
<button class="btn btn-info glyphicon glyphicon-plus"
        style="margin-left:50px"
        onclick="insert()">增加
</button>
<script type="text/javascript">
    function insert() {
        student_info_insert._data.student_data = {}
        $("#student_info_insert").modal("show");
    }
</script>

<div class="form-inline input-group"
     style="margin-top: 50px positon:relative; width:350px;margin-left:850px">
    <input type="text" id="student_on" class="form-control"
           placeholder="请输入搜索的内容"/> <span class="input-group-btn">
			<button class="btn btn-info btn-search" onclick="secher()">查找</button>
		</span>
</div>

<table class="table table-bordered table-striped table-hover"
       id="student_table">
    <thead class="title table-bordered">
    <th>编号</th>
    <th>姓名</th>
    <th>密码</th>
    <th>操作</th>
    </thead>
    <tr v-for="obj in student.list">
        <td>{{obj.sid}}</td>
        <td>{{obj.sname}}</td>
        <td>{{obj.pwd}}</td>

        <td>
            <button class="btn btn-warning glyphicon glyphicon-pencil"
                    v-on:click="updObj(obj.sid)">修改
            </button>
            <button class="btn btn-danger glyphicon glyphicon-trash"
                    v-on:click="delObj(obj.sid)">删除
            </button>
        </td>
    </tr>
    <tr>
        <td colspan="7" style="text-align: center;">
            <div class="_page">
                <div class="go" v-on:click="go_('back')">上一页</div>
                <div class="ps">
                    <span class="pi" v-on:click="go_(1)" v-if="student.page>2">1</span>
                    {{student.page>2?'...':''}}
                    <span class="pi" :class="{selected:i==student.page}" v-on:click="go_(i)" v-for="i in student.max"
                          v-if="i>=student.page&&i<student.page+4">{{i}}</span>
                    {{student.page<(student.max-3)?'...':''}}
                    <span class="pi" v-on:click="go_(student.max)"
                          v-if="student.page<(student.max-3)">{{student.max}}</span>
                </div>
                <div class="go" v-on:click="go_('next')">下一页</div>
            </div>
        </td>
    </tr>
</table>

<div class="modal fade" tabindex="-1" role="dialog" id="student_object"
     data-backdrop="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">学生信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-info">
                    <!--primary 蓝色    success 淡灰色  info 淡蓝色 warning 淡粉色  danger 淡紫色  -->
                    <div class="panel-heading">基本信息</div>
                    <div class="panel-body">
                        <table class="table">
                            <tr>
                                <td>
                                    <div class="update-info">
                                        姓名 : <input type="text" v-model="student_data.sname"
                                                    class="form-control"/>
                                    </div>
                                </td>
                                <td>
                                    <div class="update-info">
                                        密码: <input type="text" v-model="student_data.pwd"
                                                   class="form-control"/>
                                    </div>
                                </td>
                            </tr>

                        </table>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        v-on:click="updateStu">提交
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<div class="modal fade" tabindex="-1" role="dialog"
     id="student_info_insert" data-backdrop="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">学生信息</h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-info">
                    <!--primary 蓝色    success 淡灰色  info 淡蓝色 warning 淡粉色  danger 淡紫色  -->
                    <div class="panel-heading">基本信息</div>
                    <div class="panel-body">
                        <table class="table">
                            <tr>
                                <td>
                                    <div class="update-info">
                                        姓名 : <input type="text" v-model="student_data.sname"
                                                    class="form-control" placeholder="请输入学生姓名"/>
                                    </div>
                                </td>

                                <td>
                                    <div class="update-info">
                                        密码: <input type="number" v-model="student_data.pwd"
                                                   class="form-control" placeholder="请输入密码"/>
                                    </div>
                                </td>

                            </tr>

                        </table>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" v-on:click="insertStu">增加</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


</body>
<script src="/plugs/jquery-3.2.1.min.js"></script>
<script src="/plugs/vue.min.js"></script>
<script src="/plugs/bootstrap.min.js"></script>
<script type="text/javascript">
    //表的操作
    var student_table = new Vue(
        {
            el: "#student_table",
            data: {
                student: {
                    list: [],
//                    max : 0,
//                    count : 5,
//                    page : 18
                }
            },
            methods: {
                query: function (_id) {
                    $.ajax({
                        url: "/student/queryById",
                        type: "post",
                        dataType: "JSON",
                        data: {
                            id: _id
                        },
                        success: function (data) {
                            student_object_info._data.student_data = data;
                        }
                    });

                },
                //删除
                delObj: function (_id) {
                    $.ajax({
                        url: "/student/deleteStudent",
                        type: "post",
                        dataType: "JSON",
                        data: {
                            id: _id
                        },
                        success: function (data) {
                            queryList();
                        }
                    });
                },
                //修改数据绑定
                updObj: function (_id) {
                    $.ajax({
                        url: "/student/queryById",
                        type: "post",
                        dataType: "JSON",
                        data: {
                            id: _id
                        },
                        success: function (data) {
                            student_object_info._data.student_data = data;
                            var modal = $("#student_object");
                            modal.modal("show");
                        }
                    });
                },
                insert: function () {
                    $("#student_info_insert").modal("show");
                },
//                go_ : function(_page) {
//                    if (_page == "next") {
//                        this.student.page = this.student.page < this.student.max ? this.student.page + 1 : this.student.page;
//
//                    } else if (_page == "back") {
//                        this.student.page = this.student.page > 1 ? this.student.page - 1 : this.student.page;
//
//                    } else {
//                        this.student.page = _page;
//                    }
//                    queryList();
//                }

            }

        });

    //增加数据

    var student_info_insert = new Vue({
        el: "#student_info_insert",
        data: {
            student_data: {}
        },
        methods: {
            insertStu: function () {
                var _this = this;
                var stringJson = JSON.stringify(this.student_data);
                $.ajax({
                    url: "/student/addStudent",
                    type: "post",
                    data: {
                        obj: stringJson
                    },
                    success: function (data) {
                        $("#student_info_insert").modal("hide");
                        queryList();
                    }

                });
            }

        }
    });

    //修改数据
    var student_object_info = new Vue({
        el: "#student_object",
        data: {
            student_data: {}
        },
        methods: {
            updateStu: function () {
                var StringJson = JSON.stringify(this.student_data);//将数据序列化
                $.ajax({
                    url: "/student/updateStudent",
                    type: "post",
                    datatype: "JSON",
                    data: {
                        obj: StringJson
                    },
                    success: function (data) {
                        $("#student_object").modal("hide");
                        queryList();
                    }
                });
            }
        }
    });

    //多条件查询
    function queryList() {
        var queryInfo = [{
            key: "sid",
            value: $("#student_on").val(),
            like: true
        }];
        $.ajax({
            url: "/student/index",
            type: "post",
            data: {
//                page : student_table._data.student.page,
//                count : student_table._data.student.count,
                queryInfo: JSON.stringify(queryInfo)
            },
            success: function (data) {
                console.log(data)
//                var json = $.parseJSON(data);
                student_table._data.student.list = data.list;
//                student_table._data.student.max = json.max;
            }
        });
    }

    //搜索
    function secher() {
        var page;
        var count;
        queryList();
    }

    $(function () {
        queryList();
    })
</script>


</html>

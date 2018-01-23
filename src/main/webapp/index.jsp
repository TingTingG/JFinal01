<%--
Created by IntelliJ IDEA.
User: Administrator
Date: 2018/1/16
Time: 21:13
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" xmlns:v-on="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="plugs/bootstrap.min.css">
    <script src="plugs/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div id="member-table">
        <table class="table table-hover" style="text-align: center">
            <tr>
                <td>#</td>
                <td>Account1</td>
                <td>Password</td>
                <td>Operation</td>
            </tr>
            <tr>
                <td>
                    <button type="button" v-on:Click="insertMember" class="btn btn-primary btn-sm">增加
                    </button>
                </td>
                <td>
                </td>
                <td colspan="2">
                    <div class="input-group pull-right">
                        <input type="text" class="form-control" placeholder="Search for...">
                        <span class="input-group-btn">
        <button class="btn btn-default" type="button">Go!</button>
      </span></div>
                </td>
            </tr>
            <tr v-for="obj in table.rows">
                <td>{{obj.pid}}</td>
                <td>{{obj.pname}}</td>
                <td>{{obj.pwd}}</td>
                <td>
                    <button type="button" v-on:Click="updatePerson(obj)" class="btn btn-info btn-xs">修改</button>
                    <button type="button" v-on:Click="deletePerson(obj)" class="btn btn-danger btn-xs">删除</button>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                </td>
                <td colspan="2">
                    <ul class="pagination pull-right">
                        <li>
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li>
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </td>
            </tr>
        </table>
        <div class="modal fade bs-example-modal-lg" tabindex="-1" id="memberModal" role="dialog"
             aria-labelledby="myLargeModalLabel">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content panel panel-default">
                    <div class="panel-body">
                        {{modalTitle}}
                    </div>
                    <div class="panel-footer">
                        <form>
                            <div class="form-group" style="display:none">
                                <label for="exampleInputId">Id</label>
                                <input v-model="person.pid" value="" class="form-control"
                                       id="exampleInputId"
                                       placeholder="Account">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputAccount">Account</label>
                                <input type="text" v-model="person.pname" value="" class="form-control"
                                       id="exampleInputAccount"
                                       placeholder="Account">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword">Password</label>
                                <input type="text" class="form-control" value="" v-model="member.mpassword"
                                       id="exampleInputPassword"
                                       placeholder="Password">
                            </div>
                            <div>
                                <button type="button" v-on:Click="saveMember" class="btn btn-primary">Submit
                                </button>
                                <button type="reset" class="btn btn-warning">Reset</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
<script type="text/javascript" src="plugs/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="plugs/bootstrap.js"></script>
<script type="text/javascript" src="plugs/vue.min.js"></script>
<script type="text/javascript">
    var vue = new Vue({
        el: "#member-table",
        data: {
            modalTitle: "",
            person: {},
            saveUrl: "",
            table: {rows: []}
        },
        methods: {
            queryList: function () {
                var this_ = this;
                $.ajax({
                    dataType: "JSON",
                    url: "queryList.action",
                    success: function (data) {
                        this_.table.rows = data.data;
                    }
                })
                this.hideModal();
            },
            insertPerson: function () {
                this.modalTitle = "new Person";
                this.saveUrl = "insertP.action";
                this.member = {};
                this.showModal();
            },
            updatePerson: function (obj) {
                this.showModal();
                this.member = obj;
                var this_ = this;
                this.modalTitle = "update Person";
                this.saveUrl = "updateP.action"

            },

            deletePerson: function (obj) {
                var this_ = this;
                $.ajax({
                    data: obj,
                    url: "deleteMember.action",
                    success: function () {
                        this_.queryList();
                    }
                })
            },
            savePerson: function () {
                var this_ = this;
                $.ajax({
                    type: "post",
                    url: this_.saveUrl,
                    data: this_.member,
                    success: function (data) {
                        this_.queryList();
                    }
                });
            },
            showModal: function () {
                $("#memberModal").modal("show");
            },
            hideModal: function () {
                $("#memberModal").modal("hide");
            }

        },
        created: function () {
            this.queryList();
        }
    })
</script>
</html>

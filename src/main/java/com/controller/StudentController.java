package com.controller;

import com.entity.StudentEntity;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;

import java.util.List;


public class StudentController extends Controller {


    public void index() {

        List<StudentEntity> studentEntities = StudentEntity.student.find("select * from student");
        renderJson(studentEntities);
    }

    //查询单个

    public void queryById() {
        int sid = getParaToInt("id");
        StudentEntity studentEntity = StudentEntity.student.findFirst("select * from student where sid=?", sid);
        renderJson(studentEntity);

    }


    //增加
    public void addStudent() {
        String sname = getPara("sname");
        String pwd = getPara("pwd");
        String sql = "insert into student(sname,pwd)values(?,?)";
        Db.update(sql, sname, pwd);
    }


    //删除
    public void deleteStudent() {
        int sid = getParaToInt("sid");
        String sql = "delete from student where sid=?";
        Db.update(sql, sid);
    }


    //修改
    public void updateStudent() {
        int sid = getParaToInt("sid");
        String sname = getPara("sname");
        String pwd = getPara("pwd");
        String sql = "update student set sname=?,pwd=? where sid=?";
        int update = Db.update(sql, sname, pwd, sid);
    }


}

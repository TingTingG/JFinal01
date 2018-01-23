package com.biz;

import com.entity.StudentEntity;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

public class StudentBiz {

    private static final StudentEntity dao = new StudentEntity();


    //FENYE
    public Page<StudentEntity> paginate(int page, int size) {

        return dao.paginate(page, size, "select *", "from student");
    }


    public StudentEntity queryOne(int sid) {
        return dao.findById(sid);
    }


    public void delete(int sid) {
        dao.deleteById(sid);
    }


}

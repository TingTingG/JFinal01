package com.config;

import com.controller.StudentController;
import com.entity.StudentEntity;
import com.jfinal.config.*;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import sun.font.TrueTypeFont;

public class MyConfig extends JFinalConfig {


    @Override
    public void configConstant(Constants constants) {
        PropKit.use("db.properties");
        //设置开发环境
        constants.setDevMode(true);
        constants.setViewType(ViewType.JSP);

    }

    @Override
    public void configRoute(Routes routes) {

        routes.add("student", StudentController.class);



    }

    @Override
    public void configPlugin(Plugins plugins) {
        C3p0Plugin c3p0Plugin = new C3p0Plugin(PropKit.get("url"),PropKit.get("username"),PropKit.get("password"),PropKit.get("driver").trim());
        c3p0Plugin.setInitialPoolSize(5);
        c3p0Plugin.setMaxPoolSize(20);

        plugins.add(c3p0Plugin);
        ActiveRecordPlugin activeRecordPlugin=new ActiveRecordPlugin(c3p0Plugin);
        plugins.add(activeRecordPlugin);
        activeRecordPlugin.setShowSql(true);
        activeRecordPlugin.addMapping("student","sid", StudentEntity.class );
    }

    @Override
    public void configInterceptor(Interceptors interceptors) {

    }

    @Override
    public void configHandler(Handlers handlers) {

    }
}

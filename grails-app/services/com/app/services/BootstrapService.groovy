package com.app.services

import com.app.admin.domain.*
import com.app.admin.domain.security.*
import com.app.admin.domain.configuration.*

class BootstrapService {

    static transactional = false

    def grailsApplication

    def loadRequestMap() {
        //Load requestMap here if requestMap activated
    }

    def loadInitialData(){
        log.info("Loading initial data...")

        //Load roles
        def userRole = Role.findByAuthority(Role.USER) ?: new Role(authority: Role.USER).save(failOnError: true)
        def adminRole = Role.findByAuthority(Role.ADMIN) ?: new Role(authority: Role.ADMIN).save(failOnError: true)

        //Load users
        if(!User.findByUsername('admin')){
            def admin = new User( username:"admin",
                    password:"admin",
                    name:"Admin",
                    email:"raulgomis@gmail.com",
                    enabled:true,
                    accountExpired:false,
                    accountLocked:false,
                    passwordExpired:false).save()
            UserRole.create admin, adminRole
        }

        def configMap = [
                "grailsbs.BT_SITE_NAME":"Grails Bootstrap",
                "grailsbs.BT_SITE_OFFLINE":"False",
                "grailsbs.BT_SITE_MAXLISTHOME":"5",
                "grailsbs.BT_SITE_MAXLIST":"30",
                "grailsbs.BT_HELP_FAQ":"FAQ text goes here",

                /*"grails.mail.default.from":"grailsbs@gmail.com",
                "grails.mail.host":"smtp.gmail.com",
                "grails.mail.port":"465",
                "grails.mail.username":"grailsbs@gmail.com",
                "grails.mail.password":"bsgrails",
                 */
        ]

        configMap.each {
            if(!Configuration.findByKey(it.key)) new Configuration(key:it.key,value:it.value).save()
        }
        assert Configuration.list().size() == configMap.size()

        //set grails const
        /*List configurationInstanceList = Configuration.findAllByKeyLike("grails.%")
        for(Configuration c in configurationInstanceList){
            configurationService.setConfigValue("${c.key}",c.value)
        }*/
    }

    def loadExampleData() {
        log.info("Loading example data...")
        def userRole = Role.findByAuthority(Role.USER) ?: new Role(authority: Role.USER).save(failOnError: true)
        def adminRole = Role.findByAuthority(Role.ADMIN) ?: new Role(authority: Role.ADMIN).save(failOnError: true)

        if(!User.findByUsername('user')){
        def user = new User( username:"user",
                                        password:"user",
                                        name:"User 1",
                                        email:"raulgomis@hotmail.com",
                                        enabled:true,
                                        preferences: new UserPreferences(),
                                        accountExpired:false,
                                        accountLocked:false,
                                        passwordExpired:false).save(failOnError: true)
            UserRole.create user, userRole
        }
        assert User.findByUsername('user')!=null
    }

}

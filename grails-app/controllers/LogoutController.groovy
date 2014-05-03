import grails.plugin.springsecurity.SpringSecurityUtils

/**
 * Logout Controller
 *
 * @author Raúl Gomis
 */
class LogoutController {

    /**
     * Index action. Redirects to the Spring security logout uri.
     */
    def index = {
        // TODO put any pre-logout code here
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}

package carmob.carma

class UserController {
    
    def authenticationService
    
    def index = { redirect(action: "list", params: params) }

    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def create = {
        
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

    def save = {
        
        def userInstance = new User(params)
        if (!userInstance.hasErrors() && userInstance.save()) {
            flash.message = "user.created"
            flash.args = [userInstance.id]
            flash.defaultMessage = "User ${userInstance.id} created"
            redirect(action: "show", id: userInstance.id)
        }
        else {
            render(view: "create", model: [userInstance: userInstance])
        }
    }

    def show = {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        
        def userInstance
        def ownProfile = false
        def ownUser = authenticationService.getUserPrincipal()
        
        if (params.id == null || params.long("id") == ownUser?.id) {
            userInstance = User.get(ownUser.id)
            ownProfile = true
        } else {
            userInstance = User.get(params.id)
        }
        
        if (!userInstance) {
            flash.message = "user.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "User not found with id ${params.id}"
        }
        else {
            return [userInstance: userInstance, ownProfile: ownProfile, carma: userInstance.carma]
        }
    }

    def edit = {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        
        def userInstance
        def ownUser = authenticationService.getUserPrincipal()
        userInstance = User.get(ownUser.id)
        return [userInstance: userInstance]
        
        
    }

    def update = {
         if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        
        def userInstance = User.get(params.id)
        def avatar = userInstance.avatar
        
        if (userInstance) {
            userInstance.properties = params
            
            if (!userInstance.hasErrors() && userInstance.save()) {
                flash.message = "user.updated"
                flash.args = [params.id]
                flash.defaultMessage = "User ${params.id} updated"
                redirect(action: "show")
            }
            else {
                userInstance.avatar = avatar
                render(view: "edit", model: [userInstance: userInstance])
            }
        }
        else {
            flash.message = "user.not.found"
            flash.args = [params.id]
            flash.defaultMessage = "Benutzer mit ID ${params.id} nicht gefunden"
            redirect(action: "edit", id: params.id)
        }
    }
    
    def avatar_image = {
        def avatarUser
        
        if (params.id == null) {
            avatarUser = User.get(authenticationService.getSessionUser()?.userObjectId)
        } else {
            avatarUser = User.get(params.id)
        }
        
        if (!avatarUser || !avatarUser.avatar) {
            response.sendError(404)
            return;
        }
        
        response.setContentLength(avatarUser.avatar.size())
        OutputStream out = response.getOutputStream();
        out.write(avatarUser.avatar);
        out.close();
    }
}

package carmob.carma


/**
* Controller zur Anzeige der User-Profile und zum verwalten des User-Domain Models
*/ 
class UserController {
    
    def authenticationService
    
    /**
    * Nicht verwendet
    */ 
    def index = { 
        redirect(action: "list", params: params) 
    }


    // the delete, save and update actions only accept POST requests
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    /**
    * Nicht verwendet
    */ 
    def create = {
        def userInstance = new User()
        userInstance.properties = params
        return [userInstance: userInstance]
    }

     /**
    * Nicht verwendet
    */ 
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
    /**
    * Anzeige eines Nutzerprofils
    */
    def show = {
        if (!authenticationService.isLoggedIn(request)) {
            redirect(controller: "Index", action: "login")
            return
        }
        
        def userInstance
        def ownProfile = false
        def ownUser = authenticationService.getUserPrincipal()
        
        def historys = History.createCriteria().list(max: 3) {
            and {
                eq("user", ownUser)
            } 
            order("date","desc")
        }
        
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
            return [userInstance: userInstance, ownProfile: ownProfile, carma: userInstance.carma, historyInstanceList:historys]
        }
    }

     /**
    * Rendert das Formular zum editieren des eigenen Nutzerprofils
    */ 
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

    /** 
    * Aktualisiert ein Nutzerprofil
    */
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
    
    /**
    * Anzeige eines Bildavatars aus der Datenbank
    */
    def avatar_image = {
        def avatarUser
        
        if (params.id == null) {
            avatarUser = authenticationService.getUserPrincipal()
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

<%@ page import="org.codehaus.groovy.grails.web.servlet.GrailsApplicationAttributes" %>
<!doctype html>
<html>
  <head>
    <meta charset="utf-8">
    <title><g:layoutTitle default="${meta(name: 'app.name')}"/></title>
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="initial-scale = 1.0">

    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <r:require modules="scaffolding"/>
    <r:require modules="bootstrap"/>
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <!--<link rel="apple-touch-icon" href="{resource(dir: 'images', file: 'apple-touch-icon.png')}">-->
    <!--<link rel="apple-touch-icon" sizes="72x72" href="{resource(dir: 'images', file: 'apple-touch-icon-72x72.png')}">-->
    <!--<link rel="apple-touch-icon" sizes="114x114" href="{resource(dir: 'images', file: 'apple-touch-icon-114x114.png')}">-->
    <g:layoutHead/>
    <r:layoutResources/>
  </head>
  <body>
    <nav class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="${createLink(uri: '/')}">CARMA</a>
          <auth:ifLoggedIn>
            <div class="nav-collapse">
              <ul class="nav">
                <li>
                  <g:form class="navbar-form" controller="transfer" action="select_direction" >
                    <g:actionSubmit action="select_direction" value="Holen" class="btn-danger btn"/>
                  </g:form>
                </li>
                <li>&nbsp;</li>
                <li>
                  <g:form class="navbar-form" controller="reservation" action="create" >
                    <g:actionSubmit action="create" value="Abgeben" class="btn-success btn"/>
                  </g:form>
                </li>
              </ul>
              <ul class="nav pull-right">
                <li>
                  <g:form class="navbar-form" controller="user" action="show" >
                    <g:actionSubmit action="show" value="Profil" class="btn-info btn"/>
                  </g:form>
                </li>
                <li>&nbsp;</li>
                <li>
                  <auth:form authAction="logout" success="[controller:'index', action:'index']" error="[controller:'index', action:'index']" class="navbar-form pull-right">
                    <div><g:actionSubmit value="Logout" class="btn"/></div>
                  </auth:form>
                </li>
              </ul>
            </div>
          </auth:ifLoggedIn>
        </div>
      </div>
    </nav>
    <div class="container-fluid">
      <g:if test="${flash.authenticationFailure}">
        <div class="alert alert-block">
          <a class="close" data-dismiss="alert" href="#">×</a>
          <h4 class="alert-heading">Warnung</h4>
          <g:if test="${flash.authenticationFailure.result == flash.authenticationFailure.ERROR_NO_SUCH_LOGIN}">
            Dieser Benutzer ist nicht registriert!
          </g:if>
           <g:if test="${flash.authenticationFailure.result == flash.authenticationFailure.ERROR_INCORRECT_CREDENTIALS}">
            Falscher Benutzername oder falsches Passwort!
          </g:if>
           <g:if test="${flash.authenticationFailure.result == flash.authenticationFailure.ERROR_LOGIN_NAME_NOT_AVAILABLE}">
              Nutzer bereits registriert! 
          </g:if>
            <g:if test="${flash.authenticationFailure.result == flash.authenticationFailure.AWAITING_CONFIRMATION}">
              Sie müssen zunächst den per Email an sie zugesendeten Bestätigungslink klicken.
          </g:if>
        </div>
      </g:if>
    </div>
    <div class="container-fluid">
      <g:hasErrors bean="${flash.loginFormErrors}">
        <div class="alert alert-block">
          <a class="close" data-dismiss="alert" href="#">×</a>
          <h4 class="alert-heading">Warnung</h4>
          <g:eachError bean="${flash.loginFormErrors}">
            <% code="authentication.${it.field}.${it.code}.message" %>
            <g:if test="${message(code: code, default:'')}">
              <% arguments = [it.field] %>
              <li><g:message code="${code}" args="${arguments}"/></li>
            </g:if><g:else>
              <li><g:message error="${it}"/></li>
            </g:else>
          </g:eachError>
        </div>
      </g:hasErrors>
      <g:hasErrors bean="${flash.signupFormErrors}">
        <div class="alert alert-block">
          <a class="close" data-dismiss="alert" href="#">×</a>
          <h4 class="alert-heading">Warnung</h4>
            <g:eachError bean="${flash.signupFormErrors}">
              <% code="authentication.${it.field}.${it.code}.message" %>
            <g:if test="${message(code: code, default:'')}">
              <% arguments = [it.field] %>
              <li><g:message code="${code}" args="${arguments}"/></li>
            </g:if><g:else>
              <li><g:message error="${it}"/></li>
            </g:else>
          </g:eachError>
        </div>
      </g:hasErrors>
      <g:hasErrors bean="${userInstance}">
        <div class="alert alert-block">
          <a class="close" data-dismiss="alert" href="#">×</a>
          <h4 class="alert-heading">Warnung</h4>
            <ul class="errors" role="alert">
          <g:eachError bean="${userInstance}" var="error">
            <li><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
        </div>
      </g:hasErrors>
      <g:layoutBody/>
    </div>
    <r:layoutResources/>
  </body>
</html>
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
    <r:require module="jquery-ui"/>
    
    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <!--<link rel="apple-touch-icon" href="{resource(dir: 'images', file: 'apple-touch-icon.png')}">-->
    <!--<link rel="apple-touch-icon" sizes="72x72" href="{resource(dir: 'images', file: 'apple-touch-icon-72x72.png')}">-->
    <!--<link rel="apple-touch-icon" sizes="114x114" href="{resource(dir: 'images', file: 'apple-touch-icon-114x114.png')}">-->
    <g:layoutHead/>
    <r:layoutResources/>
     <script type="text/javascript">
        $(document).ready(function()
        {
          $("#datepicker").datepicker({dateFormat: 'dd.mm.yy',defaultDate:"${new Date().format("dd.MM.yyyy")}",minDate:"${new Date().format("dd.MM.yyyy")}" , showOn: 'button'});
        })
    </script>
  </head>
  <body>
    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid navbar-top-fix">
          <a class="brand" href="${createLink(uri: '/')}">CARMA</a>
          <auth:ifLoggedIn>
            <g:link class="home-link btn-info btn btn-large" controller="index" action="index" title="Home">
              <i class="icon-home icon-white"></i>
            </g:link>
            <g:link controller="transfer" action="select_direction" class="btn-danger btn btn-large" id="1" title="Holen">
              <g:img dir="images" file="holen02_w.png" alt="Reservierung holen"/>
            </g:link>
            <g:link class="btn-success btn btn-large" controller="reservation" action="create" title="Abgeben">
              <g:img dir="images" file="abgeben02_w.png" alt="Reservierung abgeben"/>
            </g:link>
            <auth:form class="pull-right navbar-form-fix" authAction="logout" success="[controller:'index', action:'index']" error="[controller:'index', action:'index']" >
              <g:actionSubmit value="Logout" class="btn btn-large logout-btn"/>
            </auth:form>
            <div class="pull-right user-spacing-fix">
              <g:link class="btn-info btn btn-large" controller="user" action="show" title="Mein Profil">
                <g:img dir="images" file="user.png" alt="Benutzerprofil"/>
              </g:link> &nbsp;
            </div>
          </auth:ifLoggedIn>
        </div>
      </div>
    </div>
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
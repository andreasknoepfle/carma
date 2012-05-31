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
                <li><g:link controller="transfer" action="select_direction"><i class="icon-share  icon-white"></i> Holen</g:link></li>
                <li><g:link controller="Reservation" action="create"><i class="icon-edit  icon-white"></i> Abgeben</g:link></li>
              </ul>
             
              <auth:form authAction="logout" success="[controller:'index', action:'index']" error="[controller:'index', action:'index']" class="navbar-form pull-right">
                <div><g:actionSubmit value="Logout" class="btn"/></div>
              </auth:form>
               <auth:ifLoggedIn><ul class="nav pull-right"><li><g:link controller="Reservation" action="list" ><i class="icon-user icon-white"></i> Profil</g:link></li></div></auth:ifLoggedIn>
                
            </div>
          </auth:ifLoggedIn>
        </div>
      </div>
    </nav>
    
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
      <g:layoutBody/>
    </div>
    <r:layoutResources/>
  </body>
</html>
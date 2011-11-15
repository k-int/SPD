<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'layout.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'jquery.qtip.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />       
		<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/base/jquery-ui.css" type="text/css" media="all" />
		<link rel="stylesheet" href="http://static.jquery.com/ui/css/demo-docs-theme/ui.theme.css" type="text/css" media="all" />
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js" type="text/javascript"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/jquery-ui.min.js" type="text/javascript"></script>
		<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.8.1/jquery.validate.min.js"></script>
		<script src="${resource(dir:'js/plugin', file:'jquery.qtip.min.js')}" type="text/javascript"></script>      
        <g:javascript library="application" />  
		<!--[if lt IE 8]>
		<link rel="stylesheet" href="${resource(dir:'css',file:'ie7.css')}" />
		<![endif]-->
        <g:layoutHead />
    </head>
    <body>
    	<div id="nav-outer">
    		<div id="nav-inner">
    			<ul>
    				<li><g:link controller="home" action="index" class="nav-home">Home</g:link></li>
    				<n:isLoggedIn>
    				<li><g:link controller="visit" action="search" class="nav-visit">Visits</g:link></li>
    				<li><g:link controller="affiliation" action="list" class="nav-affiliation">My Museums</g:link></li>
    				<n:isAdministrator>
    				<li><g:link controller="museum" action="search" class="nav-museum">Museums</g:link></li>
    				<li><g:link controller="school" action="search" class="nav-school">Schools</g:link></li>
    				<li><g:link controller="region" action="list" class="nav-region">Regions</g:link></li>
    				</n:isAdministrator>
    				<li><g:link controller="generateReport" action="index" class="nav-report">Reports</g:link></li>
    				<n:isAdministrator>
    				<li><g:link url="/spd/administration/users/list" class="nav-admin">Admin</g:link></li>
    				</n:isAdministrator>
    				<li><g:link controller="auth" action="logout" class="secondary">Logout</g:link></li>
    				</n:isLoggedIn>
    				<n:isNotLoggedIn>
    				<li><g:link controller="visit" action="search" class="nav-login secondary">Login</g:link></li>
    				<li><g:link url="register" class="nav-register secondary">Register</g:link></li>
    				</n:isNotLoggedIn>
    			</ul>
    		</div>
    	</div>
    	<div id="content">
        <g:layoutBody />
        </div>
        <div id="footer-outer">
    		<div id="footer-inner">
    			<img src="/spd/images/col_trust_small.png" />
    			<span>Schools Participation Database &copy; 2011 Collections Trust</span>
    			<ul>
    				<li><g:link controller="support" action="index">Support</g:link></li>
    			</ul>
    		</div>
    	</div>
    </body>
</html>
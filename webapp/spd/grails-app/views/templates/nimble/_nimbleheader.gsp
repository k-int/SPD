<!--  <div id="banner">
	<h1><g:message code="nimble.layout.admin.banner.heading" /></h1>
	
	<g:if test="${navigation}">
		<n:isLoggedIn>
			<div id="userops">
				<g:message code="nimble.label.usergreeting" /> <n:principalName /> | <g:link controller="auth" action="logout" class=""><g:message code="nimble.link.logout.basic" /></g:link>
			</div>
		</n:isLoggedIn>
	</g:if>
</div>-->
<g:javascript>
$(document).ready(function () 
{
	$('head').append('<link rel="stylesheet" href="/spd/css/layout.css" type="text/css" />');
	$('head').append('<!--[if lt IE 10]><link rel="stylesheet" href="/spd/css/ie7.css" /><![endif]-->');
});
</g:javascript>
<div id="nav-outer">
	<div id="nav-inner">
		<ul>
			<li><g:link controller="home" action="index" class="nav-home">Home</g:link></li>
			<n:isLoggedIn>
			<li><g:link controller="visit" action="search" class="nav-visit">Visits</g:link></li>
			<li><g:link controller="affiliation" action="list" class="nav-affiliation">Affiliations</g:link></li>
			<n:isAdministrator>
			<li><g:link controller="museum" action="search" class="nav-museum">Museums</g:link></li>
			<li><g:link controller="school" action="search" class="nav-school">Schools</g:link></li>
			<li><g:link controller="region" action="list" class="nav-region">Regions</g:link></li>
			<li><g:link controller="generateReport" action="index" class="nav-report">Reports</g:link></li>
			<li><g:link url="/spd/administration/users/list">Admin</g:link></li>
			</n:isAdministrator>
			<li><g:link controller="auth" action="logout" class="secondary">Logout</g:link></li>
			</n:isLoggedIn>
			<n:isNotLoggedIn>
			<li><g:link controller="securedHome" action="index" class="nav-login secondary">Login</g:link></li>
			<li><g:link url="register" class="nav-register secondary">Register</g:link></li>
			</n:isNotLoggedIn>
		</ul>
	</div>
</div>
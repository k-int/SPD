<h3><g:message code="nimble.view.user.show.extendedinformation.heading" /></h3>

<table class="datatable">
 	<tbody>
		<tr>
	    	<th><g:message code="nimble.label.fullname" /></th>
			<td>${user.profile?.fullName?.encodeAsHTML()}</td>
		</tr>
		<tr>
	    	<th><g:message code="nimble.label.email" /></th>
			<td>${user.profile?.email?.encodeAsHTML()}</td>
		</tr>
	</tbody>
</table>

<h3>Affiliations</h3>

<g:if test="${user.affiliations?.size() > 0}">
  <table class="details">
    <thead>
    <tr>
      <th class="first">Museum</th>
      <th class="last">Status</th>
    </tr>
    </thead>
    <tbody>

    <g:each in="${user.affiliations}" status="i" var="affil">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td>${affil.museum}</td>
        <td>${affil.status}</td>
      </tr>
    </g:each>

    </tbody>
  </table>
</g:if>
<g:else>
  <p>
   	No Affiliations
  </p>
</g:else>
package com.k_int.spd.domain

import grails.plugins.nimble.core.Role
import grails.plugins.nimble.core.AdminsService
import grails.plugins.nimble.core.UserService
import org.apache.shiro.SecurityUtils

import com.k_int.spd.utils.StatusEnum

class Affiliation 
{
	Museum museum
	User user
	StatusEnum status = StatusEnum.PENDING
	
	static Affiliation link(user, museum) 
	{ 
		def link = Affiliation.findByUserAndMuseum(user, museum) 
		def authenticatedUser = User.get(SecurityUtils.getSubject()?.getPrincipal())
		
		if(!authenticatedUser)
		{
			println "Not able to determine currently authenticated user"
			//response.sendError(403)
			return
		}
		else if (!link) 
		{
			 link = new Affiliation()
			 user?.addToAffiliations(link)
			 museum?.addToAffiliates(link)
			 
			 authenticatedUser.roles.each
			 {
				 role ->
				 
				 println "logged in user has role : " + role.name
				 //if user is an admin then automatically accept the affiliation
				 if(role.name == AdminsService.ADMIN_ROLE)
				 {
					 println "logged in user is an admin so setting status to accepted immediately"
					 link.status = StatusEnum.ACCEPTED
				 }
			 }  
			 
			 link.save()
		} 
		else if(link?.status == StatusEnum.REJECTED)
		{
			//if previously rejected set to pending
			link.status = StatusEnum.PENDING
			
			authenticatedUser.roles.each
			{
				role ->
				
				//if user is an admin then automatically accept the affiliation
				if(role.name == AdminsService.ADMIN_ROLE)
				{
					link.status = StatusEnum.ACCEPTED
				}
			}
				
			link.save()
		}
		
		return link
	}

	static void unlink(user, museum) 
	{ 
		def link = Affiliation.findByUserAndMuseum(user, museum) 
		
		if (link) 
		{ 
			user?.removeFromAffiliations(link) 
			museum?.removeFromAffiliates(link)
			link.delete() 
		} 
	} 
	
	static void unlink(id)
	{
		def link = Affiliation.get(id)
		
		if (link)
		{
			link.user?.removeFromAffiliations(link)
			link.museum?.removeFromAffiliates(link)
			link.delete()
		}
	}
}

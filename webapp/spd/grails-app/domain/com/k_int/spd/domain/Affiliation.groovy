package com.k_int.spd.domain

import grails.plugins.nimble.core.Role
import grails.plugins.nimble.core.Permission
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
		if(!museum)
		{
			println "Not able to determine museum"
			//response.sendError(403)
			return
		}
		else if (!link) 
		{
			link = new Affiliation(user:user,museum:museum)
			 
			 authenticatedUser.roles.each
			 {
				 role ->
				 
				 println "logged in user has role : " + role.name
				 //if user is an admin then automatically accept the affiliation
				 if(role.name == AdminsService.ADMIN_ROLE)
				 {
					 println "logged in user is an admin so setting status to accepted immediately"
					 link.status = StatusEnum.ACCEPTED
					 
					 def permission = Permission.findByTargetAndUser("reportby.museum." + museum.id, user)
					 
					 if(!permission)
					 {
						 permission = new Permission(target: "reportby.museum." + museum.id, type: Permission.defaultPerm)
						 user.addToPermissions(permission)
					 }
				 }
			 }  
			 
			 if(!link.save())
			 {
				 link.errors.each { error ->
					 println error
				 }
			 }
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
					
					def permission = Permission.findByTargetAndUser("reportby.museum." + museum.id, user)
					
					if(!permission)
					{
						permission = new Permission(target: "reportby.museum." + museum.id, type: Permission.defaultPerm)
						user.addToPermissions(permission)
					}
				}
			}
				
			if(!link.save())
			{
				link.errors.each { error ->
					println error
				}
			}
		}
		
		return link
	}

	static void unlink(user, museum) 
	{ 
		def link = Affiliation.findByUserAndMuseum(user, museum) 
		
		if (link) 
		{ 			
			def permission = Permission.findByTargetAndUser("reportby.museum.${link.museum.id}", user)
			
			if(permission)
			{
				link.user.removeFromPermissions(permission)
				permission.delete();
			}
						
			link.delete() 
		} 
	} 
	
	static void unlink(id)
	{
		def link = Affiliation.get(id)
		
		if (link)
		{
			def permission = Permission.findByTargetAndUser("reportby.museum.${link.museum.id}", link.user)
			
			if(permission)
			{
				link.user.removeFromPermissions(permission)
				permission.delete();
			}
						
			link.delete()
		}
	}
}

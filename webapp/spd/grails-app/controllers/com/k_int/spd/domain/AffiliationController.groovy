package com.k_int.spd.domain

import com.k_int.spd.utils.StatusEnum
import grails.plugins.nimble.core.AdminsService
import grails.converters.*
import org.apache.shiro.SecurityUtils

class AffiliationController {

    def index = { 
    redirect(action: "list", params: params)
  }
  
  def create = 
  {
    def userInstance = User.get(SecurityUtils.getSubject()?.getPrincipal())
    def affiliationInstance = new Affiliation()
    affiliationInstance.properties = params
    return [affiliationInstance: affiliationInstance, userInstance: userInstance]
  }
  
  def save = 
  {
    def userInstance = User.findById(params.user.id)
    def museumInstance = Museum.findByName(params.museum.name)
    def affiliationInstance = Affiliation.link(userInstance, museumInstance)
    
    if (affiliationInstance) 
    {
      flash.message = "${message(code: 'default.created.message', args: [message(code: 'affiliation.label', default: 'Affiliation'), affiliationInstance.id])}"
      redirect(action: "list")
    }
    else
    {
      render(view: "create", model: [affiliationInstance: affiliationInstance])
    }
  }
  
  def grant = 
  {
    def affiliationInstance = Affiliation.get(params.id) 
    if(affiliationInstance) {
      affiliationInstance.status = StatusEnum.ACCEPTED;
      // Add an explicit system permission for this user to report on the identified museum
      affiliationInstance.user.addToPermissions("reportby.museum.${affiliationInstance.museum.id}")
      affiliationInstance.save(flush: true)
    }
    else
    {
      flash.message = "Unable to grant affiliation request as none was selected."
    }
    
    redirect(action: "list")
  }
  
  def reject =
  {
    def affiliationInstance = Affiliation.get(params.id) 
    if(affiliationInstance)
    {
      affiliationInstance.status = StatusEnum.REJECTED;
	  affiliationInstance.user.removeFromPermissions("reportby.museum.${affiliationInstance.museum.id}")
      affiliationInstance.save(flush: true)
    }
    else
    {
      flash.message = "Unable to reject affiliation request as none was selected."
    }
    redirect(action: "list")
  }
  
  def list =
  {  
    params.max = Math.min(params.max ? params.int('max') : 10, 100)
    def results = []    
    //get logged in user
    def user = User.get(SecurityUtils.getSubject()?.getPrincipal())
    
    results = Affiliation.createCriteria().list(max: params.max, offset: params.offset)
    {
      createAlias('user', 'usr')
      createAlias('museum', 'mus')
      createAlias('museum.region', 'reg')
      and
      {
        if(params.user?.id) 
        { 
          eq("usr.id", params.user?.id) 
        }
        if(user?.roles.collect{it.name}.contains(AdminsService.ADMIN_ROLE) == false)  
        { 
          eq("usr.id", user?.id) 
        }  
        if(params.sort && params.order)
        {
          if(params.sort == 'user.username')
          {
            order("usr.username", params.order)
          }
          else if(params.sort == 'museum.name')
          {
            order("mus.name", params.order)
          }
          else if(params.sort == 'museum.region.regionName')
          {
            order("reg.regionName", params.order)
          }
          else
          {
            order(params.sort, params.order)
          }
        }
      }
    }
    
    
    [affiliationInstanceList: results, affiliationInstanceTotal: results.totalCount]
  }
  
  def delete = 
  {
    if(params.id)
    {
      Affiliation.unlink(params.id)
    }
    else
    {
      flash.message = "Unable to delete affiliation as none was selected."
    }
    redirect(action: "list")
  }
  
  def autocomplete = {
    def results = [];
    def user = User.get(SecurityUtils.getSubject()?.getPrincipal())
    
    if(params.term && params.term.length() > 0)
    {
      results = user.allAffiliations().findAll{ m -> m?.name?.toLowerCase().indexOf(params.term.toLowerCase()) != -1}
                      .collect{it.name}
    }

    render results as JSON
  }

}

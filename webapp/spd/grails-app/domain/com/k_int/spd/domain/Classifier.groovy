package com.k_int.spd.domain

class Classifier {

  /*
  postings = []
  static hasMany = [postings:Visit]
  */

  int classificationLevel
  Classifier parent
  String classnIdentifier

  static constraints = { 
    parent(nullable:true)
  } 
}

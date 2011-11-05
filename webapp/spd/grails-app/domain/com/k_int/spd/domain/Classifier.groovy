package com.k_int.spd.domain

class Classifier {

  int classificationLevel
  Classifier parent
  String classnIdentifier
  String label

  static hasMany = [postings:Visit]
  static belongsTo = Visit

  static constraints = { 
    parent(nullable:true)
  } 
}

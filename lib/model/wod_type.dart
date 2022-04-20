enum WodType {
  FOR_TIME,
  AMRAP,
  EMOM
}

WodType fromSting(String wod){
  if(wod == "FOR_TIME"){
    return WodType.FOR_TIME;
  }
  if(wod == "AMRAP"){
    return WodType.AMRAP;
  }
  if(wod == "EMOM"){
    return WodType.EMOM;
  }
}
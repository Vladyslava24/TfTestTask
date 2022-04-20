enum Plan { free, premium, unknown }

Plan convertStringToPlan(String plan) {
  switch(plan) {
    case 'FREE':
      return Plan.free;
    case 'PREMIUM':
      return Plan.premium;
    default:
      return Plan.unknown;
  }
}


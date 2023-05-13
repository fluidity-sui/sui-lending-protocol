module protocol::obligation_collaterals {
  
  use std::type_name::TypeName;
  use sui::tx_context::TxContext;
  use x::wit_table::{Self, WitTable};
  
  struct Collateral has copy, store {
    amount: u64
  }
  
  struct ObligationCollaterals has drop {}
  
  public fun new(ctx: &mut TxContext): WitTable<ObligationCollaterals, TypeName, Collateral>  {
    wit_table::new(ObligationCollaterals{}, true, ctx)
  }
  
  public fun init_collateral_if_none(
    collaterals: &mut WitTable<ObligationCollaterals, TypeName, Collateral>,
    type_name: TypeName,
  ) {
    if (wit_table::contains(collaterals, type_name)) return;
    wit_table::add(ObligationCollaterals{}, collaterals, type_name, Collateral{ amount: 0 });
  }
  
  public fun increase(
    collaterals: &mut WitTable<ObligationCollaterals, TypeName, Collateral>,
    type_name: TypeName,
    amount: u64,
  ) {
    init_collateral_if_none(collaterals, type_name);
    let collateral = wit_table::borrow_mut(ObligationCollaterals{}, collaterals, type_name);
    collateral.amount = collateral.amount + amount;
  }
  
  public fun decrease(
    collaterals: &mut WitTable<ObligationCollaterals, TypeName, Collateral>,
    type_name: TypeName,
    amount: u64,
  ) {
    let collateral = wit_table::borrow_mut(ObligationCollaterals{}, collaterals, type_name);
    collateral.amount = collateral.amount - amount;
  }
  
  public fun collateral(
    collaterals: &WitTable<ObligationCollaterals, TypeName, Collateral>,
    type_name: TypeName,
  ): u64 {
    let collateral = wit_table::borrow(collaterals, type_name);
    collateral.amount
  }
}
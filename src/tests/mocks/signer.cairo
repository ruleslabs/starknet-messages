#[starknet::contract]
mod Signer {
  use array::ArrayTrait;

  // locals
  use rules_account::account;
  use rules_account::account::Account;
  use rules_account::account::Account::HelperTrait;

  //
  // Storage
  //

  #[storage]
  struct Storage {
    _public_key: felt252,
  }

  //
  // Constructor
  //

  #[constructor]
  fn constructor(ref self: ContractState, public_key_: felt252) {
    self._public_key.write(public_key_);
  }

  #[external(v0)]
  fn is_valid_signature(self: @ContractState, message: felt252, signature: Array<felt252>) -> u32 {
    let mut account_self = Account::unsafe_new_contract_state();

    if (account_self._is_valid_signature(:message, signature: signature.span(), public_key: self._public_key.read())) {
      account::interface::ERC1271_VALIDATED
    } else {
      0_u32
    }
  }
}

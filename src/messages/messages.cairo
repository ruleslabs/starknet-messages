#[contract]
mod Messages {
  use array::SpanTrait;
  use rules_account::account;

  // dispatchers
  use rules_account::account::{ AccountABIDispatcher, AccountABIDispatcherTrait };

  //
  // Storage
  //

  struct Storage {
    // message_hash -> consumed
    _consumed_messages: LegacyMap<felt252, bool>,
  }

  //
  // Internals
  //

  #[internal]
  fn _is_message_signature_valid(hash: felt252, signature: Span<felt252>, signer: starknet::ContractAddress) -> bool {
    // check signature
    let signer_account = AccountABIDispatcher { contract_address: signer };
    signer_account.is_valid_signature(message: hash, :signature) == account::interface::ERC1271_VALIDATED
  }

  #[internal]
  fn _is_message_consumed(hash: felt252) -> bool {
    _consumed_messages::read(hash)
  }

  #[internal]
  fn _consume_message(hash: felt252) {
    _consumed_messages::write(hash, true);
  }
}

#[starknet::contract]
mod Messages {
  use array::SpanTrait;
  use rules_account::account;

  // dispatchers
  use rules_account::account::{ AccountABIDispatcher, AccountABIDispatcherTrait };

  //
  // Storage
  //

  #[storage]
  struct Storage {
    // message_hash -> consumed
    _consumed_messages: LegacyMap<felt252, bool>,
  }

  //
  // Internals
  //

  #[generate_trait]
  impl InternalImpl of InternalTrait {
    fn _is_message_signature_valid(
      self: @ContractState,
      hash: felt252,
      signature: Span<felt252>,
      signer: starknet::ContractAddress
    ) -> bool {
      // check signature
      let signer_account = AccountABIDispatcher { contract_address: signer };
      signer_account.is_valid_signature(message: hash, :signature) == starknet::VALIDATED
    }

    fn _is_message_consumed(self: @ContractState, hash: felt252) -> bool {
      self._consumed_messages.read(hash)
    }

    fn _consume_message(ref self: ContractState, hash: felt252) {
      self._consumed_messages.write(hash, true);
    }
  }
}

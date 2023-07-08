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
  // Helpers
  //

  #[generate_trait]
  #[external(v0)]
  impl HelperImpl of HelperTrait {
    fn _is_message_signature_valid(
      self: @ContractState,
      hash: felt252,
      signature: Span<felt252>,
      signer: starknet::ContractAddress
    ) -> bool {
      // check signature
      let signer_account = AccountABIDispatcher { contract_address: signer };
      signer_account.is_valid_signature(message: hash, :signature) == account::interface::ERC1271_VALIDATED
    }

    #[internal]
    fn _is_message_consumed(self: @ContractState, hash: felt252) -> bool {
      self._consumed_messages.read(hash)
    }

    #[internal]
    fn _consume_message(ref self: ContractState, hash: felt252) {
      self._consumed_messages.write(hash, true);
    }
  }
}

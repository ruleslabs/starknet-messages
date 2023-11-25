const ERC1271_VALIDATED: felt252 = 0x1626ba7e;

#[starknet::component]
mod MessagesComponent {
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
  impl InternalImpl<
    TContractState,
    +HasComponent<TContractState>,
    +Drop<TContractState>
  > of InternalTrait<TContractState> {
    fn _is_message_signature_valid(
      self: @ComponentState<TContractState>,
      hash: felt252,
      signature: Span<felt252>,
      signer: starknet::ContractAddress
    ) -> bool {
      // check signature
      let signer_account = AccountABIDispatcher { contract_address: signer };
      let res = signer_account.is_valid_signature(message: hash, :signature);

      (res == starknet::VALIDATED) | (res == super::ERC1271_VALIDATED)
    }

    fn _is_message_consumed(self: @ComponentState<TContractState>, hash: felt252) -> bool {
      self._consumed_messages.read(hash)
    }

    fn _consume_message(ref self: ComponentState<TContractState>, hash: felt252) {
      self._consumed_messages.write(hash, true);
    }
  }
}

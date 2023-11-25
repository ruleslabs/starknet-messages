#[starknet::contract]
mod MessagesContract {
  // locals
  use messages::messages::MessagesComponent;

  component!(path: MessagesComponent, storage: messages, event: MessagesEvent);

  impl InternalImpl = MessagesComponent::InternalImpl<ContractState>;

  //
  // Event
  //

  #[event]
  #[derive(Drop, starknet::Event)]
  enum Event {
    #[flat]
    MessagesEvent: MessagesComponent::Event,
  }

  //
  // Storage
  //

  #[storage]
  struct Storage {
    #[substorage(v0)]
    messages: MessagesComponent::Storage,
  }
}

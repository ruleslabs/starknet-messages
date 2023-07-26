use array::ArrayTrait;

// locals
use messages::typed_data::typed_data::Domain;

fn URI() -> Array<felt252> {
  array![111, 222, 333]
}

fn CHAIN_ID() -> felt252 {
  'SN_MAIN'
}

fn DOMAIN() -> Domain {
  Domain {
    name: 'Rules',
    version: '1.1',
  }
}

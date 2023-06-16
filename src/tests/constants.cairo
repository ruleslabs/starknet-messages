use array::ArrayTrait;

// locals
use messages::typed_data::typed_data::Domain;

fn URI() -> Array<felt252> {
  let mut uri = ArrayTrait::new();

  uri.append(111);
  uri.append(222);
  uri.append(333);

  uri
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

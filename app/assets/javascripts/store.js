FF.Store = DS.Store.extend({
  revision: 4,
  adapter: DS.localStorageAdapter.create()
});


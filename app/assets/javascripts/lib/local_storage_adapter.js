//require("ember-data/core");
//require('ember-data/system/adapters');

var get = Ember.get, set = Ember.set, getPath = Ember.getPath;

DS.localStorageAdapter = DS.Adapter.extend({
  createRecord: function(store, type, model) {
    var id = this.storage.getMaxId(type) + 1;
    model.set('id', id);

    var newRecord = model.toJSON({associations: true});
    this.storage.setById(type, id, newRecord);

    //this.updateParents(store, type, newRecord, "create");
    
    store.didCreateRecord(model, newRecord);
  },
  updateRecord: function(store, type, model) {
    var id = model.get('id');
    var record = model.toJSON({associations: true});

    this.storage.setById(type, id, record);

    //this.updateParents(store, type, record, "update");

    store.didUpdateRecord(model, record);
  },

  deleteRecord: function(store, type, model) {
    var id = model.get('id');
    var record = model.toJSON({associations: true});

    var records = this.storage.getAll(type);
    //this took all of the records that existed already out of the newRecords var
    var index;
    records.forEach(function (record, i) {
      if (record.id === id)
        index = i;
    });

    records.splice(index, 1);

    this.storage.setAll(type, records);
    
    //this.updateParents(store, type, record, "delete")
    
    store.didDeleteRecord(model, record);
  },

  find: function(store, type, id) {
    var record = this.storage.getById(type, id);
    store.load(type, id, record);
  },

  findAll: function(store, type) {
    var allRecords = this.storage.getAll(type);
    store.loadMany(type, allRecords);
  },


  storage: {
    setAll: function(type, value) {
      localStorage.setItem(type, JSON.stringify(value));
    },

    getAll: function(type) {
      var value = localStorage.getItem(type);
      value = JSON.parse(value) || [];
      return value;
    },

    getById: function(type, id) {
      var all = this.getAll(type);

      var match;
      all.forEach(function (record) {
        if (record.id === id)
          match = record;
      });

      return match;
    },

    setById: function(type, id, newRecord) {
      var all = this.getAll(type);

      var match;
      var index;
      all.forEach(function (record, i) {
        if (record.id === id) {
          match = record;
          index = i;
        }
      });

      if (match) {
        all[index] = newRecord;
      }
      else {
        all.push(newRecord);
      }

      this.setAll(type, all);
    },

    getMaxId: function(type) {
      var allRecords = this.getAll(type);
      var greatestId = 0;
      allRecords.forEach(function (record) {
        if (record.id > greatestId)
          greatestId = record.id;
      });
      return greatestId;
    }
  },

  updateParents: function(store, type, record, action) {
    var associations = get(type, 'associationsByName');
    associations.forEach(function(key, meta) {
      if (meta.kind === 'belongsTo') {
        var belongsToKey = meta.key + "_id"; // todo: use namingConvention
        var parentId = record[belongsToKey];
        var parentType = meta.type;
        var parentRecord = this.storage.getById(parentType, parentId);

        var associationKey;

        /*_.find(_.keys(parentRecord), function(prop) {
return parentType.typeForAssociation(prop) == type;
});*/

        var childrenArray = parentRecord[associationKey];

        if (action === "delete") {
          var index;
          childrenArray.forEach(function (id, index) {
            if (id === record.id)
              index = record.id;
          });
          record.splice(index, 1);
        }
        else if (action === "create") {
          childrenArray.push(record.id);
        }
        else if (action === "update") {
          // do nothing.
        }

        this.storage.setById(parentType, parentId, parentRecord);
        store.load(parentType, parentId, parentRecord);
      }
    }, this);
  }

});
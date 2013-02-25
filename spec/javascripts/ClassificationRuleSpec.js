(function() {

  describe('Classification Rule', function() {
    return it('test', function() {
      var callback;
      callback = sinon.spy();
      callback();
      return sinon.assert.calledOnce(callback);
    });
  });

}).call(this);

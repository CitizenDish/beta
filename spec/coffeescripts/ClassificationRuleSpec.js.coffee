describe 'Classification Rule', ->
  it 'test', ->
    callback = sinon.spy()
    callback()

    sinon.assert.calledOnce callback

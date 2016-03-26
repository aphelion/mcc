describe 'Builds routing' do
  it 'routes to #destroy' do
    fulfill 'DELETE /builds/#'
    stipulate(delete: '/builds/1').must route_to('builds#destroy', id: '1')
  end

  it 'routes to #webhook' do
    stipulate(post: '/builds/1/hook/circle').must route_to('builds#hook', id: '1', service: 'circle')
  end
end

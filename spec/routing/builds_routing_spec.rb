describe 'Builds routing' do
  it 'routes to #destroy' do
    fulfill 'DELETE /builds/#'
    stipulate(delete: '/builds/1').must route_to('builds#destroy', id: '1')
  end
end

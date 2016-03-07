describe 'Jobs routing' do
  it 'routes to #destroy' do
    fulfill 'DELETE /jobs/#'
    stipulate(delete: '/jobs/1').must route_to('jobs#destroy', id: '1')
  end
end

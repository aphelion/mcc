def all_fixtures(fixture_set)
  ActiveRecord::FixtureSet.all_loaded_fixtures[fixture_set.to_s].fixtures.collect { |fixture|
    fixture[1].model_class.new(fixture[1].fixture)
  }
end

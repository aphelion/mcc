module JobAttributes
  def self.valid_attributes
    {name: 'a job', status: 'passed'}
  end

  def self.updated_valid_attributes
    self.valid_attributes.merge({name: 'updated job'})
  end

  def self.invalid_attributes
    self.valid_attributes.merge({name: ''})
  end

  def self.updated_invalid_attributes
    self.invalid_attributes.merge({name: 'updated job'})
  end

  def self.extra_attributes
    self.valid_attributes.merge({danger: 'hackers afoot'})
  end

  def self.statuses
    {passed: 0, failed: 1}.stringify_keys
  end
end

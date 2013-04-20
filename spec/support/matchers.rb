RSpec::Matchers.define :be_an_array_of do |expected|
  match do |actual|
    ! actual.empty? && actual.all? { |el| el.is_a?(expected) }
  end
end

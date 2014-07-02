require 'spec_helper'
require 'jsonlint/linter'

describe 'Jsonlint::Linter' do
  let(:linter) { Jsonlint::Linter.new }

  it 'should throw an exception if given a bogus path' do
    expect { linter.check('/does/not/exist') }.to raise_error
  end

  it 'should be happy with a valid JSON file' do
    expect(linter.check(spec_data('valid.json'))).to be(true)
    expect(linter.check(spec_data('valid_array_of_objects.json'))).to be(true)
    expect(linter.check(spec_data('valid_array_of_arrays.json'))).to be(true)
  end

  it 'should be unhappy with an invalid JSON file' do
    expect(linter.check(spec_data('missing_comma.json'))).to be(false)
  end

  it 'should be unhappy with JSON that has overlapping keys' do
    expect(linter.check(spec_data('overlapping_keys.json'))).to be(false)
    expect(linter.check(spec_data('deep_overlap.json'))).to be(false)
  end
end
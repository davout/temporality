require_relative '../spec_helper'

RSpec.describe Temporality::AutoClose do

  context 'without auto-close enabled' do
    context 'when saving an overlapping child' do
      it 'should raise an error' do
        fail
      end
    end
  end

  context 'with auto-close enabled' do
    context 'when saving a partially overlapping child' do
      it 'should successfully save the child' do
        fail
      end

      it 'should have auto-closed the previous child' do
        fail
      end
    end

    context 'when saving a fully overlapping child' do
      it 'should fail to save the child' do
        fail
      end
    end
  end

end


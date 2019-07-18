require 'byebug'

RSpec.describe '/bin/trivia' do
  context 'when the random seed is 1234' do
    let(:seed) { 1234 }
    let(:golden_output) {
      File.read("./spec/bin/golden_output_#{seed}.txt")
    }

    it 'outputs the correct stuff' do
      ENV['TRIVIA_RANDOM_SEED'] = seed.to_s
      output = `./bin/trivia`
      expect(output).to eq(golden_output)
    end
  end

  context 'when the random seed is 4321' do
    let(:seed) { 4321 }
    let(:golden_output) {
      File.read("./spec/bin/golden_output_#{seed}.txt")
    }

    it 'outputs the correct stuff' do
      ENV['TRIVIA_RANDOM_SEED'] = seed.to_s
      output = `./bin/trivia`
      expect(output).to eq(golden_output)
    end
  end

  context 'when the random seed is 1111' do
    let(:seed) { 1111 }
    let(:golden_output) {
      File.read("./spec/bin/golden_output_#{seed}.txt")
    }

    it 'outputs the correct stuff' do
      ENV['TRIVIA_RANDOM_SEED'] = seed.to_s
      output = `./bin/trivia`
      expect(output).to eq(golden_output)
    end
  end

  context 'when the random seed is 2222' do
    let(:seed) { 2222 }
    let(:golden_output) {
      File.read("./spec/bin/golden_output_#{seed}.txt")
    }

    it 'outputs the correct stuff' do
      ENV['TRIVIA_RANDOM_SEED'] = seed.to_s
      output = `./bin/trivia`
      expect(output).to eq(golden_output)
    end
  end
end


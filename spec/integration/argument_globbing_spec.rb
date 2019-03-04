require 'spec_helper'

describe 'Glob patterns in arguments' do
  context 'brace expansion' do
    it 'expands to include each option' do
      GitshRunner.interactive do |gitsh|
        gitsh.type(':echo h{i,o}p')

        expect(gitsh).to output_no_errors
        expect(gitsh).to output(/hip hop/)
      end
    end

    it 'expands multiple expansions in one argument' do
      GitshRunner.interactive do |gitsh|
        gitsh.type(':echo h{i,o}{p,t,!}')

        expect(gitsh).to output_no_errors
        expect(gitsh).to output(/hip hit hi! hop hot ho!/)
      end
    end

    it 'expands empty options' do
      GitshRunner.interactive do |gitsh|
        gitsh.type(':echo git{,,sh,,}')

        expect(gitsh).to output_no_errors
        expect(gitsh).to output(/git git gitsh git git/)
      end
    end

    it 'expands nested expansions' do
      GitshRunner.interactive do |gitsh|
        gitsh.type(':echo f{{e,i,o}e,um}')

        expect(gitsh).to output_no_errors
        expect(gitsh).to output(/fee fie foe fum/)
      end
    end
  end
end

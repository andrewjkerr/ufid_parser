require 'spec_helper'

describe UfidParser do
    it 'has a version number' do
        expect(UfidParser::VERSION).not_to be nil
    end

    describe 'with a valid UFID number' do
        before { @expected = '12345678' }

        describe 'and the two UFID numbers match up' do
            before { @input = ';200123456780220012345678020?' }

            it 'correctly returns the UFID number' do
                expect(UfidParser::UFID.new(@input).ufid_number).to eq(@expected)
            end
        end

        describe 'and one UFID number is correct while the other is malformatted' do

            it 'correctly returns the first UFID number' do
                @input = ';20012345678022001234568020?'
                expect(UfidParser::UFID.new(@input).ufid_number).to eq(@expected)
            end

            it 'correctly returns the last UFID number' do
                @input = ';20012345680220012345678020?'
                expect(UfidParser::UFID.new(@input).ufid_number).to eq(@expected)
            end
        end
    end

    describe 'without a valid UFID number' do

        describe 'and both UFID numbers are not 8 characters' do

            describe 'and the same length' do 

                it 'throws an exception' do
                    @input = ';2001234568022001234568020?'
                    expect {
                        UfidParser::UFID.new(@input).ufid_number
                    }.to raise_error(Exception)
                end
            end

            describe 'and not the same length' do 

                it 'throws an exception' do
                    @input = ';200123458022001234568020?'
                    expect {
                        UfidParser::UFID.new(@input).ufid_number
                    }.to raise_error(Exception)
                end
            end
        end
    end
end
